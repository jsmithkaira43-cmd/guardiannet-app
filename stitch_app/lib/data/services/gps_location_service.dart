import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import '../repositories/safety_log_repository.dart';

class GPSLocationService {
  static final GPSLocationService instance = GPSLocationService._init();
  final SafetyLogRepository _logRepo = SafetyLogRepository();
  
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isTracking = false;

  GPSLocationService._init();

  bool get isTracking => _isTracking;

  Future<bool> checkAndRequestPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('GPS Location Services are disabled on this device.');
      }
      return false;
    }

    // Check existing permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (kDebugMode) {
          print('GPS location permissions are denied by the user.');
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print('GPS location permissions are permanently denied.');
      }
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentCoordinates() async {
    final hasPermission = await checkAndRequestPermissions();
    if (!hasPermission) return null;

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving current GPS position: $e');
      }
      return null;
    }
  }

  void startTrackingLogsStream() async {
    if (_isTracking) return;

    final hasPermission = await checkAndRequestPermissions();
    if (!hasPermission) return;

    _isTracking = true;
    if (kDebugMode) {
      print('Initializing real-time GPS location tracking stream.');
    }

    const LocationSettings settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update location every 10 meters
    );

    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: settings)
        .listen((Position position) async {
          if (kDebugMode) {
            print('New GPS Coordinates tracked: Lat: ${position.latitude}, Long: ${position.longitude}');
          }

          // Periodic telemetry check: If speed is dangerously high or outside bounds, log an event
          if (position.speed > 25.0) { // Over ~90 km/h
            await _logRepo.insertLog({
              'employeeName': 'Self Device',
              'employeeId': 'GPS-MAIN',
              'eventType': 'High Speed Warning',
              'timestamp': 'Just now',
              'severity': 'Critical',
              'status': 'Active',
              'location': 'Lat: ${position.latitude.toStringAsFixed(4)}, Long: ${position.longitude.toStringAsFixed(4)}',
            });
          } else {
            // Standard tracking update log (Info level)
            await _logRepo.insertLog({
              'employeeName': 'Self Device',
              'employeeId': 'GPS-MAIN',
              'eventType': 'GPS Telemetry Ping',
              'timestamp': 'Just now',
              'severity': 'Info',
              'status': 'Resolved',
              'location': 'Lat: ${position.latitude.toStringAsFixed(4)}, Long: ${position.longitude.toStringAsFixed(4)}',
            });
          }
        }, onError: (error) {
          if (kDebugMode) {
            print('GPS stream listener error occurred: $error');
          }
        });
  }

  void stopTrackingLogsStream() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    _isTracking = false;
    if (kDebugMode) {
      print('GPS location tracking stream deactivated successfully.');
    }
  }
}
