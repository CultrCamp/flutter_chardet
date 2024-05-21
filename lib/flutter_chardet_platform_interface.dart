import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_chardet_method_channel.dart';

class DecodingResult {
  DecodingResult.fromJson(Map<String, dynamic> json)
      : this._(
          json['charset'] as String,
          json['string'] as String,
        );

  DecodingResult._(this.charset, this.string);

  /// The original charset of [string]
  final String charset;

  /// The decoded string
  final String string;
}

abstract class FlutterChardetPlatform extends PlatformInterface {
  /// Constructs a FlutterChardetPlatform.
  FlutterChardetPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterChardetPlatform _instance = MethodChannelFlutterChardet();

  /// The default instance of [FlutterChardetPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterChardet].
  static FlutterChardetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterChardetPlatform] when
  /// they register themselves.
  static set instance(FlutterChardetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<DecodingResult> autoDecode(Uint8List bytes) {
    throw UnimplementedError("autoDecode() has not been implemented.");
  }

  Future<String> detect(Uint8List bytes) {
    throw UnimplementedError("detect() has not been implemented.");
  }
}
