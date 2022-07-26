import 'package:electrical_comsuption/container/containers.dart';
import 'package:electrical_comsuption/principal/principal.dart';
import 'package:flutter/material.dart';

import 'auth/login_page.dart';
import 'demo/demonstration_page.dart';
import 'device/device_area.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electrical Consumption',
      home: DeviceArea(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
