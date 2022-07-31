import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_app_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final data = [
    _Devices(
        name: 'Churrasqueira elétrica',
        power: 2500,
        days: 30,
        hours: 2,
        quantity: 2),
    _Devices(
        name: 'Chuveiro Elétrico',
        power: 5000,
        days: 30,
        hours: 0.33,
        quantity: 2),
    _Devices(name: 'Geladeira', power: 350, days: 30, hours: 24, quantity: 1),
    _Devices(name: 'Lâmpada LED', power: 9, days: 30, hours: 10, quantity: 9),
    _Devices(name: 'Computador', power: 450, days: 30, hours: 8, quantity: 3),
    _Devices(
        name: 'Liquidificador', power: 200, days: 30, hours: 16, quantity: 1),
    _Devices(name: 'Televisor', power: 90, days: 30, hours: 2, quantity: 3),
    _Devices(
        name: 'Máquina de Lavar Roupa',
        power: 1000,
        days: 30,
        hours: 2,
        quantity: 1),
    _Devices(
        name: 'Condicionador de Ar',
        power: 1400,
        days: 30,
        hours: 6,
        quantity: 2),
  ];

  double getNumber({power, days, hours, quantity}) {
    return double.parse(
        ((power * days * hours * quantity) / 1000).toStringAsFixed(2));
  }

  late SelectionBehavior _selectionBehavior;
  ScrollController seika = ScrollController();

  @override
  void initState() {
    _selectionBehavior = SelectionBehavior(
      enable: true,
      unselectedColor: AppColors.grey,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        controller: seika,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SfCircularChart(
            legend: Legend(
              textStyle: TextStyle(
                color: AppColors.white,
              ),
              orientation: LegendItemOrientation.vertical,
              // Legend title
              title: LegendTitle(
                text: 'Dispositivos',
                textStyle: TextStyle(
                  color: AppColors.white,
                ),
              ),
              isVisible: true,
              // Legend will be placed at the left
              position: LegendPosition.bottom,
              // Border color and border width of legend
              borderColor: AppColors.white,
              borderWidth: 2,
              isResponsive: true,
              // Overflowing legend content will be wraped
              // overflowMode: LegendItemOverflowMode.scroll,
              height: '50%',
            ),
            // Enables multiple selection
            enableMultiSelection: true,
            // Chart title
            title: ChartTitle(
              text: 'Consumo kWh',
              textStyle: TextStyle(
                color: AppColors.white,
              ),
            ),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries<_Devices, String>>[
              PieSeries<_Devices, String>(
                dataSource: data,
                xValueMapper: (_Devices device, index) {
                  return device.name;
                },
                yValueMapper: (_Devices device, index) {
                  return getNumber(
                    power: device.power,
                    days: device.days,
                    hours: device.hours,
                    quantity: device.quantity,
                  );
                },
                selectionBehavior: _selectionBehavior,

                // Enable data label
                dataLabelSettings: DataLabelSettings(
                  // Avoid labels intersection
                  labelIntersectAction: LabelIntersectAction.shift,
                  labelPosition: ChartDataLabelPosition.outside,
                  connectorLineSettings: ConnectorLineSettings(
                    type: ConnectorType.curve,
                    length: '25%',
                  ),
                  // Renders background rectangle and fills it with series color
                  useSeriesColor: true,
                  opacity: 1,
                  isVisible: true,
                  textStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Devices {
  final String name;
  final double power;
  final int days;
  final double hours;
  final int quantity;

  _Devices(
      {required this.name,
      required this.power,
      required this.days,
      required this.hours,
      required this.quantity});
}
