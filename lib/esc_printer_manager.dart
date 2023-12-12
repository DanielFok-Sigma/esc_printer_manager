import 'package:easy_logger/easy_logger.dart';

export 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
export 'package:flutter_imin_printer/flutter_imin_printer.dart';

export 'enums/bluetooth_printer_type.dart';
export 'enums/connection_response.dart';
export 'enums/connection_type.dart';
export 'models/bluetooth_printer.dart';
export 'models/imin_printer.dart';
export 'models/network_printer.dart';
export 'models/pos_printer.dart';
export 'models/usb_printer.dart';
export 'services/bluetooth_printer_manager.dart';
export 'services/imin_printer_manager.dart';
export 'services/network_printer_manager.dart';
export 'services/usb_printer_manager.dart';
export 'services/printer_manager.dart';

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
}
