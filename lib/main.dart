import 'package:electrical_comsuption/auth/login_page.dart';
import 'package:electrical_comsuption/auth/sign_up.dart';
import 'package:electrical_comsuption/container/containers.dart';
import 'package:electrical_comsuption/demo/demonstration_page.dart';
import 'package:electrical_comsuption/device/device_area.dart';
import 'package:electrical_comsuption/home.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/user/user_area.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electrical Consumption',
      home: Containers(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        '/login': (_) => LoginPage(),
        '/registry': (_) => SignUpPage(),
        '/painel': (_) => Containers(),
        '/home': (context) =>
            Home(painelId: ModalRoute.of(context)!.settings.arguments as int),
        '/demo': (_) => Demonstration(),
        '/user': (_) => UserArea(),
        '/editar-dispositivo': (context) => DeviceArea(
            device: ModalRoute.of(context)!.settings.arguments as DeviceModel),
        '/novo-dispositivo': (_) => DeviceArea(),
      },
    );
  }
}
