import 'package:flutter/material.dart';

class DeviceItem {
  String id;
  String name;
  String brand;
  bool isOn;

  DeviceItem({
    required this.id,
    required this.name,
    required this.brand,
    this.isOn = false,
  });
}
