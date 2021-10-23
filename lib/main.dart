import 'package:flutter/material.dart';

import 'home.dart';
import 'wifi_module/wifi_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WifiModule.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      // home: const FlutterWifiIoT(),
    );
  }
}
