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
  static final DateTime now = DateTime.now();
  // final String monthData = DateFormat("'Mês: ' MMMM").format(now);

  final data = [
    _Devices('Churrasqueira elétrica', 2500, 2, 2, 2),
    _Devices('Chuveiro Elétrico', 5000, 30, 0.33, 2),
    _Devices('Geladeira', 500, 30, 24, 2),
    _Devices('Lâmpada LED', 9, 30, 10, 9),
    _Devices('Computador', 450, 30, 8, 3),
    _Devices('Liquidificador', 200, 10, 0.66, 1),
    _Devices('Televisor', 90, 30, 2, 3),
    _Devices('Máquina de Lavar Louça', 1500, 30, 2, 1),
    _Devices('Máquina de Lavar Roupa', 1000, 15, 2, 1),
    _Devices('Condicionador de Ar', 1400, 30, 6, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
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
                (device.power * device.days * device.quantity * device.hours) /
                1000,
            color: AppColors.green,
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: true),
            xAxisName: 'Meses',
            yAxisName: 'Potência',
            name: '',
            animationDuration: 3,
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

  _Devices(this.name, this.power, this.days, this.hours, this.quantity);
}
