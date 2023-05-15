//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <esc_printer_manager/esc_printer_manager_plugin_c_api.h>
#include <printing/printing_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  EscPrinterManagerPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("EscPrinterManagerPluginCApi"));
  PrintingPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PrintingPlugin"));
}
