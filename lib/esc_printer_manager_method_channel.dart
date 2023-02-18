import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'esc_printer_manager_platform_interface.dart';

/// An implementation of [EscPrinterManagerPlatform] that uses method channels.
class MethodChannelEscPrinterManager extends EscPrinterManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('esc_printer_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
