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

  // แปลงเป็น Map สำหรับ SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'isOn': isOn ? 1 : 0, // SQLite ไม่มี boolean ใช้ 1/0 แทน
    };
  }

  // สร้าง Object จาก Map ของ SQLite
  factory DeviceItem.fromMap(Map<String, dynamic> map) {
    return DeviceItem(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      isOn: map['isOn'] == 1,
    );
  }
}
