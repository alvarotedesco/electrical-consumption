import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../themes/constants.dart';
import 'snackbar_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool userArea;
  final String? label;
  final bool canBack;
  final bool noAuth;

  CustomAppBar({
    this.userArea = false,
    this.canBack = true,
    this.noAuth = false,
    this.label,
    super.key,
  }) : preferredSize = Size.fromHeight(50.0);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: widget.label != null
          ? Text(
              widget.label.toString(),
              style: AppTextStyles.h1WhiteBold,
            )
          : null,
      leading: widget.canBack
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              tooltip: Luvas.goBack,
              splashRadius: 20,
            )
          : SizedBox(),
      actions: widget.noAuth
          ? null
          : [
              IconButton(
                icon: Icon(Icons.lightbulb_outline),
                splashRadius: 20,
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(Underwear.dicasURL))) {
                    await launchUrl(Uri.parse(Underwear.dicasURL));
                  } else {
                    AppSnackBar().showSnack(
                        context, "Não foi possivel acessar as Dicas!");
                  }
                },
              ),
              if (!widget.userArea) ...[
                IconButton(
                  icon: Icon(Icons.account_circle),
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/user',
                    );
                  },
                ),
              ] else
                IconButton(
                  icon: Icon(Icons.logout_rounded),
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/login',
                    );
                  },
                ),
            ],
    );
  }
}
