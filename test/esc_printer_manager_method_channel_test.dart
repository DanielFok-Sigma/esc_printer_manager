import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:esc_printer_manager/esc_printer_manager_method_channel.dart';

void main() {
  MethodChannelEscPrinterManager platform = MethodChannelEscPrinterManager();
  const MethodChannel channel = MethodChannel('esc_printer_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
