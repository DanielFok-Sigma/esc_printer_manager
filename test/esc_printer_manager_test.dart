import 'package:flutter_test/flutter_test.dart';
import 'package:esc_printer_manager/esc_printer_manager.dart';
import 'package:esc_printer_manager/esc_printer_manager_platform_interface.dart';
import 'package:esc_printer_manager/esc_printer_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEscPrinterManagerPlatform
    with MockPlatformInterfaceMixin
    implements EscPrinterManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EscPrinterManagerPlatform initialPlatform = EscPrinterManagerPlatform.instance;

  test('$MethodChannelEscPrinterManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEscPrinterManager>());
  });

  test('getPlatformVersion', () async {
    EscPrinterManager escPrinterManagerPlugin = EscPrinterManager();
    MockEscPrinterManagerPlatform fakePlatform = MockEscPrinterManagerPlatform();
    EscPrinterManagerPlatform.instance = fakePlatform;

    expect(await escPrinterManagerPlugin.getPlatformVersion(), '42');
  });
}
