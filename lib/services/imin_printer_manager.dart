import 'package:esc_printer_manager/enums/connection_response.dart';
import 'package:esc_printer_manager/services/printer_manager.dart';
import 'package:flutter_imin_printer/flutter_imin_printer.dart';
import 'package:flutter_imin_printer/models/column_text.dart';
import 'package:flutter_imin_printer/models/printer_text.dart';


class IminPrinterManager extends PrinterManager {

  final FlutterIminPrinter _flutterIminPrinter = FlutterIminPrinter();



  @override
  Future<ConnectionResponse> connect({Duration? timeout}) async {

    _flutterIminPrinter.initSDK();
    String result = await _flutterIminPrinter.getPrinterStatus() ?? '99';

    if (result == '0') {
      return ConnectionResponse.success;
    } else {
      return ConnectionResponse.timeout;
    }
  }


  Future<ConnectionResponse> printText(PrinterText text) async {
    await _flutterIminPrinter.printText(text);
    return ConnectionResponse.success;
  }

  Future<ConnectionResponse> printSpace() async {
    await _flutterIminPrinter.printSpace();
    return ConnectionResponse.success;
  }


  Future<ConnectionResponse> printLines({int lines = 1}) async {
    await _flutterIminPrinter.printLines(lines: lines);
    return ConnectionResponse.success;
  }

  Future<ConnectionResponse> printBarcode(String barcode) async {
    await _flutterIminPrinter.printBarcode(barcode);
    return ConnectionResponse.success;
  }


  Future<ConnectionResponse> printColumn(List<ColumnText> column) async {
    await _flutterIminPrinter.printColumn(column);
    return ConnectionResponse.success;
  }


  @override
  Future<ConnectionResponse> disconnect({Duration? timeout}) async {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<ConnectionResponse> writeBytes(List<int> data, {bool isDisconnect = true}) async {
    // TODO: implement writeBytes
    throw UnimplementedError();
  }

  //
}
