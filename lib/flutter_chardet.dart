import 'dart:typed_data';

import 'flutter_chardet_platform_interface.dart';

class FlutterChardet {
  Future<DecodingResult> autoDecode(Uint8List bytes) =>
      FlutterChardetPlatform.instance.autoDecode(bytes);

  Future<String> detect(Uint8List bytes) =>
      FlutterChardetPlatform.instance.detect(bytes);
}
