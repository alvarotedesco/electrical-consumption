import 'dart:async';

import 'package:electrical_comsuption/container/container_controller.dart';
import 'package:electrical_comsuption/models/flag.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';

import '../models/container.dart';
import '../widgets/input_decoration_widget.dart';
import 'container_state.dart';

class ContainerArea extends StatefulWidget {
  final ContainerModel? container;

  const ContainerArea({
    this.container,
    super.key,
  });

  @override
  State<ContainerArea> createState() => _ContainerAreaState();
}

class _ContainerAreaState extends State<ContainerArea> {
  final controller = ContainerController();

  final nameController = TextEditingController();

  FlagModel feeFlag = FlagModel(
    name: 'Bandeira Verde',
    plus: 0,
    id: 1,
    icon: 1,
  );

  Color _selectColor(int color) {
    return color == 1
        ? AppColors.green
        : color == 2
            ? AppColors.yellow
            : color == 3
                ? AppColors.red
                : color == 4
                    ? AppColors.darkRed
                    : AppColors.grey;
  }

  Future<void> _saveNewPanel(String? name) async {
    // TODO: salvar os paineis no banco

    var container = ContainerModel(
      name: name as String,
      flagId: feeFlag.id,
      flag: feeFlag,
    );

    await controller.createContainer(container);
  }

  Future<void> _editPanel(String? name) async {
    var container = ContainerModel(
      id: widget.container!.id,
      name: name as String,
      flagId: feeFlag.id,
      flag: feeFlag,
    );

    await controller.saveContainer(container);
  }

  Widget? _errorWidget() {
    return controller.state == ContainerState.loading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.secondary,
            ),
          )
        : null;
  }

  @override
  void initState() {
    super.initState();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    controller.getFlags().then((value) => feeFlag = controller.dropFlags.first);

    if (widget.container != null) {
      nameController.text = widget.container!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            label: widget.container != null ? 'Editar Painel' : 'Novo Painel'),
        backgroundColor: AppColors.darkBlue,
        floatingActionButton: FloatingCustomButtonWidget(
          cancel: true,
          selected: false,
          heroTagConfirm: 'caConfirm',
          heroTagCancel: 'caCancel',
          onConfirmButton: () {
            if (widget.container != null) {
              _editPanel(nameController.text);
            } else {
              _saveNewPanel(nameController.text);
            }
            Navigator.of(context).pop();
          },
          onCancelButton: () => Navigator.of(context).pop(),
        ),
        body: controller.state != ContainerState.success
            ? _errorWidget()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputDecorationWidget(
                      textInputType: TextInputType.name,
                      label: 'Nome do Painel',
                      controller: nameController,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        underline: SizedBox(height: 0),
                        iconSize: 25,
                        elevation: 5,
                        dropdownColor: AppColors.primary,
                        style: AppTextStyles.h1WhiteBold,
                        value: feeFlag,
                        items: controller.dropFlags
                            .map<DropdownMenuItem<FlagModel>>(
                          (value) {
                            return DropdownMenuItem<FlagModel>(
                              value: value,
                              child: Row(
                                children: [
                                  Icon(Icons.flag,
                                      color: _selectColor(value.icon)),
                                  SizedBox(width: 20),
                                  Text(value.name),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            feeFlag = value as FlagModel;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
