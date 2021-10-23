import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_connect/bottom_modal.dart';
import 'package:wifi_connect/wifi_module/wifi_module.dart';
import 'package:wifi_iot/wifi_iot.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WifiNetwork> _wifiNetworks = [];

  @override
  void initState() {
    super.initState();
    _getWifiList();
  }

  _getWifiList() async {
    bool b = await WifiModule.turnOnWifi();
    log(b.toString(), name: 'Wifi Status');
    _wifiNetworks = await WifiModule.getListOfWifi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wifi List'),
      ),
      body: ListView.builder(
        itemCount: _wifiNetworks.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text('${_wifiNetworks[index].ssid}'),
            trailing: IconButton(
              onPressed: () {
                if (_wifiNetworks[index].ssid == null) return;
                showModalBottomSheet(
                  context: context,
                  builder: (_) => BottomModal(
                    name: _wifiNetworks[index].ssid!,
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.globe,
              ),
            ),
          );
        },
      ),
    );
  }
}
