$screenNames = @(
    "active_tracking_status",
    "add_new_member",
    "admin_live_map_dashboard",
    "automated_messaging_rules",
    "chat_elena_rodriguez",
    "create_new_zone",
    "edit_profile",
    "geofencing_red_zones",
    "guardiannet_enterprise_security_platform_1",
    "guardiannet_enterprise_security_platform_2",
    "guardiannet_secure_login",
    "identity_verification",
    "notification_settings",
    "personal_safety_portal",
    "personal_safety_portal_enhanced_map",
    "profile_setup",
    "quick_start_emergency_sos",
    "quick_start_live_tracking",
    "quick_start_safety_zones",
    "red_zone_settings_analytics",
    "remote_alarm_control",
    "safety_analytics_logs",
    "safety_automation_settings",
    "system_permissions_access",
    "team_chat_with_member_list",
    "team_management",
    "team_messages",
    "unified_communication_portal",
    "welcome_to_guardiannet"
)

$baseDir = "c:\Users\P S RATHORE\Downloads\stitch_smart_employee_monitoring_system\stitch_app"
$screensDir = "$baseDir\lib\screens"
$routesDir = "$baseDir\lib\routes"

New-Item -ItemType Directory -Force -Path $screensDir
New-Item -ItemType Directory -Force -Path $routesDir

# Create Screen placeholders
foreach ($screen in $screenNames) {
    # Convert snake_case to PascalCase
    $className = (Get-Culture).TextInfo.ToTitleCase($screen.Replace("_", " ")).Replace(" ", "") + "Screen"
    
    $screenCode = @"
import 'package:flutter/material.dart';

class $className extends StatelessWidget {
  const ${className}({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$className')),
      body: const Center(
        child: Text('Placeholder for $className'),
      ),
    );
  }
}
"@
    Set-Content -Path "$screensDir\$screen.dart" -Value $screenCode
}

# Create app_routes.dart
$routesCode = "import 'package:flutter/material.dart';`n"
$routesCode += "import 'package:go_router/go_router.dart';`n"
foreach ($screen in $screenNames) {
    $routesCode += "import '../screens/$screen.dart';`n"
}

$routesCode += @"

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/guardiannet_secure_login',
    routes: [
"@

foreach ($screen in $screenNames) {
    $className = (Get-Culture).TextInfo.ToTitleCase($screen.Replace("_", " ")).Replace(" ", "") + "Screen"
    $routesCode += @"
      GoRoute(
        path: '/$screen',
        builder: (context, state) => const ${className}(),
      ),
"@
}

$routesCode += @"
    ],
  );
}
"@

Set-Content -Path "$routesDir\app_routes.dart" -Value $routesCode
