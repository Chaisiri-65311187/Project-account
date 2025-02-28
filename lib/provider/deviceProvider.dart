import 'package:flutter/material.dart';
import '../model/deviceItem.dart';
import '../database/applianceDB.dart';

class DeviceProvider with ChangeNotifier {
  final applianceDB _db = applianceDB.instance;
  List<DeviceItem> _devices = [];

  List<DeviceItem> get devices => _devices;

  void loadDevices() {
    _devices = _db.fetchDevices();
    notifyListeners();
  }

  void addDevice(String name, String brand) {
    final newDevice = DeviceItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      brand: brand,
      isOn: false,
    );
    _db.insertDevice(newDevice);
    loadDevices();
  }

  void toggleDeviceStatus(int index) {
    if (index >= 0 && index < _devices.length) {
      _devices[index].isOn = !_devices[index].isOn;
      _db.updateDevice(_devices[index]);
      notifyListeners();
    }
  }

  void updateDevice(String id, String newName, String newBrand) {
    final index = _devices.indexWhere((device) => device.id == id);
    if (index != -1) {
      _devices[index].name = newName;
      _devices[index].brand = newBrand;
      _db.updateDevice(_devices[index]);
      notifyListeners();
    }
  }

  void removeDevice(String id) {
    _devices.removeWhere((device) => device.id == id);
    _db.deleteDevice(id);
    notifyListeners();
  }
}
