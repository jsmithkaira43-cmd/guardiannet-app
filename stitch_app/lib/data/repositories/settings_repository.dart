import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String _keyGeofenceEnabled = 'geofence_enabled';
  static const String _keyRedZoneEnabled = 'red_zone_enabled';
  static const String _keyDarkMovementEnabled = 'dark_movement_enabled';
  static const String _keySystemHealthEnabled = 'system_health_enabled';
  static const String _keyPushEnabled = 'push_enabled';
  static const String _keySmsEnabled = 'sms_enabled';
  static const String _keyEmailEnabled = 'email_enabled';
  static const String _keyQuietHoursEnabled = 'quiet_hours_enabled';
  static const String _keyQuietStartHour = 'quiet_start_hour';
  static const String _keyQuietStartMinute = 'quiet_start_minute';
  static const String _keyQuietEndHour = 'quiet_end_hour';
  static const String _keyQuietEndMinute = 'quiet_end_minute';

  Future<Map<String, dynamic>> getAllSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'geofenceEnabled': prefs.getBool(_keyGeofenceEnabled) ?? true,
      'redZoneEnabled': prefs.getBool(_keyRedZoneEnabled) ?? true,
      'darkMovementEnabled': prefs.getBool(_keyDarkMovementEnabled) ?? false,
      'systemHealthEnabled': prefs.getBool(_keySystemHealthEnabled) ?? true,
      'pushEnabled': prefs.getBool(_keyPushEnabled) ?? true,
      'smsEnabled': prefs.getBool(_keySmsEnabled) ?? true,
      'emailEnabled': prefs.getBool(_keyEmailEnabled) ?? false,
      'quietHoursEnabled': prefs.getBool(_keyQuietHoursEnabled) ?? false,
      'quietStartHour': prefs.getInt(_keyQuietStartHour) ?? 22,
      'quietStartMinute': prefs.getInt(_keyQuietStartMinute) ?? 0,
      'quietEndHour': prefs.getInt(_keyQuietEndHour) ?? 6,
      'quietEndMinute': prefs.getInt(_keyQuietEndMinute) ?? 0,
    };
  }

  Future<void> saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  // Individual persistent getters/setters for keys
  String get keyGeofenceEnabled => _keyGeofenceEnabled;
  String get keyRedZoneEnabled => _keyRedZoneEnabled;
  String get keyDarkMovementEnabled => _keyDarkMovementEnabled;
  String get keySystemHealthEnabled => _keySystemHealthEnabled;
  String get keyPushEnabled => _keyPushEnabled;
  String get keySmsEnabled => _keySmsEnabled;
  String get keyEmailEnabled => _keyEmailEnabled;
  String get keyQuietHoursEnabled => _keyQuietHoursEnabled;
  String get keyQuietStartHour => _keyQuietStartHour;
  String get keyQuietStartMinute => _keyQuietStartMinute;
  String get keyQuietEndHour => _keyQuietEndHour;
  String get keyQuietEndMinute => _keyQuietEndMinute;
}
