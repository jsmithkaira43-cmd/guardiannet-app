import '../database_helper.dart';
import '../services/firebase_sync_service.dart';

class SafetyLogRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllLogs() async {
    final db = await _dbHelper.database;
    return await db.query('safety_logs', orderBy: 'id DESC');
  }

  Future<int> insertLog(Map<String, dynamic> log) async {
    final db = await _dbHelper.database;
    final id = await db.insert('safety_logs', log);

    // Dual Write: Cloud Sync Push loop
    await FirebaseSyncService.instance.pushLog(log);
    
    return id;
  }

  Future<int> resolveLog(int id) async {
    final db = await _dbHelper.database;
    final count = await db.update(
      'safety_logs',
      {'status': 'Resolved'},
      where: 'id = ?',
      whereArgs: [id],
    );

    // Dual Write: Refresh remote state
    final results = await db.query('safety_logs', where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      await FirebaseSyncService.instance.pushLog(results.first);
    }
    
    return count;
  }
}
