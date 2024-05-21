import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_chardet_platform_interface.dart';

/// An implementation of [FlutterChardetPlatform] that uses method channels.
class MethodChannelFlutterChardet extends FlutterChardetPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_chardet');

  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final data = (await methodChannel.invokeMapMethod('autoDecode', bytes) ??
        {'charset': 'unkown', 'string': ''}) as Map<String, dynamic>;
    return DecodingResult.fromJson(data);
  }

  @override
  Future<String> detect(Uint8List bytes) async {
    final data =
        (await methodChannel.invokeMethod('detect', bytes)) as String? ?? '';
    return data;
  }
}
