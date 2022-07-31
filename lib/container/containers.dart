import 'package:electrical_comsuption/container/container_controller.dart';
import 'package:electrical_comsuption/container/container_state.dart';
import 'package:electrical_comsuption/models/container.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/floating_button_widget.dart';
import '../widgets/snackbar_widget.dart';

class Containers extends StatefulWidget {
  const Containers({super.key});

  @override
  State<Containers> createState() => _ContainersState();
}

class _ContainersState extends State<Containers> {
  final controller = ContainerController();

  bool edit = false;
  bool onLong = false;
  ContainerModel? _containerSelected;

  Widget? _panels() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Center(
        child: Wrap(
          runSpacing: 5,
          spacing: 10,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            for (var i = 0; i < controller.listContainers.length; i++) ...[
              GestureDetector(
                onLongPress: () {
                  if (_containerSelected != null) {
                    if (_containerSelected == controller.listContainers[i]) {
                      setState(() {
                        _containerSelected = null;
                      });
                    } else {
                      setState(() {
                        _containerSelected = null;
                        _containerSelected = controller.listContainers[i];
                      });
                    }
                  } else {
                    setState(() {
                      _containerSelected = controller.listContainers[i];
                    });
                  }
                },
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
                    color: _containerSelected == controller.listContainers[i]
                        ? AppColors.secondary
                        : AppColors.primary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          controller.listContainers[i].name,
                          style: AppTextStyles.defaultStyleB,
                        ),
                      ),
                      if (_containerSelected == controller.listContainers[i])
                        Center(
                          child: Icon(
                            Icons.check,
                            size: 50,
                            color: AppColors.white,
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
      ),
    );
  }

  Widget _errorWidget() {
    return controller.state == ContainerState.loading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.secondary,
            ),
          )
        : controller.state == ContainerState.empty
            ? Center(
                child: Text(
                  "Não há Paineis para Listar",
                  style: AppTextStyles.defaultStyleB,
                ),
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Erro ao pegar os dados",
                      style: AppTextStyles.defaultStyleB,
                    ),
                    AppButtonWidget(
                      onPressed: () => _init(),
                      texto: 'Tentar novamente',
                    )
                  ],
                ),
              );
  }

  void _init() {
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

  void clear() {
    setState(() {
      edit = false;
      onLong = false;
      _containerSelected = null;
    });
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    // TODO: pegar os Paineis do banco
    _init();
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
        floatingActionButton: FloatingCustomButtonWidget(
          selected: _containerSelected != null,
          onNewButton: () async {
            await Navigator.pushNamed(context, '/novo-painel');
            clear();
          },
          onEditButton: () async {
            await Navigator.pushNamed(
              context,
              '/editar-painel',
              arguments: _containerSelected,
            );
            clear();
          },
          onDeleteButton: () {
            controller.deleteContainer(_containerSelected!.id as int);
            clear();
          },
        ),
        body: controller.state != ContainerState.success
            ? _errorWidget()
            : _panels(),
      ),
    );
  }
}
