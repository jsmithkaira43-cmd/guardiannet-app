import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class GeofencingRedZonesScreen extends StatefulWidget {
  const GeofencingRedZonesScreen({super.key});

  @override
  State<GeofencingRedZonesScreen> createState() => _GeofencingRedZonesScreenState();
}

class _GeofencingRedZonesScreenState extends State<GeofencingRedZonesScreen> {
  // Zone Toggles
  bool _zone1DarkMovement = true;
  bool _zone1EntryExit = true;
  bool _zone2DarkMovement = false;
  bool _zone2EntryExit = true;

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
              title: const Row(
                children: [
                  Icon(Icons.security, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'GuardianNet',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
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
                  constraints: const BoxConstraints(maxWidth: 1300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page Header
                      _buildPageHeader(theme),
                      const SizedBox(height: 32),

                      // First Row: Map Canvas & Alerts Column
                      isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: _buildMapCanvas(theme),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      _buildActiveAlertsCard(theme),
                                      const SizedBox(height: 24),
                                      _buildSystemHealthCard(theme),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildMapCanvas(theme),
                                const SizedBox(height: 24),
                                _buildActiveAlertsCard(theme),
                                const SizedBox(height: 24),
                                _buildSystemHealthCard(theme),
                              ],
                            ),

                      const SizedBox(height: 32),

                      // Second Row: Zone Management List (Full Width)
                      _buildZoneListCard(theme),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Mobile contextual floating action button
      floatingActionButton: isDesktop
          ? null
          : FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.secondaryContainer,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, size: 28),
            ),
      bottomNavigationBar: isDesktop ? null : _buildBottomNavBar(context),
    );
  }

  // Header Row Component
  Widget _buildPageHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.between,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Geofencing & Red Zones',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Configure perimeter safety and restricted movement protocols.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_location_alt, size: 18),
          label: const Text('ADD NEW ZONE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
      ],
    );
  }

  // Live Map Canvas overlay simulation (Col-8)
  Widget _buildMapCanvas(ThemeData theme) {
    return Container(
      height: 500,
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
      child: Stack(
        children: [
          // Simulated Map Background image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDPLUT4sLpiDyjUEHLOiqfepSV93UyGp6tnTxgQBg-MKMVI_PXPr2qbOpL7RcbVA5540u_j5vas2-A3GJPRV2_6zt9vPlgz-5Wtu2qqra9IcMFhFR0-eyyOFh7PCi42AHza3lBg39B_kRa6nmKAiKXRmlvGXE2Q-RmbPRR2cHqgOVWxu2GxahJvZu_pT-dtZe-DzvvbP85T4mwUPsZ183dmJ8I3zmIopAfDlkLKJimmelJ7QMF7QOr7fPUETah8z0RD4obU9A-JFnY',
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          // Geofence simulation overlays
          // 1. Restricted Red Zone
          Positioned(
            top: 100,
            left: 100,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.secondary, width: 2),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.dangerous,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          // 2. Safe Geofence Blue Polygon
          Positioned(
            top: 150,
            right: 120,
            child: Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                border: Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified_user,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          // Floating Map Controls right side
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                _buildFloatingControlBtn(Icons.add),
                const SizedBox(height: 8),
                _buildFloatingControlBtn(Icons.remove),
                const SizedBox(height: 8),
                _buildFloatingControlBtn(Icons.layers),
              ],
            ),
          ),
          // Floating Legend Overlay card left-top
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LEGEND',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildLegendRow(AppColors.secondary, 'Red Zone (Restricted)'),
                  const SizedBox(height: 8),
                  _buildLegendRow(AppColors.primary, 'Safe Geofence'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Floating Control helper
  Widget _buildFloatingControlBtn(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.primary, size: 20),
        onPressed: () {},
      ),
    );
  }

  // Legend helper row
  Widget _buildLegendRow(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Active Alerts Sidebar Component (Right, Col-4)
  Widget _buildActiveAlertsCard(ThemeData theme) {
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              const Text(
                'Active Alerts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.error.withOpacity(0.2)),
                ),
                child: const Text(
                  '2 CRITICAL',
                  style: TextStyle(
                    color: AppColors.onErrorContainer,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCriticalAlertItem(
            icon: Icons.warning,
            title: 'Unidentified Entry',
            subtitle: 'Restricted Zone B • 2m ago',
          ),
          const SizedBox(height: 12),
          _buildCriticalAlertItem(
            icon: Icons.bedtime,
            title: 'Dark Movement Alert',
            subtitle: 'Warehousing North • 15m ago',
          ),
        ],
      ),
    );
  }

  // Critical Alert Item row builder
  Widget _buildCriticalAlertItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.errorContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onErrorContainer,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.onErrorContainer.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // System Health Status Card Component
  Widget _buildSystemHealthCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.privacy_tip, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'System Health',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'All 24 geofencing beacons are transmitting successfully. GPS precision within 0.8m.',
            style: TextStyle(
              color: AppColors.primaryFixedDim,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 20),
          // Custom Tertiary Green indicator
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.94,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryFixedDim,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Zone Management list full width component
  Widget _buildZoneListCard(ThemeData theme) {
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
          // Section Header
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Text(
                  'Zone List',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                Row(
                  children: [
                    _buildZoneHeaderActionBtn(Icons.filter_list),
                    const SizedBox(width: 8),
                    _buildZoneHeaderActionBtn(Icons.search),
                  ],
                ),
              ],
            ),
          ),
          // Table Layout
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(AppColors.surfaceContainerLow),
              columnSpacing: 56,
              columns: const [
                DataColumn(label: Text('ZONE NAME', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant))),
                DataColumn(label: Text('TYPE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant))),
                DataColumn(label: Text('DARK MOVEMENT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant))),
                DataColumn(label: Text('ENTRY/EXIT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant))),
                DataColumn(label: Text('ACTIONS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant))),
              ],
              rows: [
                // Zone 1
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Warehousing North',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                            ),
                            Text(
                              'Area: 1,200 m²',
                              style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                      ),
                      child: const Text(
                        'SAFE ZONE',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Switch(
                      value: _zone1DarkMovement,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _zone1DarkMovement = val),
                    ),
                  ),
                  DataCell(
                    Switch(
                      value: _zone1EntryExit,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _zone1EntryExit = val),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.settings, color: AppColors.onSurfaceVariant, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ]),
                // Zone 2
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Restricted Zone B',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                            ),
                            Text(
                              'Area: 450 m²',
                              style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
                      ),
                      child: const Text(
                        'RED ZONE',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Switch(
                      value: _zone2DarkMovement,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _zone2DarkMovement = val),
                    ),
                  ),
                  DataCell(
                    Switch(
                      value: _zone2EntryExit,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _zone2EntryExit = val),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.settings, color: AppColors.onSurfaceVariant, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Zone header list action buttons helper
  Widget _buildZoneHeaderActionBtn(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.onSurfaceVariant, size: 18),
        onPressed: () {},
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
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDHv8g3IvZYd8CMhkuPHsp08Axa267CIss5L-xLI9ePsW_WkIErJdFg3x1DooBP-DL6I4QbxIQEaxorWBu2_Z6vr0TirnqtNAH4p2k72w3ME7pqOOCjgYJDi8P9iUjR3J0Ff_r3YFhObIUVOEug8iCbn3N7cGczUE18bruyrgfS_T3rF23F5h2YBB9eCqbz07ufFFUO4jWCdCgztIyj72mA6RhS2mywu_HHRMWaGqcyjZ50LrVZXbuvBelG-UqSwQq1B3mDWIvWmpo',
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
          _buildSidebarLink(context, Icons.grid_view, 'Geofencing', '/geofencing_red_zones', active: true),
          _buildSidebarLink(context, Icons.group, 'Team Management', '/team_management'),
          _buildSidebarLink(context, Icons.insights, 'Safety Analytics', '/safety_analytics_logs'),
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
        currentIndex: 2,
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
