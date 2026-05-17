import '../database_helper.dart';

class SafetyLogRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllLogs() async {
    final db = await _dbHelper.database;
    return await db.query('safety_logs', orderBy: 'id DESC');
  }

  Future<int> insertLog(Map<String, dynamic> log) async {
    final db = await _dbHelper.database;
    return await db.insert('safety_logs', log);
  }

  Future<int> resolveLog(int id) async {
    final db = await _dbHelper.database;
    return await db.update(
      'safety_logs',
      {'status': 'Resolved'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
