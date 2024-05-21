#include "include/flutter_chardet/flutter_chardet_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_chardet_plugin.h"

void FlutterChardetPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_chardet::FlutterChardetPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
