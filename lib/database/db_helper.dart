import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class DBHelper {
  static Database? _database;
  static const String tableName = "history";

  static Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDB();
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "calculator_history.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        log("Creating history table...");
        db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            expression TEXT,
            result TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertHistory(String expression, String result) async {
    final db = await database;
    await db.insert(tableName, {
      "expression": expression,
      "result": result,
      "timestamp": DateTime.now().toString(),
    });

    log("Inserted into history: $expression = $result");
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    List<Map<String, dynamic>> data = await db.query(
      tableName,
      orderBy: "id DESC",
    );
    log("History Loaded: $data"); // ✅ Debugging Log
    return data;
  }

  static Future<void> clearHistory() async {
    final db = await database;
    await db.delete(tableName);
    log("History Cleared");
  }
}
