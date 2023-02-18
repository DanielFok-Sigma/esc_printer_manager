//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <esc_printer_manager/esc_printer_manager_plugin.h>
#include <printing/printing_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) esc_printer_manager_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "EscPrinterManagerPlugin");
  esc_printer_manager_plugin_register_with_registrar(esc_printer_manager_registrar);
  g_autoptr(FlPluginRegistrar) printing_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PrintingPlugin");
  printing_plugin_register_with_registrar(printing_registrar);
}
