import 'package:electrical_comsuption/container/containers_controller.dart';
import 'package:electrical_comsuption/home.dart';
import 'package:electrical_comsuption/models/Containers.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/snackbar_widget.dart';

class Containers extends StatefulWidget {
  const Containers({Key? key}) : super(key: key);

  @override
  State<Containers> createState() => _ContainersState();
}

class _ContainersState extends State<Containers> {
  ContainersController controller = ContainersController();

  TextEditingController panelController = TextEditingController();
  bool novo = false;

  Widget? _panels() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Wrap(
            runSpacing: 5,
            spacing: 10,
            children: [
              for (var i = 0; i < 5; i++) ...[
                // for (var i = 0; i < controller.listContainers.length; i++) ...[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/home',
                      arguments: i,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Casa ${i + 1}',
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                        Column(
                          children: [
                            Wrap(
                              children: const [
                                Text(
                                  "Cons. total: ",
                                  style: AppTextStyles.defaultStyleB,
                                ),
                                Text(
                                  "${0.0} Kw/h",
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ],
                            ),
                            Text(
                              "Total: R\$ ${0.0}",
                              style: AppTextStyles.defaultStyleB,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget? _newPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputDecorationWidget(
          textInputType: TextInputType.name,
          label: 'Nome do novo Painel',
          controller: panelController,
          onSubmited: _saveNewPanel,
        ),
      ],
    );
  }

  void _saveNewPanel(String? name) {
    // TODO: salvar os paineis no banco

    ContainersModel container = ContainersModel(
      name: name.toString(),
    );

    controller.createContainer(container);
    setState(() {
      novo = !novo;
      panelController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    // TODO: pegar os Paineis do banco
    controller.listarContainers().then((value) {
      if (value['status'] == 'success') {
        AppSnackBar().showSnack(context, "Erro ao pegar os dados");
      } else {
        AppSnackBar().showSnack(context, "Erro ao pegar os dados");
      }
    }).catchError((e) {
      AppSnackBar()
          .showSnack(context, "Erro inesperado, Erro ao pegar os dados");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: CustomAppBar(
          canBack: false,
          label: 'Paineis',
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              tooltip: novo ? "Confirmar" : "Novo",
              onPressed: novo
                  ? () => _saveNewPanel(null)
                  : () {
                      setState(() {
                        novo = !novo;
                      });
                    },
              child: Icon(
                novo ? Icons.check : Icons.add,
                size: 40,
              ),
            ),
            if (novo) ...[
              SizedBox(height: 20),
              FloatingActionButton(
                tooltip: 'Cancelar',
                onPressed: () {
                  setState(() {
                    novo = !novo;
                    panelController.clear();
                  });
                },
                child: Icon(
                  Icons.clear,
                  size: 40,
                ),
              ),
            ],
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: novo ? _newPanel() : _panels(),
        ),
      ),
    );
  }
}
