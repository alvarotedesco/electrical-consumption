import 'dart:math';

import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../auth/login_page.dart';
import '../themes/constants.dart';
import '../widgets/custom_app_bar.dart';

class Demonstration extends StatefulWidget {
  const Demonstration({Key? key}) : super(key: key);

  @override
  State<Demonstration> createState() => _Demonstration();
}

class _Demonstration extends State<Demonstration> {
  final consWattsController = TextEditingController();
  final consHoursController = TextEditingController();

  double twentyCostRS = 0;
  double twentyConskW = 0;
  double thirtyConskW = 0;
  double thirtyCostRS = 0;
  double yearConskW = 0;
  double yearCostRS = 0;

  double kWhCost = 1.04;

  void _calcDemo() {
    if (consHoursController.text.isNotEmpty &&
        consWattsController.text.isNotEmpty) {
      var kWh = int.parse(consWattsController.text) *
          int.parse(consHoursController.text) /
          1000;

      setState(() {
        twentyConskW = int.parse(Luvas.twentyDays) * kWh;
        thirtyConskW = int.parse(Luvas.thirtyDays) * kWh;
        yearConskW = int.parse(Luvas.yearDays) * kWh;
        twentyCostRS = kWhCost * twentyConskW;
        thirtyCostRS = kWhCost * thirtyConskW;
        yearCostRS = kWhCost * yearConskW;
      });
    }
  }

  TableRow _rowTable({required um, required dois, required tres}) {
    var lis = [um, dois, tres];

    return TableRow(
      children: [
        for (var i in lis)
          Row(
            children: [
              Expanded(
                child: Center(
                  heightFactor: 2,
                  child: Text(
                    i,
                    style: AppTextStyles.defaultStyleB,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          label: Luvas.simulationCalc,
          noAuth: true,
        ),
        backgroundColor: AppColors.darkBlue,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Table(
                defaultColumnWidth: IntrinsicColumnWidth(),
                border: TableBorder.all(
                  width: 3,
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                children: [
                  _rowTable(
                    um: Luvas.days,
                    dois: Luvas.conskW,
                    tres: Luvas.costRS,
                  ),
                  _rowTable(
                    um: Luvas.twentyDays,
                    dois: twentyConskW.toString().replaceAll('.', ','),
                    tres: twentyCostRS.toStringAsFixed(2).replaceAll('.', ','),
                  ),
                  _rowTable(
                    um: Luvas.thirtyDays,
                    dois: thirtyConskW.toString().replaceAll('.', ','),
                    tres: thirtyCostRS.toStringAsFixed(2).replaceAll('.', ','),
                  ),
                  _rowTable(
                    um: Luvas.yearDays,
                    dois: yearConskW.toString().replaceAll('.', ','),
                    tres: yearCostRS.toStringAsFixed(2).replaceAll('.', ','),
                  ),
                ],
              ),
              SizedBox(height: 50),
              InputDecorationWidget(
                textInputType: TextInputType.number,
                controller: consWattsController,
                label: Luvas.consWatts,
                onChanged: (val) {
                  if (int.parse(val) > 99999999) {
                    consWattsController.text = '99999999';
                  }
                  _calcDemo();
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 15),
              InputDecorationWidget(
                textInputType: TextInputType.number,
                controller: consHoursController,
                label: Luvas.consHours,
                onChanged: (val) {
                  if (int.parse(val) > 24) {
                    consHoursController.text = '24';
                  }
                  _calcDemo();
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
