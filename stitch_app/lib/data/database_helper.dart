import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('guardiannet.db');
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
    // 1. Members Table
    await db.execute('''
      CREATE TABLE members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        employeeId TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        role TEXT NOT NULL,
        department TEXT NOT NULL,
        status TEXT NOT NULL,
        battery TEXT NOT NULL,
        lastSync TEXT NOT NULL,
        avatarUrl TEXT NOT NULL
      )
    ''');

    // 2. Safety Logs Table
    await db.execute('''
      CREATE TABLE safety_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employeeName TEXT NOT NULL,
        employeeId TEXT NOT NULL,
        eventType TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        severity TEXT NOT NULL,
        status TEXT NOT NULL,
        location TEXT NOT NULL
      )
    ''');

    // 3. Geofences Table
    await db.execute('''
      CREATE TABLE geofences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        radius REAL NOT NULL,
        dangerLevel TEXT NOT NULL,
        active INTEGER NOT NULL
      )
    ''');

    // 4. Inject Initial Seed Data
    await _seedDatabase(db);
  }

  Future<void> _seedDatabase(Database db) async {
    // Insert Initial Members
    final initialMembers = [
      {
        'fullName': 'Elena Rodriguez',
        'employeeId': 'GN-4029-OPS',
        'email': 'e.rodriguez@guardiannet.com',
        'phone': '+1 (555) 019-2834',
        'role': 'Hazard Mitigation Specialist',
        'department': 'Emergency Response Unit',
        'status': 'Active',
        'battery': '88%',
        'lastSync': '2s ago',
        'avatarUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDFU_bKwtzD23GplpXwF27n8W0YlX97b8q8R6xG8_l6eJd9pW9c8w',
      },
      {
        'fullName': 'Marcus Thorne',
        'employeeId': 'GN-8842-OPS',
        'email': 'm.thorne@guardiannet.com',
        'phone': '+1 (555) 902-4821',
        'role': 'Senior Operations Manager',
        'department': 'Global Safety & Logistics',
        'status': 'Active',
        'battery': '94%',
        'lastSync': '5s ago',
        'avatarUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA1HaMt_LmnFglMVVWsisDsKt8sW-o4iCaBwek0dWq-9g3BlDuAohe2MBNZDCqwFRGuLviG71GBM8L7MAmzl1rtYHLtFoibAK265Un7YuFnwTsLVDPZ_2uHQjmsBNt9As3Pxd5WLQInMWe2bTdBCi359zrTXC8np65Ugxn93C1dSTYgFfp234ra57Sa6uV-jeBfb-NLic7bdzQFLN29tRlqzX1IaCjTh_CSXS-vv3kMGpSCnplAbjIqqiMkZEMN9R785kJVlfsatlw',
      },
      {
        'fullName': 'Sarah Jenkins',
        'employeeId': 'GN-1104-ENG',
        'email': 's.jenkins@guardiannet.com',
        'phone': '+1 (555) 382-9012',
        'role': 'Infrastructure Safety Engineer',
        'department': 'Site Operations',
        'status': 'Offline',
        'battery': '12%',
        'lastSync': '2h ago',
        'avatarUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA1HaMt_LmnFglMVVWsisDsKt8sW-o4iCaBwek0dWq-9g3BlDuAohe2MBNZDCqwFRGuLviG71GBM8L7MAmzl1rtYHLtFoibAK265Un7YuFnwTsLVDPZ_2uHQjmsBNt9As3Pxd5WLQInMWe2bTdBCi359zrTXC8np65Ugxn93C1dSTYgFfp234ra57Sa6uV-jeBfb-NLic7bdzQFLN29tRlqzX1IaCjTh_CSXS-vv3kMGpSCnplAbjIqqiMkZEMN9R785kJVlfsatlw',
      },
    ];

    for (final member in initialMembers) {
      await db.insert('members', member);
    }

    // Insert Initial Safety Logs
    final initialLogs = [
      {
        'employeeName': 'Elena Rodriguez',
        'employeeId': 'GN-4029-OPS',
        'eventType': 'Red Zone Entry',
        'timestamp': 'Today, 10:42 AM',
        'severity': 'Critical',
        'status': 'Active Warning',
        'location': 'Hazard Zone B (Refinery Core)',
      },
      {
        'employeeName': 'Marcus Thorne',
        'employeeId': 'GN-8842-OPS',
        'eventType': 'Geofence Breach',
        'timestamp': 'Today, 09:15 AM',
        'severity': 'Medium',
        'status': 'Resolved',
        'location': 'Outer Parameter Sector 4',
      },
      {
        'employeeName': 'Sarah Jenkins',
        'employeeId': 'GN-1104-ENG',
        'eventType': 'Unusual Inactivity',
        'timestamp': 'Yesterday, 04:30 PM',
        'severity': 'Low',
        'status': 'Resolved',
        'location': 'Support Depot Alpha',
      },
    ];

    for (final log in initialLogs) {
      await db.insert('safety_logs', log);
    }

    // Insert Initial Geofences
    final initialGeofences = [
      {
        'name': 'Hazard Zone B (Refinery Core)',
        'latitude': 37.7749,
        'longitude': -122.4194,
        'radius': 200.0,
        'dangerLevel': 'Restricted',
        'active': 1,
      },
      {
        'name': 'Main Storage Warehouse',
        'latitude': 37.7801,
        'longitude': -122.4120,
        'radius': 350.0,
        'dangerLevel': 'Warning',
        'active': 1,
      },
    ];

    for (final gf in initialGeofences) {
      await db.insert('geofences', gf);
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
