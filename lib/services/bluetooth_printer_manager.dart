import 'dart:io';
import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart' as thermal;
import 'package:esc_printer_manager/esc_printer_manager.dart';
import 'package:flutter/material.dart';

import '../models/pos_printer.dart';
import 'bluetooth_service.dart';
import 'printer_manager.dart';

/// Bluetooth Printer
class BluetoothPrinterManager extends PrinterManager {

  Generator? generator;
  thermal.BlueThermalPrinter bluetooth = thermal.BlueThermalPrinter.instance;

  // fblue.FlutterBlue flutterBlue = fblue.FlutterBlue.instance;
  // fblue.BluetoothDevice fbdevice;

  BluetoothPrinterManager(
    POSPrinter printer,
    PaperSize paperSize,
    CapabilityProfile profile, {
    int spaceBetweenRows = 5,
    int port = 9100,
  }) {
    super.printer = printer;
    super.address = printer.address;
    super.paperSize = paperSize;
    super.profile = profile;
    super.spaceBetweenRows = spaceBetweenRows;
    super.port = port;
    generator =
        Generator(paperSize, profile, spaceBetweenRows: spaceBetweenRows);
  }

  /// [connect] let you connect to a bluetooth printer
  @override
  Future<ConnectionResponse> connect(
      {Duration? timeout = const Duration(seconds: 5)}) async {
    try {
// if (Platform.isIOS) {
// fbdevice = fblue.BluetoothDevice.fromProto(proto.BluetoothDevice(
//     name: printer.name,
//     remoteId: printer.address,
//     type: proto.BluetoothDevice_Type.valueOf(printer.type)));
// var connected = await flutterBlue.connectedDevices;
// var index = connected?.indexWhere((e) => e.id == fbdevice.id);
// if (index < 0) await fbdevice.connect();

// } else
      if (Platform.isAndroid || Platform.isIOS) {
        var device = thermal.BluetoothDevice(printer.name, printer.address);
        await bluetooth.connect(device);
      }

      isConnected = true;
      printer.connected = true;
      return Future<ConnectionResponse>.value(ConnectionResponse.success);
    } catch (e) {
      isConnected = false;
      printer.connected = false;
      return Future<ConnectionResponse>.value(ConnectionResponse.timeout);
    }
  }

  /// [discover] let you explore all bluetooth printer nearby your device
  static Future<List<BluetoothPrinter>> discover() async {
    var results = await BluetoothService.findBluetoothDevice();
    return [
      ...results
          .map((e) => BluetoothPrinter(
                id: e.address,
                name: e.name,
                address: e.address,
                type: e.type,
              ))
          .toList()
    ];
  }

  /// [writeBytes] let you write raw list int data into socket
  @override
  Future<ConnectionResponse> writeBytes(List<int> data,
      {bool isDisconnect = true}) async {
    try {
      if (!isConnected) {
        await connect();
      }
      if (Platform.isAndroid || Platform.isIOS) {
        final isConnect = await bluetooth.isConnected;
        if (isConnect ?? false) {
          Uint8List message = Uint8List.fromList(data);
          EscPrinterManager.logger.warning("message.length ${message.length}");
          await bluetooth.writeBytes(message);
          if (isDisconnect) {
            await disconnect();
          }
          return ConnectionResponse.success;
        }
        return ConnectionResponse.printerNotConnected;
      }
//  else if (Platform.isIOS) {
//   // var services = (await fbdevice.discoverServices());
//   // var service = services.firstWhere((e) => e.isPrimary);
//   // var charactor =
//   //     service.characteristics.firstWhere((e) => e.properties.write);
//   // await charactor?.write(data, withoutResponse: true);
//   return ConnectionResponse.success;
// }
      return ConnectionResponse.unsupported;
    } catch (e) {
      debugPrint("Error : $e");
      return ConnectionResponse.unknown;
    }
  }

  /// [timeout]: milliseconds to wait after closing the socket
  @override
  Future<ConnectionResponse> disconnect({Duration? timeout}) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await bluetooth.disconnect();
      isConnected = false;
    }
//  else if (Platform.isIOS) {
// await fbdevice.disconnect();
// this.isConnected = false;
// }

    if (timeout != null) {
      await Future.delayed(timeout, () => null);
    }
    return ConnectionResponse.success;
  }
}
