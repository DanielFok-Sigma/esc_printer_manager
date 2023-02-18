//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import blue_thermal_printer
import esc_printer_manager
import network_info_plus
import printing

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  BlueThermalPrinterPlugin.register(with: registry.registrar(forPlugin: "BlueThermalPrinterPlugin"))
  EscPrinterManagerPlugin.register(with: registry.registrar(forPlugin: "EscPrinterManagerPlugin"))
  NetworkInfoPlusPlugin.register(with: registry.registrar(forPlugin: "NetworkInfoPlusPlugin"))
  PrintingPlugin.register(with: registry.registrar(forPlugin: "PrintingPlugin"))
}
