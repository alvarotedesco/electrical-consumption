import 'package:electrical_comsuption/dashboard/dashboard.dart';
import 'package:electrical_comsuption/device/devices.dart';
import 'package:electrical_comsuption/principal/principal.dart';
import 'package:electrical_comsuption/session_controller.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SessionController session = SessionController();

  int currentIndex = 0;

  List<Widget> items = [];

  @override
  void initState() {
    super.initState();

    items = [
      Principal(containerId: session.container!.id!),
      Devices(),
      Dashboard(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Scaffold(
          appBar: CustomAppBar(
            label: currentIndex == 0
                ? session.container!.name
                : currentIndex == 1
                    ? 'Meus Dispositivos'
                    : 'Estatisticas',
          ),
          body: items[currentIndex],

          // body: IndexedStack(
          //   index: currentIndex,
          //   children: items,
          // ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: AppColors.secondary,
            backgroundColor: AppColors.primary,
            selectedItemColor: AppColors.white,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tablet_mac_rounded),
                label: 'Dispositivos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.data_usage_sharp),
                label: 'Dashboard',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
