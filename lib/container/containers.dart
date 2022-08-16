import 'package:electrical_comsuption/container/container_controller.dart';
import 'package:electrical_comsuption/container/container_state.dart';
import 'package:electrical_comsuption/models/container.dart';
import 'package:electrical_comsuption/session_controller.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/floating_button_widget.dart';

class Containers extends StatefulWidget {
  const Containers({super.key});

  @override
  State<Containers> createState() => _ContainersState();
}

class _ContainersState extends State<Containers> {
  final controller = ContainerController();
  final SessionController session = SessionController();

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
                        _containerSelected = controller.listContainers[i];
                      });
                    }
                  } else {
                    setState(() {
                      _containerSelected = controller.listContainers[i];
                    });
                  }
                },
                onTap: () async {
                  session.container = controller.listContainers[i];
                  await Navigator.pushNamed(
                    context,
                    '/home',
                  );
                  _init();
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
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topRight,
                    children: [
                      Positioned(
                        top: -20,
                        right: -20,
                        child: Icon(
                          Icons.flag,
                          size: 30,
                          color: AppColors()
                              .selectColor(controller.listContainers[i].flagId),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              controller.listContainers[i].name,
                              style: AppTextStyles.h1WhiteBold,
                            ),
                          ),
                          if (_containerSelected ==
                              controller.listContainers[i])
                            Center(
                              child: Icon(
                                Icons.check,
                                size: 50,
                                color: AppColors.white,
                              ),
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dispositivos: ${controller.listContainers[i].qtdDevices}",
                                style: AppTextStyles.h3WhiteBold,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "Consumo: ",
                                    style: AppTextStyles.h3WhiteBold,
                                  ),
                                  Text(
                                    "${NumberFormat('##0.0#', 'pt_BR').format(controller.listContainers[i].kwTotal)} kWh",
                                    style: AppTextStyles.h3WhiteBold,
                                  ),
                                ],
                              ),
                              Text(
                                "Gasto: R\$ ${NumberFormat('##0.0#', 'pt_BR').format(controller.listContainers[i].rsTotal)}",
                                style: AppTextStyles.h3WhiteBold,
                              ),
                            ],
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
                  style: AppTextStyles.h1WhiteBold,
                ),
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Erro ao pegar os dados",
                      style: AppTextStyles.h1WhiteBold,
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
    controller.listarContainers();
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
            _init();
          },
          onEditButton: () async {
            await Navigator.pushNamed(
              context,
              '/editar-painel',
              arguments: _containerSelected,
            );
            clear();
            _init();
          },
          onDeleteButton: () {
            controller.deleteContainer(_containerSelected!.id as int);
            clear();
            _init();
          },
        ),
        body: controller.state != ContainerState.success
            ? _errorWidget()
            : _panels(),
      ),
    );
  }
}
