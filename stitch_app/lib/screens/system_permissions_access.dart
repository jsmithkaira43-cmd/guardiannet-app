import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class SystemPermissionsAccessScreen extends StatefulWidget {
  const SystemPermissionsAccessScreen({super.key});

  @override
  State<SystemPermissionsAccessScreen> createState() => _SystemPermissionsAccessScreenState();
}

class _SystemPermissionsAccessScreenState extends State<SystemPermissionsAccessScreen> {
  bool _locationGranted = false;
  bool _backgroundRefreshGranted = false;
  bool _motionSensorsGranted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 48.0 : 16.0,
          vertical: 40.0,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Hero Section
                _buildHeroSection(theme),
                const SizedBox(height: 48),

                // Permission Bento Grid
                isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildPermissionCard(
                              icon: Icons.location_on,
                              title: 'Live Safety Tracking',
                              description: "Requires 'Always Allow' location access to monitor your path and alert emergency services if you deviate from your route.",
                              tagText: 'CRITICAL ACCESS',
                              tagColor: AppColors.primaryFixedDim,
                              isGranted: _locationGranted,
                              onTap: () => setState(() => _locationGranted = !_locationGranted),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildPermissionCard(
                              icon: Icons.sync,
                              title: 'Automated Check-ins',
                              description: 'Background Refresh ensures the app remains active to confirm your arrival at destinations even when your phone is locked.',
                              tagText: 'OPTIMIZATION REQUIRED',
                              tagColor: AppColors.surfaceContainerHigh,
                              isGranted: _backgroundRefreshGranted,
                              onTap: () => setState(() => _backgroundRefreshGranted = !_backgroundRefreshGranted),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildPermissionCard(
                              icon: Icons.directions_run,
                              title: 'Emergency Response',
                              description: 'Motion & Fitness sensors detect sudden falls or high-impact events to automatically trigger distress protocols.',
                              tagText: 'AUTO-DETECTION',
                              tagColor: AppColors.surfaceContainerHigh,
                              isGranted: _motionSensorsGranted,
                              onTap: () => setState(() => _motionSensorsGranted = !_motionSensorsGranted),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildPermissionCard(
                            icon: Icons.location_on,
                            title: 'Live Safety Tracking',
                            description: "Requires 'Always Allow' location access to monitor your path and alert emergency services if you deviate from your route.",
                            tagText: 'CRITICAL ACCESS',
                            tagColor: AppColors.primaryFixedDim,
                            isGranted: _locationGranted,
                            onTap: () => setState(() => _locationGranted = !_locationGranted),
                          ),
                          const SizedBox(height: 16),
                          _buildPermissionCard(
                            icon: Icons.sync,
                            title: 'Automated Check-ins',
                            description: 'Background Refresh ensures the app remains active to confirm your arrival at destinations even when your phone is locked.',
                            tagText: 'OPTIMIZATION REQUIRED',
                            tagColor: AppColors.surfaceContainerHigh,
                            isGranted: _backgroundRefreshGranted,
                            onTap: () => setState(() => _backgroundRefreshGranted = !_backgroundRefreshGranted),
                          ),
                          const SizedBox(height: 16),
                          _buildPermissionCard(
                            icon: Icons.directions_run,
                            title: 'Emergency Response',
                            description: 'Motion & Fitness sensors detect sudden falls or high-impact events to automatically trigger distress protocols.',
                            tagText: 'AUTO-DETECTION',
                            tagColor: AppColors.surfaceContainerHigh,
                            isGranted: _motionSensorsGranted,
                            onTap: () => setState(() => _motionSensorsGranted = !_motionSensorsGranted),
                          ),
                        ],
                      ),

                const SizedBox(height: 48),

                // Privacy Graphic Banner
                _buildPrivacyBanner(isDesktop),

                const SizedBox(height: 48),

                // Actions Section
                _buildActionSection(context),

                const SizedBox(height: 64),
                // Footer
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hero Title & Subtitle
  Widget _buildHeroSection(ThemeData theme) {
    return Column(
      children: [
        const Text(
          'Secure Your Journey',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const Text(
            'To provide real-time protection and automated safety alerts, GuardianNet requires high-precision system access. Your data is encrypted and used only for your safety.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // Permission Bento card builder
  Widget _buildPermissionCard({
    required IconData icon,
    required String title,
    required String description,
    required String tagText,
    required Color tagColor,
    required bool isGranted,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isGranted ? AppColors.tertiaryFixed.withOpacity(0.1) : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isGranted ? AppColors.tertiaryFixed : AppColors.outlineVariant,
            width: isGranted ? 2 : 1,
          ),
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isGranted ? AppColors.tertiaryFixed : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isGranted ? AppColors.onTertiaryFixedVariant : AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isGranted ? AppColors.tertiaryFixed : tagColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isGranted ? 'ACCESS GRANTED' : tagText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isGranted ? AppColors.onTertiaryFixedVariant : AppColors.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Privacy banner graphic area
  Widget _buildPrivacyBanner(bool isDesktop) {
    final bannerContent = Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enterprise-Grade Privacy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'GuardianNet uses end-to-end encryption for all telemetry data. Your location history is never sold to third parties and is automatically purged after 48 hours of safe activity.',
            style: TextStyle(
              color: AppColors.primaryFixedDim,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.tertiaryFixedDim,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'GDPR & HIPAA Compliant Data Handling',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final imageWidget = Container(
      height: 260,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCisq8fdD7c2UhSVeeh9WhEu6I3nqLFP64wmOWxAgPlj5uIoBVoiUK15ewY4eO7MLVIAMyifJRahuxFxts2_sc0RJsaH9kHa44MqlgX5zO0CzMZrk2dk6lHaR4gjftS8CEPu2kNcnj7ADGXC8sG4JnndmZGsJRkAPfN3XrVPWcHSoTtUVwbSVHHMjzmxkmIeWkvG4H7ujir9k0YqHrZ4j4-cFm_4ek0be_E9969vKbinMIUSnNlche3qo33N_J1Pxub2FqhwIQzXe4',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: isDesktop
            ? Row(
                children: [
                  Expanded(flex: 6, child: bannerContent),
                  Expanded(flex: 5, child: imageWidget),
                ],
              )
            : Column(
                children: [
                  bannerContent,
                  imageWidget,
                ],
              ),
      ),
    );
  }

  // Grant Permissions & Privacy Policy buttons
  Widget _buildActionSection(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _locationGranted = true;
                _backgroundRefreshGranted = true;
                _motionSensorsGranted = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All System Permissions Granted Successfully!')),
              );
              Future.delayed(const Duration(milliseconds: 800), () {
                context.go('/welcome_to_guardiannet');
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield, size: 20),
                SizedBox(width: 12),
                Text(
                  'Grant All Permissions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.policy, size: 16),
            label: const Text('Review Privacy Policy'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.onSurfaceVariant,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Footer Component
  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(color: AppColors.outlineVariant),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, color: AppColors.primary, size: 16),
            const SizedBox(width: 8),
            Text(
              'GuardianNet Protection Suite'.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          '© 2024 GuardianNet Technologies. All rights reserved.',
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
