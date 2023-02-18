import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'esc_printer_manager_method_channel.dart';

abstract class EscPrinterManagerPlatform extends PlatformInterface {
  /// Constructs a EscPrinterManagerPlatform.
  EscPrinterManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static EscPrinterManagerPlatform _instance = MethodChannelEscPrinterManager();

  /// The default instance of [EscPrinterManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelEscPrinterManager].
  static EscPrinterManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EscPrinterManagerPlatform] when
  /// they register themselves.
  static set instance(EscPrinterManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
