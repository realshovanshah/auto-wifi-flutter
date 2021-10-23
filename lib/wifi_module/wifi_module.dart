import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiModule {
  static List<WifiNetwork> _wifiNetworks = [];
  static bool _isEnabled = false;
  static bool _isConnected = false;

  /// Init is must at start
  static Future<bool> init() async {
    _isEnabled = await WiFiForIoTPlugin.isEnabled();
    _isConnected = await WiFiForIoTPlugin.isConnected();

    try {
      _wifiNetworks = await WiFiForIoTPlugin.loadWifiList();
      _showWifiSsids();
      return Future.value(true);
    } on PlatformException {
      _wifiNetworks = [];
      _showWifiSsids();
      return Future.value(false);
    }
  }

  static void _showWifiSsids() {
    for (int i = 0; i < _wifiNetworks.length; i++) {
      log(
        "${i.toString()} -- ${_wifiNetworks[i].ssid}",
        name: 'Wifi[$i]',
      );
    }
    log("Done");
  }

  /// Turn on wifi dynamically
  static Future<bool> turnOnWifi() async {
    if (!_isEnabled) {
      _isEnabled = true;
      await WiFiForIoTPlugin.setEnabled(true);
      return Future.value(true);
    }
    return Future.value(false);
  }

  /// Turn off wifi dynamically
  static Future<bool> turnOffWifi() async {
    if (_isEnabled) {
      _isEnabled = false;
      await WiFiForIoTPlugin.setEnabled(false);
      return Future.value(true);
    }
    return Future.value(true);
  }

  /// Get a list of wifi
  static Future<List<WifiNetwork>> getListOfWifi() async {
    try {
      _wifiNetworks = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      _wifiNetworks = [];
    }
    _showWifiSsids();
    return Future.value(_wifiNetworks);
  }

  /// Connect wifi by name (SSID)
  static Future<bool> connectWifiByName(
    String wifiName, {
    required String password,
  }) async {
    _isConnected = await WiFiForIoTPlugin.connect(
      wifiName,
      security: NetworkSecurity.WPA,
      password: password,
    );

    if (_isConnected) {
      log("Connected");
      return Future.value(true);
    } else {
      log("Failed to connect");
      return Future.value(false);
    }
  }

  /// Disconnect a wifi
  static void disconnectWifi() {
    WiFiForIoTPlugin.disconnect();
  }

  /// Forget a wifi by its name ( SSID )
  static forgetWifiByWifiName(String wifiName) {
    return WiFiForIoTPlugin.removeWifiNetwork(wifiName);
  }
}
