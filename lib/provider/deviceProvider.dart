import 'package:flutter/material.dart';
import '../model/deviceitem.dart';
import '../database/appliance_db.dart';

class DeviceProvider with ChangeNotifier {
  final ApplianceDB _db = ApplianceDB.instance;
  List<DeviceItem> _devices = [];

  List<DeviceItem> get devices => _devices;

  DeviceProvider() {
    loadDevices(); // โหลดข้อมูลตอนเริ่มแอป
  }

  Future<void> loadDevices() async {
    _devices = await _db.fetchDevices();
    notifyListeners();
  }

  void addDevice(String name, String brand, String imgPath) {
    final newDevice = DeviceItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      brand: brand,
      isOn: false,
      imgPath: imgPath,
      lastOpenedTime: null, // ตอนสร้างใหม่ยังไม่มีเวลาเปิด
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
      _devices[index] = _devices[index].copyWith(
        name: newName,
        brand: newBrand,
      );
      _db.updateDevice(_devices[index]);
      notifyListeners();
    }
  }

  void removeDevice(String id) {
    _devices.removeWhere((device) => device.id == id);
    _db.deleteDevice(id);
    notifyListeners();
  }

  // ✅ เพิ่มฟังก์ชันอัปเดตเวลาเปิดล่าสุด
  void updateLastOpenedTime(String id, DateTime time) {
    final index = _devices.indexWhere((device) => device.id == id);
    if (index != -1) {
      _devices[index] = _devices[index].copyWith(lastOpenedTime: time);
      _db.updateDevice(_devices[index]);
      notifyListeners();
    }
  }
}
