import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseSyncService {
  static final FirebaseSyncService instance = FirebaseSyncService._init();
  bool _isInitialized = false;

  FirebaseSyncService._init();

  bool get isFirebaseAvailable => _isInitialized;

  Future<void> initializeSafe() async {
    try {
      // In a real environment, you can supply your FirebaseOptions here.
      // We call initializeApp with no options to use default native config.
      await Firebase.initializeApp();
      _isInitialized = true;
      if (kDebugMode) {
        print('GuardianNet Firebase Initialized Successfully.');
      }
    } catch (e) {
      _isInitialized = false;
      if (kDebugMode) {
        print('GuardianNet Safe Firebase initialization warning caught: $e');
        print('Fallback to Offline Local SQLite Storage mode activated.');
      }
    }
  }

  Future<void> pushMember(Map<String, dynamic> member) async {
    if (!_isInitialized) {
      if (kDebugMode) {
        print('Skipping Cloud Sync: Firebase is running in offline mode.');
      }
      return;
    }

    try {
      final docId = member['employeeId'] as String;
      await FirebaseFirestore.instance.collection('members').doc(docId).set(
        member,
        SetOptions(merge: true),
      );
      if (kDebugMode) {
        print('Successfully synced operative to Cloud Firestore: $docId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to sync member to cloud firestore: $e');
      }
    }
  }

  Future<void> pushLog(Map<String, dynamic> log) async {
    if (!_isInitialized) {
      if (kDebugMode) {
        print('Skipping Cloud Sync: Firebase is running in offline mode.');
      }
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('safety_logs').add(log);
      if (kDebugMode) {
        print('Successfully pushed safety log to Cloud Firestore.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to push safety log to cloud firestore: $e');
      }
    }
  }
}
