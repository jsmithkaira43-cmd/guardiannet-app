import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class TeamManagementScreen extends StatefulWidget {
  const TeamManagementScreen({super.key});

  @override
  State<TeamManagementScreen> createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends State<TeamManagementScreen> {
  String _selectedRoleFilter = 'Role: All';
  String _selectedStatusFilter = 'Status: All';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          // Sidebar drawer for Desktop
          if (isDesktop) _buildSidebar(context),
          // Scrollable content area
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
                      // Page Header
                      _buildPageHeader(theme),
                      const SizedBox(height: 32),
                      // Search and Filter Bar
                      _buildSearchFilterBar(),
                      const SizedBox(height: 24),
                      // Active Personnel List Card
                      _buildPersonnelListCard(theme),
                      const SizedBox(height: 24),
                      // Pending Invites Section
                      _buildPendingInvitesCard(theme),
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

  // Page Header Component
  Widget _buildPageHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Member Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Configure access levels, monitor duty status, and manage security credentials for all personnel within the GuardianNet ecosystem.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {
            context.go('/add_new_member');
          },
          icon: const Icon(Icons.person_add, size: 18),
          label: const Text('Add Member'),
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

  // Search and Filter Bar Component
  Widget _buildSearchFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          // Search box
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search members by name, email, or ID...',
                prefixIcon: const Icon(Icons.search, color: AppColors.outline),
                filled: true,
                fillColor: AppColors.surfaceContainerLowest,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.outlineVariant),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Filter options dropdowns
          _buildDropdownFilter(
            value: _selectedRoleFilter,
            items: ['Role: All', 'Admin', 'Field Staff', 'Dispatcher'],
            onChanged: (val) => setState(() => _selectedRoleFilter = val!),
          ),
          const SizedBox(width: 12),
          _buildDropdownFilter(
            value: _selectedStatusFilter,
            items: ['Status: All', 'On-Duty', 'Off-Duty', 'Away'],
            onChanged: (val) => setState(() => _selectedStatusFilter = val!),
          ),
        ],
      ),
    );
  }

  // Dropdown helper
  Widget _buildDropdownFilter({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.expand_more, color: AppColors.outline, size: 20),
          style: const TextStyle(color: AppColors.onSurface, fontSize: 13, fontWeight: FontWeight.bold),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Active Personnel List Card Component
  Widget _buildPersonnelListCard(ThemeData theme) {
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
          // Sub-Header
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Personnel',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    '12 Members Total',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Personnel rows
          _buildPersonnelRow(
            avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAeVv0ioI_YHxViDCjQH6TxSc1-Jqk5lnhnZ7WwlsNg3Nd-JtQpeN-266ym7u-5NmlENh-Oot1LuQ06yrbyuyc_Xlo6DM8GZbQ5QUUKBBxxxYxHnr4nco7Rk7dZ_Hb3dBcxOOzobGGH-XivlmM5VKwx2NPo1tIOHdP0MKy2DVI0dfZEJNPNaAEg7DYwCuOBXA-U_DjwrSzXy1t2-6NrCZMjDWxnRaXMXjOV3TyWLtBcxVbyLibSv3rcY_blIaw6yCPPAZ8x8JRW8is',
            name: 'Marcus Vance',
            role: 'Admin',
            roleIcon: Icons.shield,
            status: 'On-Duty',
            statusColor: AppColors.tertiaryFixedDim,
            textColor: AppColors.onTertiaryFixedVariant,
            location: 'HQ North Terminal',
            isOnline: true,
          ),
          _buildPersonnelRow(
            avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXu89m1Whu4RlG5hfnnXtSR7eAK35t3hPrjQH5B4lb46kCs-q1UBKfv7iK_9bQCLemzqHS6mJULS7acPWi2D5crXp1CU2DKywCC1S_PpHfw5S1Oq6uQnTTU0z8y-b1gcX_YeNtvmGmbKckbo1yqbZHQ4zIc_lNWvponeQyfxcS6qhWV36G6J49o4O5zLRZ2fgZ_u_zT2SjbYczKjVcEEMnd6BpSFHYlyIcgMlcjtPuqxFumwgfBmOrJczgbzMlnohoTqdiEEBwTK7DA',
            name: 'Elena Rodriguez',
            role: 'Field Staff',
            roleIcon: Icons.directions_walk,
            status: 'On-Duty',
            statusColor: AppColors.tertiaryFixedDim,
            textColor: AppColors.onTertiaryFixedVariant,
            location: 'Sector 4 Patrol',
            isOnline: true,
          ),
          _buildPersonnelRow(
            avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD8sEIuUFFAEy8bW2Ubm2J_Wf_mi303vzaHz-h8SmsJ7jPP0lMM3vCthG5OVzceb4dyqfmPr2NFN7OG_OgcnkjColU8hGOiqHlwgPZW_4-kODVTpOI6-H-kU8duDAhbo0TK2QP59M31tXSG7ywkGnj6yQclHWmxyZu1kq_1GeV1Vq25eRLTLFQUh6CLVPkEiSnSnwg26GONnwjeVlK8Gs1Fzaa7p39cgdrcC7BrMfWxy51b_Rri_C_bdxGEth92mFUU1XYPzgnJS7w',
            name: 'Julian Chen',
            role: 'Dispatcher',
            roleIcon: Icons.support_agent,
            status: 'Off-Duty',
            statusColor: AppColors.outlineVariant,
            textColor: AppColors.onSurfaceVariant,
            location: 'Last active: 2h ago',
            isOnline: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  // Personnel item row helper
  Widget _buildPersonnelRow({
    required String avatarUrl,
    required String name,
    required String role,
    required IconData roleIcon,
    required String status,
    required Color statusColor,
    required Color textColor,
    required String location,
    required bool isOnline,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryFixedDim, width: 2),
                      image: DecorationImage(
                        image: NetworkImage(avatarUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: isOnline ? Colors.green : AppColors.outline,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(roleIcon, size: 14, color: AppColors.onSurfaceVariant),
                      const SizedBox(width: 6),
                      Text(
                        role,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.key, size: 16),
                label: const Text('Permissions'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.onSurfaceVariant,
                  side: const BorderSide(color: AppColors.outline),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pending invites list card Component
  Widget _buildPendingInvitesCard(ThemeData theme) {
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
          // Sub-Header
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invite Pending',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryFixed,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    '2 Pending',
                    style: TextStyle(
                      color: AppColors.onSecondaryFixedVariant,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Invite Row 1
          _buildInviteRow(
            email: 'sarah.j@guardian.net',
            role: 'Field Staff',
          ),
          _buildInviteRow(
            email: 'tech_lead_09@external.com',
            role: 'Admin',
            isLast: true,
          ),
        ],
      ),
    );
  }

  // Invite item row helper
  Widget _buildInviteRow({
    required String email,
    required String role,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.outline, style: BorderStyle.none),
                ),
                child: const Icon(Icons.mail, color: AppColors.outline),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      text: 'Invited as: ',
                      style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12),
                      children: [
                        TextSpan(
                          text: role,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: AppColors.onSurfaceVariant),
                child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.outlineVariant),
                  ),
                ),
                child: const Text('Resend', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryContainer,
                  ),
                  child: const Icon(Icons.group, color: Colors.white),
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
          _buildSidebarLink(context, Icons.group, 'Team Management', '/team_management', active: true),
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
            icon: Icon(Icons.group),
            label: 'Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            context.go('/welcome_to_guardiannet');
          } else if (index == 1) {
            context.go('/active_tracking_status');
          } else if (index == 3) {
            context.go('/edit_profile');
          }
        },
      ),
    );
  }
}
