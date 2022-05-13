import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:electrical_comsuption/themes/app_text_styles.dart';
import 'package:flutter/services.dart';

class ListWidget extends StatelessWidget {
  final List devices;
  List<TextEditingController> hoursControllers = [];
  List<TextEditingController> daysControllers = [];
  List<TextEditingController> qtdControllers = [];

  ListWidget({Key? key, required this.devices}) : super(key: key);

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
            hoursControllers.add(TextEditingController());
            daysControllers.add(TextEditingController());
            qtdControllers.add(TextEditingController());
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
                        onChanged: (tex) {
                          if (int.parse(tex) >= 24) {
                            hoursControllers[index].text = (24).toString();
                          }
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
                        onChanged: (tex) {
                          if (int.parse(tex) >= 99) {
                            daysControllers[index].text = (99).toString();
                          }
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
                        onChanged: (tex) {
                          if (int.parse(tex) >= 999) {
                            qtdControllers[index].text = (999).toString();
                          }
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
