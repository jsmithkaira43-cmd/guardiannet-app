import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class SafetyAnalyticsLogsScreen extends StatefulWidget {
  const SafetyAnalyticsLogsScreen({super.key});

  @override
  State<SafetyAnalyticsLogsScreen> createState() => _SafetyAnalyticsLogsScreenState();
}

class _SafetyAnalyticsLogsScreenState extends State<SafetyAnalyticsLogsScreen> {
  bool _isWeeklyChart = true;

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
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page Header Row
                      _buildPageHeader(theme),
                      const SizedBox(height: 32),

                      // First Row: Safety Score Radial Chart & Total Movements Bar Chart
                      isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: _buildSafetyScoreCard(theme),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 8,
                                  child: _buildMovementsBarChart(theme),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildSafetyScoreCard(theme),
                                const SizedBox(height: 24),
                                _buildMovementsBarChart(theme),
                              ],
                            ),

                      const SizedBox(height: 24),

                      // Second Row: Frequent Red Zone Entries & Safety Log Table
                      isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: _buildRedZoneHotspotsCard(theme),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 8,
                                  child: _buildSafetyLogTableCard(theme),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildRedZoneHotspotsCard(theme),
                                const SizedBox(height: 24),
                                _buildSafetyLogTableCard(theme),
                              ],
                            ),

                      const SizedBox(height: 24),

                      // Bottom Row: Automated Risk Assessment Banner
                      _buildRiskAssessmentBanner(theme),
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

  // Header row widget
  Widget _buildPageHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Movement Trends & Analytics',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Real-time telemetry and incident forecasting',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: const Row(
            children: [
              Icon(Icons.calendar_today, color: AppColors.outline, size: 16),
              SizedBox(width: 12),
              Text(
                'Oct 18, 2023 - Oct 24, 2023',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_drop_down, color: AppColors.outline, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  // Circular / Radial Safety Score Card (Left, Col-4)
  Widget _buildSafetyScoreCard(ThemeData theme) {
    return Container(
      height: 350,
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
            'Safety Score',
            style: TextStyle(
              color: AppColors.outline,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: 0.92,
                    strokeWidth: 12,
                    backgroundColor: AppColors.surfaceContainer,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.onTertiaryContainer,
                    ),
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '92%',
                      style: TextStyle(
                        color: AppColors.onTertiaryContainer,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'OPTIMAL',
                      style: TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.onTertiaryFixed.withOpacity(0.05),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: AppColors.onTertiaryFixedVariant,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '+4.2% from last week',
                    style: TextStyle(
                      color: AppColors.onTertiaryFixedVariant,
                      fontSize: 11,
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

  // Movements Bar Chart Card (Right, Col-8)
  Widget _buildMovementsBarChart(ThemeData theme) {
    return Container(
      height: 350,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Movements',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => setState(() => _isWeeklyChart = true),
                    style: TextButton.styleFrom(
                      backgroundColor: _isWeeklyChart ? AppColors.primaryContainer : Colors.transparent,
                      foregroundColor: _isWeeklyChart ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Weekly', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => setState(() => _isWeeklyChart = false),
                    style: TextButton.styleFrom(
                      backgroundColor: !_isWeeklyChart ? AppColors.primaryContainer : Colors.transparent,
                      foregroundColor: !_isWeeklyChart ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Daily', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Chart view
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barWidth = (constraints.maxWidth - 48) / 7;
                return Stack(
                  children: [
                    // Grid background lines
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (_) => Container(
                        height: 1,
                        color: AppColors.outlineVariant.withOpacity(0.3),
                      )),
                    ),
                    // Bars Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBar('Mon', 0.60, barWidth),
                        _buildBar('Tue', 0.75, barWidth),
                        _buildBar('Wed', 0.55, barWidth),
                        _buildBar('Thu', 0.85, barWidth),
                        _buildBar('Fri', 0.92, barWidth),
                        _buildBar('Sat', 0.40, barWidth),
                        _buildBar('Sun', 0.35, barWidth),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Custom Chart Bar Element
  Widget _buildBar(String day, double fraction, double barWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: barWidth - 12,
          height: 180 * fraction,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
          child: FractionallySizedBox(
            heightFactor: fraction,
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(
            color: AppColors.outline,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Frequent Red Zone Entries Card (Left, Col-4)
  Widget _buildRedZoneHotspotsCard(ThemeData theme) {
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
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Frequent Red Zone Entries',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hotspot density mapping',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Interactive Map Area
          Container(
            height: 192,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBDvWnlw79CBZ6S9r2eB29G7qjww0D1B2fsgdLqdg_0nzBSxYKt6OhjxtgGP_v4dKGuFdPiKHoecqTOvWZ_SB6CfR2qIPmbfqDe3V4cLaC9sqVIz6At93n2Bgocq9BUE6enOuoVCDfoWu9SfFk9TV2O85iP6yhsazmhb2nuDWxcBzryrDJSkaOygaPqX_QpP1-1PeOe2Y_eSmK9QV7OjK4bzwqbTHpRlJ-EByQmLx-xS9VRV_RNqQc0QUGk-KAhL2e8Q2KazJkdnRo',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white70,
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          // Hotspot lists
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildHotspotRow(
                  name: 'Storage Wing B',
                  hits: '42 Hits',
                  bgColor: AppColors.errorContainer.withOpacity(0.3),
                  textColor: AppColors.onErrorContainer,
                  dotColor: AppColors.error,
                ),
                const SizedBox(height: 12),
                _buildHotspotRow(
                  name: 'Main Power Grid',
                  hits: '18 Hits',
                  bgColor: AppColors.secondaryFixed.withOpacity(0.3),
                  textColor: AppColors.onSecondaryFixedVariant,
                  dotColor: AppColors.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hotspot item row builder
  Widget _buildHotspotRow({
    required String name,
    required String hits,
    required Color bgColor,
    required Color textColor,
    required Color dotColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          Text(
            hits,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // Safety Log Interactive Table Card (Right, Col-8)
  Widget _buildSafetyLogTableCard(ThemeData theme) {
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
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Safety Log',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 16),
                  label: const Text('Export CSV'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          // Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(AppColors.surfaceContainerLow),
              columnSpacing: 36,
              columns: const [
                DataColumn(label: Text('TIME', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.outline))),
                DataColumn(label: Text('OPERATOR', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.outline))),
                DataColumn(label: Text('ACTION / EVENT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.outline))),
                DataColumn(label: Text('STATUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.outline))),
              ],
              rows: [
                _buildTableRow(
                  time: '14:22:15',
                  operator: 'Marcus Chen',
                  event: 'Entered Red Zone A',
                  badgeText: 'ALERT',
                  badgeBg: AppColors.errorContainer,
                  badgeFg: AppColors.onErrorContainer,
                  isCriticalEvent: true,
                ),
                _buildTableRow(
                  time: '13:45:02',
                  operator: 'Sarah Jenkins',
                  event: 'Triggered remote alarm: Hub-4',
                  badgeText: 'RESOLVED',
                  badgeBg: AppColors.secondaryFixed,
                  badgeFg: AppColors.onSecondaryFixedVariant,
                ),
                _buildTableRow(
                  time: '12:10:44',
                  operator: 'System Auto',
                  event: 'Geofence validation complete',
                  badgeText: 'INFO',
                  badgeBg: AppColors.surfaceContainer,
                  badgeFg: AppColors.onPrimaryContainer,
                ),
                _buildTableRow(
                  time: '11:58:30',
                  operator: 'Alex Rivera',
                  event: 'Exit protocol initiated: Zone C',
                  badgeText: 'SUCCESS',
                  badgeBg: AppColors.tertiaryFixed,
                  badgeFg: AppColors.onTertiaryFixedVariant,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // DataTable Row helper
  DataRow _buildTableRow({
    required String time,
    required String operator,
    required String event,
    required String badgeText,
    required Color badgeBg,
    required Color badgeFg,
    bool isCriticalEvent = false,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(time, style: const TextStyle(fontSize: 13, fontFamily: 'monospace'))),
        DataCell(Text(operator, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
        DataCell(
          isCriticalEvent
              ? RichText(
                  text: const TextSpan(
                    text: 'Entered ',
                    style: TextStyle(color: AppColors.onSurface, fontSize: 13),
                    children: [
                      TextSpan(
                        text: 'Red Zone A',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary),
                      ),
                    ],
                  ),
                )
              : Text(event, style: const TextStyle(fontSize: 13)),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                color: badgeFg,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Risk Assessment Banner (Bottom)
  Widget _buildRiskAssessmentBanner(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          // Gradient layout accent
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.15,
              child: Container(
                width: 250,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, AppColors.secondary],
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Automated Risk Assessment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Based on last week's movement trends, the system predicts a 15% increase in unauthorized entries during shift transitions. We recommend adjusting geofence sensitivities between 18:00 and 19:00.",
                style: TextStyle(
                  color: AppColors.primaryFixedDim,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recommendations applied successfully.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply Recommendations',
                  style: TextStyle(
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
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBhYR3phe2I_w6PTyiuLp6R7GbMmH3lzDLM1IlTM8_HoLEY2IVCdxIPS6orabYO-vHjxZc-jy9LxYFrRSqeElEZz--qC5SugLybDfC7W51_5ZEVRIrJ0-oWr28iYMe9WCye6Lm3ChMhCqas0eTsFcYmYgIALJs58u87ZtVTC94yGME2cewE3LuGUZzI8UMyEmSPeyhdmBQLUs-Eu3B-m5fjJ3gdjUZ5wlLs7tQkSKxYpRFqb_lJHul1JRfMd_Xh39fWEfELcW0g0_U',
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
          _buildSidebarLink(context, Icons.insights, 'Safety Analytics', '/safety_analytics_logs', active: true),
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
