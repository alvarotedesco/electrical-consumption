// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:electrical_comsuption/models/container.dart';
import 'package:electrical_comsuption/models/device.dart';

class ContainerDeviceModel {
  final ContainerModel? container;
  final DeviceModel device;
  final int containerId;
  final int deviceId;
  final double consuTime;
  final int consuDays;
  final int quantity;

  ContainerDeviceModel({
    required this.consuTime,
    required this.consuDays,
    required this.containerId,
    required this.deviceId,
    required this.quantity,
    required this.device,
    this.container,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'container': container?.toMap(),
      'device': device.toMap(),
      'container_id': containerId,
      'device_id': deviceId,
      'consu_time': consuTime,
      'consu_days': consuDays,
      'quantity': quantity,
    };
  }

  factory ContainerDeviceModel.fromMap(Map<String, dynamic> map) {
    return ContainerDeviceModel(
      container: map['container'] != null
          ? ContainerModel.fromMap(map['container'] as Map<String, dynamic>)
          : null,
      device: DeviceModel.fromMap(map['device'] as Map<String, dynamic>),
      containerId: map['container_id'] as int,
      deviceId: map['device_id'] as int,
      consuTime: map['consu_time'] as double,
      consuDays: map['consu_days'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerDeviceModel.fromJson(String source) =>
      ContainerDeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
