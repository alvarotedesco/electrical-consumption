import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:electrical_comsuption/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../auth/login_page.dart';
import '../themes/constants.dart';

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

  void _calcDemo() {
    setState(() {
      twentyConskW = int.parse(Luvas.twentyDays) *
          double.parse(consHoursController.text) *
          double.parse(consWattsController.text) /
          1000;
      thirtyConskW = int.parse(Luvas.thirtyDays) *
          double.parse(consHoursController.text) *
          double.parse(consWattsController.text) /
          1000;
      yearConskW = int.parse(Luvas.yearDays) *
          double.parse(consHoursController.text) *
          double.parse(consWattsController.text) /
          1000;

      twentyCostRS = 1.04 * twentyConskW;
      thirtyCostRS = 1.04 * thirtyConskW;
      yearCostRS = 1.04 * yearConskW;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Meias.imges),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voltar'),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Voltar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(top: 30, left: 40, right: 40),
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    Luvas.simulationCalc,
                    style: AppTextStyles.defaultStyleB,
                  )),
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
                  TableRow(
                    children: const [
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            Luvas.days,
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            Luvas.conskW,
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            Luvas.costRS,
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            Luvas.twentyDays,
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            twentyConskW.toString().replaceAll('.', ','),
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            twentyCostRS
                                .toStringAsFixed(2)
                                .replaceAll('.', ','),
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            Luvas.thirtyDays,
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            thirtyConskW.toString().replaceAll('.', ','),
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            thirtyCostRS
                                .toStringAsFixed(2)
                                .replaceAll('.', ','),
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            Luvas.yearDays,
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            yearConskW.toString().replaceAll('.', ','),
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          heightFactor: 2,
                          child: Text(
                            yearCostRS.toStringAsFixed(2).replaceAll('.', ','),
                            style: AppTextStyles.defaultStyleB,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              InputDecorationWidget(
                onChanged: (val) {
                  _calcDemo();
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: consWattsController,
                label: Luvas.consWatts,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 15),
              InputDecorationWidget(
                onChanged: (val) {
                  _calcDemo();
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: consHoursController,
                label: Luvas.consHours,
                textInputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
