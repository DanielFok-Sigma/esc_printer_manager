

import 'dart:io';

import 'package:esc_printer_manager/esc_printer_manager.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../helpers/network_analyzer.dart';

class NetworkService {}

Future<List<String>> findNetworkPrinter({int port = 9100}) async {
  final info = NetworkInfo();
  String? ip = await (info.getWifiIP());
  if (ip?.isEmpty == true) {
    ip = (await getAddresses()).first;
  }
  EscPrinterManager.logger.info("ip: $ip");
  final String subnet = ip!.substring(0, ip.lastIndexOf('.'));
  EscPrinterManager.logger.info("subnet: $subnet");

  final stream = NetworkAnalyzer.discover2(subnet, port);
  var results = await stream.toList();
  return [
    ...results.where((entry) => entry.exists).toList().map((e) => e.ip).toList()
  ];
}

Future<List<String>> getAddresses() async {
  var interfaces = await NetworkInterface.list();
  List<String> results = [];
  interfaces.fold(results,
          (dynamic pre, e) => results.addAll(e.addresses.map((e) => e.address).toList()));
  return results;
}
