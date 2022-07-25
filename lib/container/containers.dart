import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:electrical_comsuption/principal/principal.dart';
import 'package:electrical_comsuption/themes/constants.dart';
import 'package:electrical_comsuption/user/user_area.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Containers extends StatefulWidget {
  const Containers({Key? key}) : super(key: key);

  @override
  State<Containers> createState() => _ContainersState();
}

class _ContainersState extends State<Containers> {
  TextEditingController panelController = TextEditingController();
  bool novo = false;

  Widget? _panels() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Paineis',
            style: AppTextStyles.defaultStyleB,
          ),
        ),
        for (var i = 0; i < 5; i++) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('Casa ${i + 1}'),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Principal(painelId: i.toString()),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20)
        ]
      ],
    );
  }

  Widget? _newPanel() {
    return Column(
      children: [
        SizedBox(height: 50),
        InputDecorationWidget(
          textInputType: TextInputType.name,
          controller: panelController,
          label: 'Nome do novo Painel',
          onSubmited: (val) {
            setState(() {
              novo = !novo;
              panelController.clear();
            });
          },
        ),
      ],
    );
  }

  // @override
  // void initState() {
  //   super.initState();

  //   getData(Underwear.listDevices).then((value) {
  //     if (value['status'] == 'success') {
  //       AppSnackBar().showSnack(context, "Erro ao pegar os dados");
  //     } else {
  //       AppSnackBar().showSnack(context, "Erro ao pegar os dados");
  //     }
  //   }).catchError((e) {
  //     AppSnackBar()
  //         .showSnack(context, "Erro inesperado, Erro ao pegar os dados");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppBar(canBack: false),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Novo',
        onPressed: () {
          setState(() {
            novo = !novo;
          });
        },
        child: Icon(Icons.add, size: 40),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: novo ? _newPanel() : _panels(),
      ),
    );
  }
}
