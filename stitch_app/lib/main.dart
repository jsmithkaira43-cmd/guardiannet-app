import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'data/services/firebase_sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Safe initialization block (catches empty credentials/no setups gracefully)
  await FirebaseSyncService.instance.initializeSafe();
  
  runApp(const GuardianNetApp());
}

class GuardianNetApp extends StatelessWidget {
  const GuardianNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GuardianNet - Stitch',
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
