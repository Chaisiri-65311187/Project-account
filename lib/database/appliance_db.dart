import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/deviceitem.dart';

class ApplianceDB {
  static final ApplianceDB instance = ApplianceDB._init();
  static Database? _database;

  ApplianceDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('appliances.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appliances (
         id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        brand TEXT NOT NULL,
        isOn INTEGER NOT NULL,
        imgPath TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertDevice(DeviceItem device) async {
    final db = await instance.database;
    await db.insert(
      'appliances',
      device.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DeviceItem>> fetchDevices() async {
    final db = await instance.database;
    final result = await db.query('appliances');
    return result.map((json) => DeviceItem.fromMap(json)).toList();
  }

  Future<void> updateDevice(DeviceItem device) async {
    final db = await instance.database;
    await db.update(
      'appliances',
      device.toMap(),
      where: 'id = ?',
      whereArgs: [device.id],
    );
  }

  Future<void> deleteDevice(String id) async {
    final db = await instance.database;
    await db.delete(
      'appliances',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
