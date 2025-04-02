// repositories/history_repository.dart
import 'package:ios_calculator/db/db_helper.dart';
import 'package:ios_calculator/models/history_entry.dart';

class HistoryRepository {
  final _tableName = 'history';

  // Insert a new entry
  Future<void> insertEntry(HistoryEntry entry) async {
    final db = await DBHelper.instance.database;
    await db.insert(_tableName, entry.toMap());
  }

  // Fetch all entries (descending by date)
  Future<List<HistoryEntry>> getAllEntries() async {
    final db = await DBHelper.instance.database;
    final rows = await db.query(_tableName, orderBy: 'created_at DESC');
    return rows.map((e) => HistoryEntry.fromMap(e)).toList();
  }

  // (Optional) Clear entire history
  Future<void> clearHistory() async {
    final db = await DBHelper.instance.database;
    await db.delete(_tableName);
  }
}
