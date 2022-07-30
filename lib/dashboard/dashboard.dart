import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // static final DateTime now = DateTime.now();
  // final String monthData = DateFormat("'Mês: ' MMMM").format(now);
  static double kWhPrice = 1.04;

  final data = [
    _Devices(
        name: 'Churrasqueira elétrica',
        power: 2500,
        days: 2,
        hours: 2,
        quantity: 2),
    _Devices(
        name: 'Chuveiro Elétrico',
        power: 5000,
        days: 30,
        hours: 0.33,
        quantity: 2),
    _Devices(name: 'Geladeira', power: 500, days: 30, hours: 24, quantity: 2),
    _Devices(name: 'Lâmpada LED', power: 9, days: 30, hours: 10, quantity: 9),
    _Devices(name: 'Computador', power: 450, days: 30, hours: 8, quantity: 3),
    _Devices(
        name: 'Liquidificador', power: 200, days: 10, hours: 0.66, quantity: 1),
    _Devices(name: 'Televisor', power: 90, days: 30, hours: 2, quantity: 3),
    _Devices(
        name: 'Máquina de Lavar Louça',
        power: 1500,
        days: 30,
        hours: 2,
        quantity: 1),
    _Devices(
        name: 'Máquina de Lavar Roupa',
        power: 1000,
        days: 15,
        hours: 2,
        quantity: 1),
    _Devices(
        name: 'Condicionador de Ar',
        power: 1400,
        days: 30,
        hours: 6,
        quantity: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: 'Teste'),
        ),
        // Chart title
        title: ChartTitle(text: 'Consumo'),
        // Enable legend
        legend: Legend(
          isVisible: true,
          title: LegendTitle(text: 'Teste'),
        ),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_Devices, String>>[
          ColumnSeries<_Devices, String>(
            dataSource: data,
            xValueMapper: (_Devices device, _) => device.name,
            yValueMapper: (_Devices device, _) =>
                ((device.power * device.days * device.hours * device.quantity) /
                    1000) *
                kWhPrice,
            color: AppColors.green,
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: true),
            legendItemText: 'Consumo',
            name: '',
          ),
        ],
      ),
    );
  }
}

class _Devices {
  final String name;
  final int power;
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
