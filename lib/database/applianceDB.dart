import 'package:flutter/material.dart';
import '../model/deviceItem.dart';

class applianceDB {
  static final applianceDB instance = applianceDB._init();
  final List<DeviceItem> _devices = [];

  applianceDB._init();

  List<DeviceItem> get devices => _devices;

  void insertDevice(DeviceItem device) {
    _devices.add(device);
  }

  List<DeviceItem> fetchDevices() {
    return _devices;
  }

  void updateDevice(DeviceItem device) {
    final index = _devices.indexWhere((d) => d.id == device.id);
    if (index != -1) {
      _devices[index] = device;
    }
  }

  void deleteDevice(String id) {
    _devices.removeWhere((device) => device.id == id);
  }
}
