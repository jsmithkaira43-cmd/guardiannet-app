import '../database_helper.dart';
import '../services/firebase_sync_service.dart';

class MemberRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> getAllMembers() async {
    final db = await _dbHelper.database;
    return await db.query('members', orderBy: 'id DESC');
  }

  Future<int> insertMember(Map<String, dynamic> member) async {
    final db = await _dbHelper.database;
    // Supply default mock indicators for telemetry
    final completeMember = Map<String, dynamic>.from(member);
    completeMember['battery'] ??= '100%';
    completeMember['lastSync'] ??= 'Just now';
    completeMember['avatarUrl'] ??= 'https://lh3.googleusercontent.com/aida-public/AB6AXuA1HaMt_LmnFglMVVWsisDsKt8sW-o4iCaBwek0dWq-9g3BlDuAohe2MBNZDCqwFRGuLviG71GBM8L7MAmzl1rtYHLtFoibAK265Un7YuFnwTsLVDPZ_2uHQjmsBNt9As3Pxd5WLQInMWe2bTdBCi359zrTXC8np65Ugxn93C1dSTYgFfp234ra57Sa6uV-jeBfb-NLic7bdzQFLN29tRlqzX1IaCjTh_CSXS-vv3kMGpSCnplAbjIqqiMkZEMN9R785kJVlfsatlw';
    
    final id = await db.insert('members', completeMember);
    
    // Dual Write: Cloud Sync Push loop
    await FirebaseSyncService.instance.pushMember(completeMember);
    
    return id;
  }

  Future<int> updateMemberStatus(int id, String status) async {
    final db = await _dbHelper.database;
    final count = await db.update(
      'members',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );

    // Dual Write: Refresh remote server state
    final results = await db.query('members', where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      await FirebaseSyncService.instance.pushMember(results.first);
    }
    
    return count;
  }

  Future<int> deleteMember(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'members',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
