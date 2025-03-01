class DeviceItem {
  String id;
  String name;
  String brand;
  bool isOn;
  String imgPath;

  DeviceItem({
    required this.id,
    required this.name,
    required this.brand,
    this.isOn = false,
    required this.imgPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'isOn': isOn ? 1 : 0,
      'imgPath': imgPath, // ค่าเริ่มต้น
    };
  }

  factory DeviceItem.fromMap(Map<String, dynamic> map) {
    return DeviceItem(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      isOn: map['isOn'] == 1,
      imgPath: map['imgPath'] ?? 'assets/default.png', // ป้องกันค่า null
    );
  }
}
