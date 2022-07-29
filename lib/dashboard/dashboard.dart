import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final data = [
    _Devices('Churrasqueira elétrica', 2500),
    _Devices('Chuveiro Elétrico', 5000),
    _Devices('Geladeira', 500),
    _Devices('Lâmpada LED', 9)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: 'Teste'),
        ),
        // Chart title
        title: ChartTitle(text: 'Dispositivos adicionados recentemente'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_Devices, String>>[
          ColumnSeries<_Devices, String>(
            dataSource: data,
            xValueMapper: (_Devices device, _) => device.name,
            yValueMapper: (_Devices device, _) => device.power,
            color: AppColors.green,
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: true),
            legendItemText: 'Consumo',
            xAxisName: 'Meses',
            yAxisName: 'Potência',
          ),
        ],
      ),
    );
  }
}

class _Devices {
  final String name;
  final double power;

  _Devices(this.name, this.power);
}
