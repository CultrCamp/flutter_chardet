// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/foundation.dart';
import 'package:flutter_chardet/js_textdecoder.dart';
import 'package:flutter_chardet/jschardet_wrapper.dart' as jschardet;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_chardet_platform_interface.dart';

/// A web implementation of the FlutterChardetPlatform of the FlutterChardet plugin.
class FlutterChardetWeb extends FlutterChardetPlatform {
  /// Constructs a FlutterChardetWeb
  FlutterChardetWeb();

  static void registerWith(Registrar registrar) {
    if (kDebugMode) {
      jschardet.enableDebug();
    }
    FlutterChardetPlatform.instance = FlutterChardetWeb();
  }

  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final byteString = String.fromCharCodes(bytes);
    final detectedMap = jschardet.detect(byteString, null);
    final decoder = TextDecoder(detectedMap.encoding);
    debugPrint(
      'Detected result; '
      'encoding: ${detectedMap.encoding} (normalized to: ${decoder.encoding}), '
      'confidence: ${detectedMap.confidence}',
    );
    final decodedString = decoder.decode(bytes);
    return DecodingResult.fromJson({
      'charset': decoder.encoding,
      'string': decodedString,
    });
  }

  @override
  Future<String> detect(Uint8List bytes) async {
    final byteString = String.fromCharCodes(bytes);
    final detectedMap = jschardet.detect(byteString, null);
    return detectedMap.encoding;
  }
}
