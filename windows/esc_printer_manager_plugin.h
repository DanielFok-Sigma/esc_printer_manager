#ifndef FLUTTER_PLUGIN_ESC_PRINTER_MANAGER_PLUGIN_H_
#define FLUTTER_PLUGIN_ESC_PRINTER_MANAGER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace esc_printer_manager {

class EscPrinterManagerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  EscPrinterManagerPlugin();

  virtual ~EscPrinterManagerPlugin();

  // Disallow copy and assign.
  EscPrinterManagerPlugin(const EscPrinterManagerPlugin&) = delete;
  EscPrinterManagerPlugin& operator=(const EscPrinterManagerPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace esc_printer_manager

#endif  // FLUTTER_PLUGIN_ESC_PRINTER_MANAGER_PLUGIN_H_
