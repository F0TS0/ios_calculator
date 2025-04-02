// db/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBHelper {
  static const _dbName = 'calculator_app.db';
  static const _dbVersion = 1;

  static final DBHelper instance = DBHelper._internal();
  Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }
}
