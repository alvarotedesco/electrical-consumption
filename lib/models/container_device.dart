// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:electrical_comsuption/models/container.dart';
import 'package:electrical_comsuption/models/device.dart';

class ContainerDeviceModel {
  final ContainerModel container;
  final DeviceModel device;
  final int containerId;
  final int deviceId;
  final double consTimeHours;
  final int consTimeDays;
  final int quantity;

  ContainerDeviceModel({
    required this.consTimeHours,
    required this.consTimeDays,
    required this.containerId,
    required this.container,
    required this.deviceId,
    required this.quantity,
    required this.device,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'container': container.toMap(),
      'device': device.toMap(),
      'containerId': containerId,
      'deviceId': deviceId,
      'consTimeHour': consTimeHours,
      'consTimeDays': consTimeDays,
      'quantity': quantity,
    };
  }

  factory ContainerDeviceModel.fromMap(Map<String, dynamic> map) {
    return ContainerDeviceModel(
      container:
          ContainerModel.fromMap(map['container'] as Map<String, dynamic>),
      device: DeviceModel.fromMap(map['device'] as Map<String, dynamic>),
      containerId: map['containerId'] as int,
      deviceId: map['deviceId'] as int,
      consTimeHours: map['consTimeHour'] as double,
      consTimeDays: map['consTimeDays'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerDeviceModel.fromJson(String source) =>
      ContainerDeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
