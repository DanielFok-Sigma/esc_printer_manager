import 'package:esc_printer_manager/enums/connection_response.dart';
import 'package:esc_printer_manager/models/imin_printer.dart';
import 'package:esc_printer_manager/services/printer_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_imin_printer/flutter_imin_printer.dart';
import 'package:flutter_imin_printer/models/barcode_text.dart';
import 'package:flutter_imin_printer/models/column_text.dart';
import 'package:flutter_imin_printer/models/printer_text.dart';


class IminPrinterManager extends PrinterManager {

  final FlutterIminPrinter _flutterIminPrinter = FlutterIminPrinter();



  @override
  Future<ConnectionResponse> connect({Duration? timeout}) async {

    try{
      _flutterIminPrinter.initSDK();
      String result = await _flutterIminPrinter.getPrinterStatus() ?? '99';

      if (result == '0') {
        return ConnectionResponse.success;
      } else {
        return ConnectionResponse.timeout;
      }
    } catch (e,s) {

      debugPrint('connect error: $e');
      debugPrint('connect stacktrace: $s');

      return ConnectionResponse.timeout;
    }


  }


  static Future<List<IminPrinter>> discover() async {
    var results = [
      IminPrinter(
        id: 'imin_printer',
        name: 'Imin Printer',
        address: '11:22:33:44:55:66',
        deviceId: 1,
        vendorId: 1,
        productId: 1,
      )
    ];
    return results;
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

  Future<ConnectionResponse> printBarcode(BarcodeText barcodeText) async {
    await _flutterIminPrinter.printBarcode(barcodeText);
    return ConnectionResponse.success;
  }


  Future<ConnectionResponse> printColumn(List<ColumnText> column) async {
    await _flutterIminPrinter.printColumn(column);
    return ConnectionResponse.success;
  }

  Future<ConnectionResponse> partialCut() async {
    await _flutterIminPrinter.partialCut();
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
