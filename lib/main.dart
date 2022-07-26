import 'package:electrical_comsuption/container/containers.dart';
import 'package:electrical_comsuption/device/device_area.dart';
import 'package:electrical_comsuption/principal/principal.dart';
import 'package:electrical_comsuption/user/user_area.dart';
import 'package:flutter/material.dart';

import 'auth/login_page.dart';
import 'demo/demonstration_page.dart';
import 'device/devices.dart';
import 'home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electrical Consumption',
      home: Home(painelId: 1),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
