import 'package:go_router/go_router.dart';
import '../screens/active_tracking_status.dart';
import '../screens/add_new_member.dart';
import '../screens/admin_live_map_dashboard.dart';
import '../screens/automated_messaging_rules.dart';
import '../screens/chat_elena_rodriguez.dart';
import '../screens/create_new_zone.dart';
import '../screens/edit_profile.dart';
import '../screens/geofencing_red_zones.dart';
import '../screens/guardiannet_enterprise_security_platform_1.dart';
import '../screens/guardiannet_enterprise_security_platform_2.dart';
import '../screens/guardiannet_secure_login.dart';
import '../screens/identity_verification.dart';
import '../screens/notification_settings.dart';
import '../screens/personal_safety_portal.dart';
import '../screens/personal_safety_portal_enhanced_map.dart';
import '../screens/profile_setup.dart';
import '../screens/quick_start_emergency_sos.dart';
import '../screens/quick_start_live_tracking.dart';
import '../screens/quick_start_safety_zones.dart';
import '../screens/red_zone_settings_analytics.dart';
import '../screens/remote_alarm_control.dart';
import '../screens/safety_analytics_logs.dart';
import '../screens/safety_automation_settings.dart';
import '../screens/system_permissions_access.dart';
import '../screens/team_chat_with_member_list.dart';
import '../screens/team_management.dart';
import '../screens/team_messages.dart';
import '../screens/unified_communication_portal.dart';
import '../screens/welcome_to_guardiannet.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/guardiannet_secure_login',
    routes: [      GoRoute(
        path: '/active_tracking_status',
        builder: (context, state) => const ActiveTrackingStatusScreen(),
      ),      GoRoute(
        path: '/add_new_member',
        builder: (context, state) => const AddNewMemberScreen(),
      ),      GoRoute(
        path: '/admin_live_map_dashboard',
        builder: (context, state) => const AdminLiveMapDashboardScreen(),
      ),      GoRoute(
        path: '/automated_messaging_rules',
        builder: (context, state) => const AutomatedMessagingRulesScreen(),
      ),      GoRoute(
        path: '/chat_elena_rodriguez',
        builder: (context, state) => const ChatElenaRodriguezScreen(),
      ),      GoRoute(
        path: '/create_new_zone',
        builder: (context, state) => const CreateNewZoneScreen(),
      ),      GoRoute(
        path: '/edit_profile',
        builder: (context, state) => const EditProfileScreen(),
      ),      GoRoute(
        path: '/geofencing_red_zones',
        builder: (context, state) => const GeofencingRedZonesScreen(),
      ),      GoRoute(
        path: '/guardiannet_enterprise_security_platform_1',
        builder: (context, state) => const GuardiannetEnterpriseSecurityPlatform1Screen(),
      ),      GoRoute(
        path: '/guardiannet_enterprise_security_platform_2',
        builder: (context, state) => const GuardiannetEnterpriseSecurityPlatform2Screen(),
      ),      GoRoute(
        path: '/guardiannet_secure_login',
        builder: (context, state) => const GuardiannetSecureLoginScreen(),
      ),      GoRoute(
        path: '/identity_verification',
        builder: (context, state) => const IdentityVerificationScreen(),
      ),      GoRoute(
        path: '/notification_settings',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),      GoRoute(
        path: '/personal_safety_portal',
        builder: (context, state) => const PersonalSafetyPortalScreen(),
      ),      GoRoute(
        path: '/personal_safety_portal_enhanced_map',
        builder: (context, state) => const PersonalSafetyPortalEnhancedMapScreen(),
      ),      GoRoute(
        path: '/profile_setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),      GoRoute(
        path: '/quick_start_emergency_sos',
        builder: (context, state) => const QuickStartEmergencySosScreen(),
      ),      GoRoute(
        path: '/quick_start_live_tracking',
        builder: (context, state) => const QuickStartLiveTrackingScreen(),
      ),      GoRoute(
        path: '/quick_start_safety_zones',
        builder: (context, state) => const QuickStartSafetyZonesScreen(),
      ),      GoRoute(
        path: '/red_zone_settings_analytics',
        builder: (context, state) => const RedZoneSettingsAnalyticsScreen(),
      ),      GoRoute(
        path: '/remote_alarm_control',
        builder: (context, state) => const RemoteAlarmControlScreen(),
      ),      GoRoute(
        path: '/safety_analytics_logs',
        builder: (context, state) => const SafetyAnalyticsLogsScreen(),
      ),      GoRoute(
        path: '/safety_automation_settings',
        builder: (context, state) => const SafetyAutomationSettingsScreen(),
      ),      GoRoute(
        path: '/system_permissions_access',
        builder: (context, state) => const SystemPermissionsAccessScreen(),
      ),      GoRoute(
        path: '/team_chat_with_member_list',
        builder: (context, state) => const TeamChatWithMemberListScreen(),
      ),      GoRoute(
        path: '/team_management',
        builder: (context, state) => const TeamManagementScreen(),
      ),      GoRoute(
        path: '/team_messages',
        builder: (context, state) => const TeamMessagesScreen(),
      ),      GoRoute(
        path: '/unified_communication_portal',
        builder: (context, state) => const UnifiedCommunicationPortalScreen(),
      ),      GoRoute(
        path: '/welcome_to_guardiannet',
        builder: (context, state) => const WelcomeToGuardiannetScreen(),
      ),    ],
  );
}
