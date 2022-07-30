import 'package:electrical_comsuption/device/devices.dart';
import 'package:electrical_comsuption/principal/principal.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final int painelId;

  const Home({
    required this.painelId,
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  int? painelid;
  List<Widget> items = [];

  @override
  void initState() {
    super.initState();

    painelid = widget.painelId;

    items = [
      Principal(painelId: painelid ?? 0),
      Devices(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: items,
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: AppColors.white,
            backgroundColor: AppColors.secondary,
            selectedItemColor: AppColors.primary,
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
            ],
          ),
        ),
      ),
    );
  }
}
