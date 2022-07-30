import 'dart:convert';

import 'package:electrical_comsuption/models/container.dart';
import 'package:electrical_comsuption/models/device.dart';

class ContainerDeviceModel {
  final ContainerModel container;
  final double consumptionTime;
  final DeviceModel device;
  final int containerId;
  final int deviceId;
  final int quantity;

  ContainerDeviceModel({
    required this.consumptionTime,
    required this.containerId,
    required this.container,
    required this.deviceId,
    required this.quantity,
    required this.device,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'consumptionTime': consumptionTime,
      'container': container.toMap(),
      'containerId': containerId,
      'device': device.toMap(),
      'deviceId': deviceId,
      'quantity': quantity,
    };
  }

  factory ContainerDeviceModel.fromMap(Map<String, dynamic> map) {
    return ContainerDeviceModel(
      device: DeviceModel.fromMap(map['device'] as Map<String, dynamic>),
      consumptionTime: map['consumption_time'] as double,
      containerId: map['container_id'] as int,
      deviceId: map['device_id'] as int,
      quantity: map['quantity'] as int,
      container:
          ContainerModel.fromMap(map['container'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerDeviceModel.fromJson(String source) =>
      ContainerDeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
