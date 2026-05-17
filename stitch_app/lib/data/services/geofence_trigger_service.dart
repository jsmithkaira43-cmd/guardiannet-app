import 'dart:math' show cos, sqrt, asin;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import '../repositories/safety_log_repository.dart';

class GeofenceTriggerService {
  static final GeofenceTriggerService instance = GeofenceTriggerService._init();
  final SafetyLogRepository _logRepo = SafetyLogRepository();
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  // Pre-seeded danger zones for geofencing checks
  final List<Map<String, dynamic>> _dangerZones = [
    {
      'id': 'ZONE-A',
      'name': 'Restricted Cyanide Storage Area A',
      'latitude': 37.4220, // Google simulator default lat
      'longitude': -122.0840, // Google simulator default long
      'radiusMeters': 150.0,
    },
    {
      'id': 'ZONE-B',
      'name': 'High-Voltage Transformer Room',
      'latitude': 37.4275,
      'longitude': -122.0890,
      'radiusMeters': 50.0,
    }
  ];

  GeofenceTriggerService._init();

  Future<void> initializeNotifications() async {
    if (_isInitialized) return;

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    try {
      await _notificationsPlugin.initialize(
        initializationSettings,
      );
      _isInitialized = true;
      if (kDebugMode) {
        print('GuardianNet Local Notifications Plugin initialized successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing local notifications: $e');
      }
    }
  }

  Future<void> triggerAlertNotification(String title, String body) async {
    await initializeNotifications();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'guardiannet_danger_alerts',
      'Danger Alerts',
      channelDescription: 'High-importance notifications for restricted area entries',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    try {
      await _notificationsPlugin.show(
        RandomIdGenerator.nextId(),
        title,
        body,
        platformChannelSpecifics,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to show system notification: $e');
      }
    }
  }

  // Haversine formula to compute distance between coordinates in meters
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Math.PI / 180
    final double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742000 * asin(sqrt(a)); // 2 * R * 1000 meters
  }

  Future<void> evaluateGeofences(double lat, double lng) async {
    for (final zone in _dangerZones) {
      final double distance = _calculateDistance(
        lat,
        lng,
        zone['latitude'] as double,
        zone['longitude'] as double,
      );

      if (kDebugMode) {
        print('Checking Geofence [${zone['id']}]: Current distance is ${distance.toStringAsFixed(1)} meters.');
      }

      if (distance <= (zone['radiusMeters'] as double)) {
        if (kDebugMode) {
          print('CRITICAL GEOFENCE BREACH DETECTED: Operative entered restricted perimeter: ${zone['name']}');
        }

        // Trigger High Priority local alert notification
        await triggerAlertNotification(
          '🚨 CRITICAL AREA BREACH!',
          'You have entered the restricted zone: ${zone['name']}. Evacuate immediately!',
        );

        // Write a critical safety log warning directly to SQLite + Cloud Firestore Dual Write pipelines
        await _logRepo.insertLog({
          'employeeName': 'Self Device',
          'employeeId': 'GPS-MAIN',
          'eventType': 'Restricted Area Breach',
          'timestamp': 'Just now',
          'severity': 'Critical',
          'status': 'Active',
          'location': '${zone['name']} (Lat: ${lat.toStringAsFixed(4)}, Long: ${lng.toStringAsFixed(4)})',
        });
      }
    }
  }
}

class RandomIdGenerator {
  static int _id = 1000;
  static int nextId() {
    _id++;
    return _id;
  }
}
