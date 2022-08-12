import 'package:electrical_comsuption/models/container_device.dart';
import 'package:electrical_comsuption/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardController controller = DashboardController();

  final _scrollController = ScrollController();
  late SelectionBehavior _selectionBehavior;

  double getNumber({power, days, hours, quantity}) {
    return double.parse(
        ((power * days * hours * quantity) / 1000).toStringAsFixed(2));
  }

  @override
  void initState() {
    super.initState();
    _selectionBehavior = SelectionBehavior(
      enable: true,
      unselectedColor: AppColors.grey,
    );
    controller.stateNotifier.addListener(() {
      setState(() {});
    });

    controller.getContainerDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
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
            onTooltipRender: (tooltip) {
              tooltip.header =
                  controller.data[tooltip.pointIndex as int].device.name;
            },
            series: <CircularSeries<ContainerDeviceModel, String>>[
              PieSeries<ContainerDeviceModel, String>(
                dataSource: controller.data,
                xValueMapper: (ContainerDeviceModel device, index) {
                  return device.device.name;
                },
                yValueMapper: (ContainerDeviceModel device, index) {
                  return getNumber(
                    power: device.device.power,
                    days: device.consuDays,
                    hours: device.consuTime,
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
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
