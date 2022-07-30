import 'package:electrical_comsuption/container/container_controller.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/widgets/custom_app_bar.dart';
import 'package:electrical_comsuption/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';

import '../models/container.dart';
import '../widgets/input_decoration_widget.dart';

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

  int feeFlag = 0;

  void _saveNewPanel(String? name) {
    // TODO: salvar os paineis no banco

    ContainerModel container = ContainerModel(
      name: name.toString(),
      flag: 1,
      days: 30,
    );

    controller.createContainer(container);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(label: 'Novo Painel'),
        backgroundColor: AppColors.darkBlue,
        floatingActionButton: FloatingCustomButtonWidget(
          cancel: true,
          selected: false,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputDecorationWidget(
                textInputType: TextInputType.name,
                label: 'Nome do novo Painel',
                controller: nameController,
              ),
              SizedBox(height: 10),
              DropdownButton(
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                elevation: 5,
                value: feeFlag,
                items: controller.dropFlags.map<DropdownMenuItem<int>>((value) {
                  return DropdownMenuItem<int>(
                    value: value.id,
                    child: Row(
                      children: [
                        value.icon,
                        SizedBox(width: 20),
                        Text(value.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    feeFlag = value as int;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
