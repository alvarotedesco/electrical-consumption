import 'package:electrical_comsuption/principal.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListWidget extends StatelessWidget {
  final List devices;
  List<TextEditingController> hoursControllers = [];
  List<TextEditingController> daysControllers = [];
  List<TextEditingController> qtdControllers = [];

  ListWidget({Key? key, required this.devices}) : super(key: key);

  void save(type, key, value) async {
    var prefs = await SharedPreferences.getInstance();

    if (type == 'double') prefs.setDouble(key, value);
    if (type == 'int') prefs.setInt(key, value);
    if (type == 'string') prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white60, borderRadius: BorderRadius.circular(20)),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: devices.length,
          itemBuilder: (context, index) {
            save('int', 'qtdIndex', devices.length);
            save('double', 'pwrDevices$index', devices[index]["power"]);

            hoursControllers.add(TextEditingController());
            daysControllers.add(TextEditingController());
            qtdControllers.add(TextEditingController());

            hoursControllers[index].text = '0';
            daysControllers[index].text = '0';
            qtdControllers[index].text = '0';
            return ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        devices[index]["name"],
                        style: AppTextStyles.styleListB,
                      ),
                    ),
                    Container(
                      width: 70,
                      child: Center(
                        child: Text(
                          devices[index]["power"].toString(),
                          style: AppTextStyles.styleListB,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: TextField(
                        controller: hoursControllers[index],
                        style: AppTextStyles.styleListB,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (tex) async {
                          if (int.parse(tex) >= 24) {
                            hoursControllers[index].text = (24).toString();
                          }

                          save('string', 'hoursControls$index', tex);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: TextField(
                        controller: daysControllers[index],
                        style: AppTextStyles.styleListB,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (tex) async {
                          if (int.parse(tex) >= 99) {
                            daysControllers[index].text = (99).toString();
                          }

                          save('string', 'daysControls$index', tex);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      child: TextField(
                        controller: qtdControllers[index],
                        style: AppTextStyles.styleListB,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (tex) async {
                          if (int.parse(tex) >= 999) {
                            qtdControllers[index].text = (999).toString();
                          }

                          save('string', 'qtdControls$index', tex);
                        },
                      ),
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
