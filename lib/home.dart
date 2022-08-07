import 'package:electrical_comsuption/dashboard/dashboard.dart';
import 'package:electrical_comsuption/device/devices.dart';
import 'package:electrical_comsuption/principal/principal.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final int containerId;
  final String name;

  const Home({
    required this.containerId,
    required this.name,
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

    painelid = widget.containerId;

    items = [
      Principal(containerId: painelid!),
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
                ? widget.name
                : currentIndex == 1
                    ? 'Meus Dispositivos'
                    : 'Estatisticas',
          ),
          body: IndexedStack(
            index: currentIndex,
            children: items,
          ),
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
