import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../themes/constants.dart';
import '../user/user_area.dart';
import 'snackbar_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool canBack;

  CustomAppBar({
    Key? key,
    this.canBack = true,
  })  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBlue,
      leading: widget.canBack
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              tooltip: 'Voltar',
              splashRadius: 20,
            )
          : null,
      actions: [
        IconButton(
          icon: Icon(Icons.lightbulb_outline),
          splashRadius: 20,
          onPressed: () async {
            if (await canLaunch(Underwear.dicasURL)) {
              await launch(Underwear.dicasURL);
            } else {
              AppSnackBar()
                  .showSnack(context, "Não foi possivel acessar as Dicas!");
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          splashRadius: 20,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserArea(),
              ),
            );
          },
        )
      ],
    );
  }
}
