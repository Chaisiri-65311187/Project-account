class DeviceItem {
  String id;
  String name;
  String brand;
  bool isOn;
  String imgPath;
  DateTime? lastOpenedTime; // เพิ่มตัวแปรนี้เข้ามา

  DeviceItem({
    required this.id,
    required this.name,
    required this.brand,
    this.isOn = false,
    required this.imgPath,
    this.lastOpenedTime, // constructor รับเพิ่ม
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'isOn': isOn ? 1 : 0,
      'imgPath': imgPath,
      'lastOpenedTime':
          lastOpenedTime?.toIso8601String(), // แปลงเวลาเป็น string ก่อนเก็บ
    };
  }

  factory DeviceItem.fromMap(Map<String, dynamic> map) {
    return DeviceItem(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      isOn: map['isOn'] == 1,
      imgPath: map['imgPath'] ?? 'assets/default.png',
      lastOpenedTime: map['lastOpenedTime'] != null
          ? DateTime.parse(map['lastOpenedTime'])
          : null, // แปลงกลับเป็น DateTime ตอนอ่านจาก DB
    );
  }

  DeviceItem copyWith({
    String? id,
    String? name,
    String? brand,
    bool? isOn,
    String? imgPath,
    DateTime? lastOpenedTime,
  }) {
    return DeviceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      isOn: isOn ?? this.isOn,
      imgPath: imgPath ?? this.imgPath,
      lastOpenedTime: lastOpenedTime ?? this.lastOpenedTime,
    );
  }
}
