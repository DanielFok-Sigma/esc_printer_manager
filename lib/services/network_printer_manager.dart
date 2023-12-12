import 'dart:io';

import 'package:flutter/material.dart';

import '../esc_printer_manager.dart';
import 'network_service.dart';

/// Network Printer
class NetworkPrinterManager extends PrinterManager {

  Generator? generator;
  Socket? socket;

  NetworkPrinterManager(
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

  /// [connect] let you connect to a network printer
  @override
  Future<ConnectionResponse> connect(
      {Duration? timeout = const Duration(seconds: 5)}) async {
    try {
      socket = await Socket.connect(address, port, timeout: timeout);
      isConnected = true;
      printer.connected = true;
      return Future<ConnectionResponse>.value(ConnectionResponse.success);
    } catch (e) {
      isConnected = false;
      printer.connected = false;
      return Future<ConnectionResponse>.value(ConnectionResponse.timeout);
    }
  }

  /// [discover] let you explore all netWork printer in your network
  static Future<List<NetworkPrinter>> discover() async {
    var results = await findNetworkPrinter();
    return [
      ...results
          .map((e) => NetworkPrinter(
                id: e,
                name: e,
                address: e,
                type: 0,
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
      debugPrint(socket.toString());
      socket?.add(data);
      if (isDisconnect) {
        await disconnect();
      }
      return ConnectionResponse.success;
    } catch (e) {
      EscPrinterManager.logger.error("Error : $e");
      return ConnectionResponse.printerNotConnected;
    }
  }

  /// [timeout]: milliseconds to wait after closing the socket
  @override
  Future<ConnectionResponse> disconnect({Duration? timeout}) async {
    await socket?.flush();
    await socket?.close();
    isConnected = false;
    if (timeout != null) {
      await Future.delayed(timeout, () => null);
    }
    return ConnectionResponse.success;
  }
}
