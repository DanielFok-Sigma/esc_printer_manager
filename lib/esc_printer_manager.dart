
import 'package:easy_logger/easy_logger.dart';

import 'esc_printer_manager_platform_interface.dart';

export 'models/network_printer.dart';
export 'models/bluetooth_printer.dart';
export 'models/usb_printer.dart';
export 'services/bluetooth_printer_manager.dart';
export 'services/network_printer_manager.dart';
export 'services/usb_printer_manager.dart';
export 'enums/bluetooth_printer_type.dart';
export 'enums/connection_response.dart';
export 'enums/connection_type.dart';
export 'package:esc_pos_utils_plus/esc_pos_utils.dart';

class EscPrinterManager {

  static EasyLogger logger = EasyLogger(
    name: 'esc_printer_manager',
    defaultLevel: LevelMessages.debug,
    enableBuildModes: [BuildMode.debug, BuildMode.profile, BuildMode.release],
    enableLevels: [
      LevelMessages.debug,
      LevelMessages.info,
      LevelMessages.error,
      LevelMessages.warning
    ],
  );

  Future<String?> getPlatformVersion() {
    return EscPrinterManagerPlatform.instance.getPlatformVersion();
  }
}
