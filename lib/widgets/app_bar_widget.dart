import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBarWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Voltar'),
      backgroundColor: AppColors.transparent,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (() {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => LoginPage(),
            //     ));
          })),
    );
  }
}
