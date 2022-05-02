import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/luvas.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final productController = TextEditingController();
  final nomeEqController = TextEditingController();
  final pwrEqController = TextEditingController();
  bool addEq = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voltar'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: (() {
            Navigator.pop(
              context,
            );
          }),
        ),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: <Widget>[
          Row(
            children: [
              IconButton(
                iconSize: 35,
                icon: Icon(Icons.add_circle),
                color: AppColors.white,
                onPressed: () {
                  setState(() {
                    addEq = !addEq;
                  });
                },
              ),
              InkWell(
                child: Text(
                  "Adicionar novo Equipamento",
                  style: AppTextStyles.defaultStyleB,
                ),
                onTap: () {
                  setState(() {
                    addEq = !addEq;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Visibility(
            visible: addEq,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: InputDecorationWidget(
                    controller: nomeEqController,
                    label: "Nome do dispositivo",
                    textInputType: TextInputType.name,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InputDecorationWidget(
                    controller: pwrEqController,
                    label: "Potencia (W)",
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: addEq,
            child: AppButtonWidget(
              texto: "Salvar",
              onPressed: () {
                setState(() {
                  addEq = !addEq;
                  pwrEqController.text = "";
                  nomeEqController.text = "";
                });
              },
            ),
          ),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(100)
            },
            border: TableBorder.all(
              width: 3,
              color: AppColors.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            children: [
              const TableRow(
                decoration: BoxDecoration(),
                children: <Widget>[
                  SizedBox(),
                  Center(
                    child: Text(
                      Luvas.days,
                      style: AppTextStyles.defaultStyleB,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox()
                ],
              ),
              TableRow(
                children: <Widget>[
                  const Center(
                    child: Text(
                      Luvas.twentyDays,
                      style: AppTextStyles.defaultStyleB,
                    ),
                  ),
                  Center(
                    child: Text(
                      Luvas.twentyConskW,
                      style: AppTextStyles.defaultStyleB,
                    ),
                  ),
                  Center(
                    child: Text(
                      Luvas.twentyCostRS,
                      style: AppTextStyles.defaultStyleB,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  const Center(
                    child: Text(
                      Luvas.thirtyDays,
                      style: AppTextStyles.defaultStyleB,
                    ),
                  ),
                  Center(
                    child: Text(
                      Luvas.thirtyConskW,
                      style: AppTextStyles.defaultStyleB,
                    ),
                  ),
                  Center(
                    child: Text(
                      Luvas.thirtyCostRS,
                      style: AppTextStyles.defaultStyleB,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
