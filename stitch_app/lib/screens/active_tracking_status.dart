import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class ActiveTrackingStatusScreen extends StatefulWidget {
  const ActiveTrackingStatusScreen({super.key});

  @override
  State<ActiveTrackingStatusScreen> createState() => _ActiveTrackingStatusScreenState();
}

class _ActiveTrackingStatusScreenState extends State<ActiveTrackingStatusScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 900;

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
                  icon: const Icon(Icons.signal_cellular_4_bar, color: Colors.white70),
                  onPressed: () {},
                ),
              ],
            ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Desktop sidebar placeholder
          if (isDesktop) _buildDesktopSidebar(context),
          // Main scrollable canvas
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 48.0 : 16.0,
                vertical: 32.0,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Active tracking animated pulse banner
                      _buildPulseBanner(),
                      const SizedBox(height: 24),
                      // Core Layout Grid (Desktop Side-by-Side, Mobile Stacked)
                      isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildTelemetryMainCard(theme),
                                      const SizedBox(height: 24),
                                      _buildMapPreview(),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      _buildDeviceTelemetryCard(theme),
                                      const SizedBox(height: 24),
                                      _buildHeartbeatCard(),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildTelemetryMainCard(theme),
                                const SizedBox(height: 24),
                                _buildMapPreview(),
                                const SizedBox(height: 24),
                                _buildDeviceTelemetryCard(theme),
                                const SizedBox(height: 24),
                                _buildHeartbeatCard(),
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
      bottomNavigationBar: isDesktop ? null : _buildMobileBottomNavBar(context),
    );
  }

  // Active tracking animated pulse banner widget
  Widget _buildPulseBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.onTertiaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.onTertiaryContainer.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.between,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 8 * _pulseAnimation.value,
                          spreadRadius: 4 * _pulseAnimation.value,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              const Text(
                'CONTINUOUS TRACKING ACTIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Text(
            'SECURE CHANNEL',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // Main telemetry dashboard bento card
  Widget _buildTelemetryMainCard(ThemeData theme) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Safety Control Center',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Operational oversight for Site B perimeter monitoring.',
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.onTertiaryContainer,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'LIVE FEED',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Bento sub-grid
          Row(
            children: [
              Expanded(
                child: _buildBentoStat(
                  icon: Icons.location_on,
                  label: 'CURRENT LOCATION',
                  value: 'Site B',
                  subtext: 'North Sector 4',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildBentoStat(
                  icon: Icons.sync,
                  label: 'LAST SYNC',
                  value: '2s ago',
                  subtext: 'Data Stream: Stable',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildBentoStat(
                  icon: Icons.gps_fixed,
                  label: 'GPS PRECISION',
                  value: '0.8m',
                  subtext: 'High Accuracy',
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Quick actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ).value == null
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('SOS Signal Transmitted!')),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emergency, size: 24),
                            SizedBox(width: 12),
                            Text(
                              'QUICK SOS',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Manual check-in completed.')),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.how_to_reg, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'MANUAL CHECK-IN',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bento sub-stat helper
  Widget _buildBentoStat({
    required IconData icon,
    required String label,
    required String value,
    required String subtext,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: const TextStyle(
              color: AppColors.onPrimaryContainer,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Map preview card with overlay controls
  Widget _buildMapPreview() {
    return Container(
      height: 300,
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
          // Background satellite composite image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCeKy5MQgqL67dmUOrk6oVnztp6NU1Gi_pwCTeLGlusZtwzpdQWfGNbaicr1iszDG_F_mCx4Gpi6T7UlIXN30aZS0wlCAYvPolXin4buJ35VQkuRtHtRW5x7UYdGyJOXs1Xr3G350hqp3ftVG7Y0AsJYacUbcSt4DgE-Xma3zeDyMJ6Hno5NDQ9rJ5BgXhwmF_-NdUt1Qbu5Kxzhp0GGjQFxePHf8fB-JwgDouj-3aqoCUjkVSBRxqFtCvAVewXTUMdP5tA44sTcvY',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Zoom Controls floating right
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: AppColors.primary, size: 20),
                    onPressed: () {},
                  ),
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  IconButton(
                    icon: const Icon(Icons.remove, color: AppColors.primary, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          // Map category tag bottom-left
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Icon(Icons.layers, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'SATELLITE HYBRID',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Device Telemetry sidebar status board card
  Widget _buildDeviceTelemetryCard(ThemeData theme) {
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
          const Text(
            'Device Telemetry',
            style: TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 20),
          _buildTelemetryRow(
            icon: Icons.battery_full,
            label: 'Battery Level',
            value: '94%',
            color: AppColors.onTertiaryContainer,
          ),
          _buildTelemetryRow(
            icon: Icons.wifi,
            label: 'Network Latency',
            value: '18ms',
            color: AppColors.onTertiaryContainer,
          ),
          _buildTelemetryRow(
            icon: Icons.sensors,
            label: 'Sensor Mesh',
            value: 'OPTIMAL',
            color: Colors.transparent,
            hasBadge: true,
          ),
          _buildTelemetryRow(
            icon: Icons.lock,
            label: 'Encryption',
            value: 'AES-256',
            color: AppColors.onSurfaceVariant,
            isLast: true,
          ),
        ],
      ),
    );
  }

  // Telemetry item row helper
  Widget _buildTelemetryRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool hasBadge = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withOpacity(0.5),
                ),
              ),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.between,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.onSurfaceVariant, size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          if (hasBadge)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.tertiaryFixed,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'OPTIMAL',
                style: TextStyle(
                  color: AppColors.onTertiaryFixedVariant,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
        ],
      ),
    );
  }

  // Heartbeat signal generator card
  Widget _buildHeartbeatCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          // Glow overlay
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.15,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.onTertiaryContainer,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Heartbeat'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '72',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 0.9,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'BPM / SIGNAL PULSE',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Sparkline graph
              SizedBox(
                height: 48,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildPulseBarElement(heightFactor: 0.35, delayMs: 0),
                    _buildPulseBarElement(heightFactor: 0.70, delayMs: 200),
                    _buildPulseBarElement(heightFactor: 0.50, delayMs: 400),
                    _buildPulseBarElement(heightFactor: 0.90, delayMs: 600),
                    _buildPulseBarElement(heightFactor: 0.40, delayMs: 800),
                    _buildPulseBarElement(heightFactor: 0.80, delayMs: 1000),
                    _buildPulseBarElement(heightFactor: 0.35, delayMs: 1200),
                    _buildPulseBarElement(heightFactor: 0.60, delayMs: 1400),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper bar element for custom pulse animation
  Widget _buildPulseBarElement({required double heightFactor, required int delayMs}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 48 * heightFactor,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3 + (heightFactor * 0.4)),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
        ),
      ),
    );
  }

  // Sidebar navigation strip for desktop
  Widget _buildDesktopSidebar(BuildContext context) {
    return Container(
      width: 64,
      color: AppColors.primary,
      child: Column(
        children: [
          const SizedBox(height: 24),
          _buildSidebarIconButton(Icons.storage, () => context.go('/welcome_to_guardiannet')),
          const SizedBox(height: 24),
          _buildSidebarIconButton(Icons.chat_bubble, () {}),
          const SizedBox(height: 24),
          _buildSidebarIconButton(Icons.warning, () {}, active: true),
          const Spacer(),
          _buildSidebarIconButton(Icons.account_circle, () => context.go('/edit_profile')),
          const SizedBox(height: 16),
          _buildSidebarIconButton(Icons.settings, () => context.go('/notification_settings')),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // Sidebar action button builder
  Widget _buildSidebarIconButton(IconData icon, VoidCallback onTap, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: active ? AppColors.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: active ? Colors.white : Colors.white70,
          size: 24,
        ),
        onPressed: onTap,
      ),
    );
  }

  // Mobile Bottom nav bar
  Widget _buildMobileBottomNavBar(BuildContext context) {
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
            icon: Icon(Icons.warning),
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
          } else if (index == 3) {
            context.go('/edit_profile');
          }
        },
      ),
    );
  }
}
