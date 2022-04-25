// ignore_for_file: file_names
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:electrical_comsuption/widgets/button_widget.dart';
import 'package:electrical_comsuption/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'themes/luvas.dart';
import 'login_page.dart';

class Demonstration extends StatefulWidget {
  const Demonstration({Key? key}) : super(key: key);

  @override
  State<Demonstration> createState() => _Demonstration();
}

class _Demonstration extends State<Demonstration> {
  final consWattsController = TextEditingController();
  final consHoursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Meias.imges),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Voltar'),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Voltar',
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              }),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Table(
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      border: TableBorder.all(
                        width: 3,
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      children: const [
                        TableRow(
                          children: <Widget>[
                            SizedBox(
                              width: 420,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.days,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 437,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.conskW,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 420,
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
                          children: <Widget>[
                            SizedBox(
                              width: 420,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.twentyDays,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 437,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.twentyConskW,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 420,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.twentyCostRS,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            SizedBox(
                              width: 420,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.thirtyDays,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 437,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.thirtyConskW,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 420,
                              child: Center(
                                heightFactor: 2,
                                child: Text(
                                  Luvas.thirtyCostRS,
                                  style: AppTextStyles.defaultStyleB,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                InputDecorationWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: consWattsController,
                  label: Luvas.consWatts,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                InputDecorationWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: consHoursController,
                  label: Luvas.consHours,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 50),
                AppButtonWidget(
                  texto: Luvas.calculate,
                  onPressed: () {
                    if (consWattsController.text.isEmpty ||
                        consHoursController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Preencha todos os campos!",
                            style: AppTextStyles.defaultWarning,
                          ),
                          backgroundColor: AppColors.white,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
