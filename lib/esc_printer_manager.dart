
import 'package:easy_logger/easy_logger.dart';

import 'esc_printer_manager_platform_interface.dart';

class EscPrinterManager {

  static EasyLogger logger = EasyLogger(
    name: 'pos_printer_manager',
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
