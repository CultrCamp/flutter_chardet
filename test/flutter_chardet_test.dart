import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chardet/flutter_chardet.dart';
import 'package:flutter_chardet/flutter_chardet_platform_interface.dart';
import 'package:flutter_chardet/flutter_chardet_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterChardetPlatform
    with MockPlatformInterfaceMixin
    implements FlutterChardetPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterChardetPlatform initialPlatform = FlutterChardetPlatform.instance;

  test('$MethodChannelFlutterChardet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterChardet>());
  });

  test('getPlatformVersion', () async {
    FlutterChardet flutterChardetPlugin = FlutterChardet();
    MockFlutterChardetPlatform fakePlatform = MockFlutterChardetPlatform();
    FlutterChardetPlatform.instance = fakePlatform;

    expect(await flutterChardetPlugin.getPlatformVersion(), '42');
  });
}
