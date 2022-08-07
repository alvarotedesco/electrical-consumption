import 'package:electrical_comsuption/auth/login_page.dart';
import 'package:electrical_comsuption/auth/sign_up.dart';
import 'package:electrical_comsuption/container/container_area.dart';
import 'package:electrical_comsuption/container/containers.dart';
import 'package:electrical_comsuption/demo/demonstration_page.dart';
import 'package:electrical_comsuption/device/device_area.dart';
import 'package:electrical_comsuption/home.dart';
import 'package:electrical_comsuption/models/container.dart';
import 'package:electrical_comsuption/models/device.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/user/user_area.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consumo Elétrico',
      initialRoute: '/login',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      routes: {
        '/login': (_) => LoginPage(),
        '/registry': (_) => SignUpPage(),
        '/painel': (_) => Containers(),
        '/home': (context) {
          if (ModalRoute.of(context)!.settings.arguments == null) {
            return LoginPage();
          }
          return Home(
            containerId:
                (ModalRoute.of(context)!.settings.arguments as List)[0]!,
            name: (ModalRoute.of(context)!.settings.arguments as List)[1]!,
          );
        },
        '/demo': (_) => Demonstration(),
        '/user': (_) => UserArea(),
        '/editar-dispositivo': (context) {
          if (ModalRoute.of(context)!.settings.arguments == null) {
            return LoginPage();
          }
          return DeviceArea(
            device: ModalRoute.of(context)!.settings.arguments as DeviceModel,
          );
        },
        '/novo-dispositivo': (_) => DeviceArea(),
        '/novo-painel': (_) => ContainerArea(),
        '/editar-painel': (context) {
          if (ModalRoute.of(context)!.settings.arguments == null) {
            return LoginPage();
          }
          return ContainerArea(
            container:
                ModalRoute.of(context)!.settings.arguments as ContainerModel,
          );
        },
      },
    );
  }
}
