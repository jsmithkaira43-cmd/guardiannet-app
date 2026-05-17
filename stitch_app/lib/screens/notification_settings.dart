import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // Alert Toggle States
  bool _geofenceEnabled = true;
  bool _redZoneEnabled = true;
  bool _darkMovementEnabled = false;
  bool _systemHealthEnabled = true;

  // Delivery Channel States
  bool _pushEnabled = true;
  bool _smsEnabled = true;
  bool _emailEnabled = false;

  // Quiet Hours States
  bool _quietHoursEnabled = false;
  TimeOfDay _startTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 6, minute: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 950;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              title: const Text(
                'GuardianNet',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
              ],
            ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Desktop only)
          if (isDesktop) _buildSidebar(context),
          // Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 48.0 : 16.0,
                vertical: 32.0,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      const Text(
                        'Notification Settings',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onBackground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Configure alert thresholds and delivery channels for enterprise-wide safety monitoring.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Layout: Left Column and Right Column
                      isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: [
                                      _buildSafetyAlertsCard(theme),
                                      const SizedBox(height: 24),
                                      _buildDeliveryChannelsCard(theme),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      _buildQuietHoursCard(theme),
                                      const SizedBox(height: 24),
                                      _buildGlobalOverrideBanner(),
                                      const SizedBox(height: 24),
                                      _buildInfoCard(),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildSafetyAlertsCard(theme),
                                const SizedBox(height: 24),
                                _buildDeliveryChannelsCard(theme),
                                const SizedBox(height: 24),
                                _buildQuietHoursCard(theme),
                                const SizedBox(height: 24),
                                _buildGlobalOverrideBanner(),
                                const SizedBox(height: 24),
                                _buildInfoCard(),
                              ],
                            ),

                      const SizedBox(height: 40),
                      const Divider(color: AppColors.outlineVariant),
                      const SizedBox(height: 20),

                      // Footer Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.between,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.tertiaryFixedDim,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.tertiaryFixedDim.withOpacity(0.5),
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Last profile sync: Today at 08:42 AM',
                                style: TextStyle(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _geofenceEnabled = true;
                                    _redZoneEnabled = true;
                                    _darkMovementEnabled = false;
                                    _systemHealthEnabled = true;
                                    _pushEnabled = true;
                                    _smsEnabled = true;
                                    _emailEnabled = false;
                                    _quietHoursEnabled = false;
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.outlineVariant),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                ),
                                child: const Text(
                                  'Reset Defaults',
                                  style: TextStyle(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Configuration saved successfully.')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  elevation: 4,
                                ),
                                child: const Text(
                                  'Save Configuration',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : _buildBottomNavBar(context),
    );
  }

  // Safety Alerts Card Component
  Widget _buildSafetyAlertsCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Row(
                  children: [
                    Icon(Icons.shutter_speed, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'Safety Alerts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'ACTIVE MONITORING',
                    style: TextStyle(
                      color: AppColors.onTertiaryContainer,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Items
          _buildToggleItem(
            title: 'Geofence Breaches',
            description: 'Notify when personnel exit defined operational zones.',
            value: _geofenceEnabled,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _geofenceEnabled = val),
          ),
          _buildToggleItem(
            title: 'Red Zone Entry (Critical)',
            description: 'Instant override alerts for unauthorized entry into restricted hazard areas.',
            value: _redZoneEnabled,
            activeColor: AppColors.secondary,
            isCritical: true,
            onChanged: (val) => setState(() => _redZoneEnabled = val),
          ),
          _buildToggleItem(
            title: 'Dark Movement Alerts',
            description: 'Detection of personnel movement in unlit or low-visibility sectors.',
            value: _darkMovementEnabled,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _darkMovementEnabled = val),
          ),
          _buildToggleItem(
            title: 'System Health',
            description: 'Network connectivity status and hardware heartbeat monitoring.',
            value: _systemHealthEnabled,
            activeColor: AppColors.primary,
            isLast: true,
            onChanged: (val) => setState(() => _systemHealthEnabled = val),
          ),
        ],
      ),
    );
  }

  // Toggle item helper
  Widget _buildToggleItem({
    required String title,
    required String description,
    required bool value,
    required Color activeColor,
    required ValueChanged<bool> onChanged,
    bool isCritical = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withOpacity(0.5),
                ),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isCritical ? AppColors.secondary : AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: value,
            activeColor: activeColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Delivery Channels Component Card
  Widget _buildDeliveryChannelsCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.send, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Delivery Channels',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          // Horizontal channel cards
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildChannelCard(
                    icon: Icons.notifications_active,
                    title: 'Push',
                    subtitle: 'DESKTOP & MOBILE',
                    checked: _pushEnabled,
                    onChanged: (val) => setState(() => _pushEnabled = val!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildChannelCard(
                    icon: Icons.sms,
                    title: 'SMS',
                    subtitle: 'EMERGENCY BACKUP',
                    checked: _smsEnabled,
                    onChanged: (val) => setState(() => _smsEnabled = val!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildChannelCard(
                    icon: Icons.mail,
                    title: 'Email',
                    subtitle: 'SHIFT SUMMARIES',
                    checked: _emailEnabled,
                    onChanged: (val) => setState(() => _emailEnabled = val!),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Delivery Channel Card Component
  Widget _buildChannelCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool checked,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: checked ? AppColors.primary : AppColors.outlineVariant,
          width: checked ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: checked ? AppColors.primary : AppColors.outline,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Checkbox(
            value: checked,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Quiet Hours Component Card
  Widget _buildQuietHoursCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Row(
                  children: [
                    Icon(Icons.bedtime, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'Quiet Hours',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: _quietHoursEnabled,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _quietHoursEnabled = val),
                ),
              ],
            ),
          ),
          // Inputs
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTimePicker(
                        label: 'Start Time',
                        time: _startTime,
                        onTap: () async {
                          final selected = await showTimePicker(
                            context: context,
                            initialTime: _startTime,
                          );
                          if (selected != null) {
                            setState(() => _startTime = selected);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTimePicker(
                        label: 'End Time',
                        time: _endTime,
                        onTap: () async {
                          final selected = await showTimePicker(
                            context: context,
                            initialTime: _endTime,
                          );
                          if (selected != null) {
                            setState(() => _endTime = selected);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Note: Critical Red Zone Entry alerts will bypass Quiet Hours settings to ensure maximum safety oversight.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Time picker widget helper
  Widget _buildTimePicker({
    required String label,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                Text(
                  time.format(context),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const Icon(
                  Icons.access_time,
                  color: AppColors.onSurfaceVariant,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Global Override Banner Component
  Widget _buildGlobalOverrideBanner() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          // Backdrop icon decoration
          const Positioned(
            right: -16,
            bottom: -16,
            child: Opacity(
              opacity: 0.08,
              child: Icon(
                Icons.do_not_disturb_on,
                size: 96,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Global Override',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Temporarily silence all non-critical notifications for the next hour.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('DND Mode Enabled.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Enable DND Mode',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Info Card Illustration Component
  Widget _buildInfoCard() {
    return Container(
      height: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBRL3XRrQRkLXGxTW6J_sL5fZq-VuxkkusXRlncVWvGRjvxytFwakEigjBmkpt17uV5JuUp9dApN6gr9pyeVd4pyU9XnyrGPxafHTkKw4PtT9VOG5-wQ-0Xs37TixDu9als0oBiLti3Epv1wCkNJWwYefDimtSxGfXaGpo514ZK3no4mGgNad9M610eoaC9TvZUjmqug14b73qCO-KP8V8Q57hdXMg7kFfX-zC6MsQYAlpuZG-DnA7cLBFx9mIE-OpiXVJdKPeIK20',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.primary.withOpacity(0.85),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: const Text(
          'GuardianNet uses AI-driven prioritization to ensure you only see what matters.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Sidebar widget for Desktop
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 260,
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // User Section in Sidebar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBnL5KtoswULe8-uvqPP64yz3h-6vD87Qm63plsjQVBizJYNA0bXUCK8BA_VMIxc4YLImyP7zpPMm_6KmpvsNchurl2s5CMzIFw6CvxmgKa6QTTFzqV8vCo7AQhpdgtmTXSuMSmPrhLVM9_0Zmsampxt2v1dkEv1YHaa4ozm4hp7Z_bmkAk4qduK7TguELLIfp0D6jH22E96AbgfAUmKF7ox5TSBq7XyKeVGusEybGYRqyYn8wFsJSlfeEDxghAciawPzlFeWFbAlw',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Command Center',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'System Administrator',
                      style: TextStyle(
                        color: AppColors.primaryFixedDim,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 16),
          // Navigation Links
          _buildSidebarLink(context, Icons.map, 'Live Map', '/admin_live_map_dashboard'),
          _buildSidebarLink(context, Icons.grid_view, 'Geofencing', '/geofencing_red_zones'),
          _buildSidebarLink(context, Icons.group, 'Team Management', '/team_management'),
          _buildSidebarLink(context, Icons.insights, 'Safety Analytics', '/safety_analytics_logs'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(color: Colors.white12, height: 1),
          ),
          _buildSidebarLink(context, Icons.settings, 'Notification Settings', '/notification_settings', active: true),
        ],
      ),
    );
  }

  // Sidebar link helper
  Widget _buildSidebarLink(BuildContext context, IconData icon, String title, String route, {bool active = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: active ? AppColors.secondaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: active ? Colors.white : AppColors.primaryFixedDim),
        title: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : AppColors.primaryFixedDim,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        onTap: () {
          if (!active) {
            context.go(route);
          }
        },
        hoverColor: Colors.white10,
      ),
    );
  }

  // Bottom navigation bar for Mobile
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: AppColors.onSurfaceVariant,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shutter_speed),
            label: 'Safety',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            context.go('/welcome_to_guardiannet');
          } else if (index == 2) {
            context.go('/active_tracking_status');
          } else if (index == 3) {
            context.go('/edit_profile');
          }
        },
      ),
    );
  }
}
