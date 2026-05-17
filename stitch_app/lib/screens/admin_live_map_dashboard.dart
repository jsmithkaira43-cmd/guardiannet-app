import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../data/services/gps_location_service.dart';

class AdminLiveMapDashboardScreen extends StatefulWidget {
  const AdminLiveMapDashboardScreen({super.key});

  @override
  State<AdminLiveMapDashboardScreen> createState() => _AdminLiveMapDashboardScreenState();
}

class _AdminLiveMapDashboardScreenState extends State<AdminLiveMapDashboardScreen> {
  final MapController _mapController = MapController();
  final List<LatLng> _routePoints = [];
  LatLng? _currentPosition;
  StreamSubscription<Position>? _positionSubscription;

  @override
  void initState() {
    super.initState();
    _initializeLiveTracking();
  }

  Future<void> _initializeLiveTracking() async {
    // 1. Get initial coordinate
    final Position? initialPos = await GPSLocationService.instance.getCurrentCoordinates();
    if (initialPos != null) {
      if (mounted) {
        setState(() {
          final latLng = LatLng(initialPos.latitude, initialPos.longitude);
          _currentPosition = latLng;
          _routePoints.add(latLng);
        });
        _mapController.move(LatLng(initialPos.latitude, initialPos.longitude), 16.5);
      }
    }

    // 2. Subscribe to coordinates updates stream
    const LocationSettings settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    _positionSubscription = Geolocator.getPositionStream(locationSettings: settings)
        .listen((Position position) {
          if (mounted) {
            setState(() {
              final latLng = LatLng(position.latitude, position.longitude);
              _currentPosition = latLng;
              _routePoints.add(latLng);
            });
            _mapController.move(latLng, _mapController.camera.zoom);
          }
        });
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          _buildTopBar(context),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sidebar (desktop only)
                if (MediaQuery.of(context).size.width >= 1024)
                  _buildSidebar(context),
                // Map area
                Expanded(child: _buildMapArea(context)),
              ],
            ),
          ),
          // Bottom nav (mobile only)
          if (MediaQuery.of(context).size.width < 1024)
            _buildBottomNav(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.security, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  'GuardianNet',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {
                context.go('/notification_settings');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final navItems = [
      {'icon': Icons.map, 'label': 'Live Map', 'active': true, 'route': '/admin_live_map_dashboard'},
      {'icon': Icons.grid_view, 'label': 'Geofencing', 'active': false, 'route': '/geofencing_red_zones'},
      {'icon': Icons.group, 'label': 'Team Management', 'active': false, 'route': '/team_management'},
      {'icon': Icons.insights, 'label': 'Safety Analytics', 'active': false, 'route': '/safety_analytics_logs'},
    ];

    return Container(
      width: 260,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Admin avatar
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.person, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Command Center',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                    ),
                    Text(
                      'System Administrator',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primaryFixedDim.withOpacity(0.8),
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Nav items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                final isActive = item['active'] as bool;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: InkWell(
                    onTap: () => context.go(item['route'] as String),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            color: isActive
                                ? Theme.of(context).colorScheme.onSecondaryContainer
                                : Theme.of(context).colorScheme.primaryFixedDim,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item['label'] as String,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: isActive
                                      ? Theme.of(context).colorScheme.onSecondaryContainer
                                      : Theme.of(context).colorScheme.primaryFixedDim,
                                  fontSize: 13,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapArea(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        // Live OpenStreetMap rendering canvas
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentPosition ?? const LatLng(37.4220, -122.0840),
            initialZoom: 16.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.guardiannet.stitch_app',
            ),
            if (_routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    strokeWidth: 4.5,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                if (_currentPosition != null)
                  Marker(
                    point: _currentPosition!,
                    width: 60,
                    height: 60,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Pulsing outer animation frame
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary.withOpacity(0.25),
                          ),
                        ),
                        // Dynamic core marker
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.25),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.navigation,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),

        // Overlay UI controls
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top row: search + status card
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildSearchBar(context)),
                    const SizedBox(width: 12),
                    _buildStatusCard(context),
                  ],
                ),
                // Bottom row: FAB + member cards list
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBroadcastFab(context),
                    const SizedBox(height: 12),
                    _buildMemberCardList(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.08))],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search members, zones, or teams...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.10))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Live Status',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      )),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: Color(0xFF48A54B), shape: BoxShape.circle),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildStatChip(context, 'ACTIVE', '42', null)),
              Container(width: 1, height: 36, color: Theme.of(context).colorScheme.outlineVariant),
              Expanded(
                  child: _buildStatChip(
                      context, 'RED ZONE', '03', Theme.of(context).colorScheme.error)),
              Container(width: 1, height: 36, color: Theme.of(context).colorScheme.outlineVariant),
              Expanded(child: _buildStatChip(context, 'ALERTS', '12', null)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, String label, String value, Color? valueColor) {
    return Column(
      children: [
        Text(label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: valueColor ?? Theme.of(context).colorScheme.outline,
                  fontSize: 9,
                )),
        const SizedBox(height: 2),
        Text(value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: valueColor ?? Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
      ],
    );
  }

  Widget _buildBroadcastFab(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.broadcast_on_home),
      label: const Text('BROADCAST MESSAGE', style: TextStyle(letterSpacing: 0.8)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: const StadiumBorder(),
        elevation: 8,
      ),
    );
  }

  Widget _buildMemberCardList(BuildContext context) {
    final members = [
      {'name': 'Marcus Chen', 'location': 'Zone A - Restricted', 'battery': '32%', 'alert': true},
      {'name': 'Sarah Jenkins', 'location': 'Seen 2m ago - Office', 'battery': '98%', 'alert': false},
      {'name': 'David Miller', 'location': 'Seen 5m ago - Site B', 'battery': '64%', 'alert': false},
    ];
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: members.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final m = members[index];
          final isAlert = m['alert'] as bool;
          return Container(
            width: 280,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: isAlert
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.10))],
            ),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(Icons.person, size: 32, color: Colors.grey),
                    ),
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: isAlert
                              ? Theme.of(context).colorScheme.error
                              : const Color(0xFF48A54B),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(m['name'] as String,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            isAlert ? Icons.location_on : Icons.history,
                            size: 13,
                            color: isAlert
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(m['location'] as String,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: isAlert
                                          ? Theme.of(context).colorScheme.error
                                          : Theme.of(context).colorScheme.onSurfaceVariant,
                                      fontSize: 10,
                                    )),
                          ),
                        ],
                      ),
                      Divider(color: Theme.of(context).colorScheme.outlineVariant, height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.battery_std, size: 14, color: Colors.grey),
                              const SizedBox(width: 2),
                              Text(m['battery'] as String,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero, minimumSize: Size.zero),
                            child: Text('VIEW DETAILS',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.1), offset: const Offset(0, -2))],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, Icons.home_outlined, 'Home', false, '/admin_live_map_dashboard'),
              _buildNavItem(context, Icons.chat_bubble_outline, 'Messages', false, '/team_messages'),
              _buildNavItem(context, Icons.speed, 'Safety', true, '/personal_safety_portal'),
              _buildNavItem(context, Icons.account_circle_outlined, 'Profile', false, '/profile_setup'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isActive, String route) {
    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isActive
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    fontSize: 10,
                    color: isActive
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
