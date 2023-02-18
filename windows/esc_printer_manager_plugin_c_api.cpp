#include "include/esc_printer_manager/esc_printer_manager_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "esc_printer_manager_plugin.h"

void EscPrinterManagerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  esc_printer_manager::EscPrinterManagerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
