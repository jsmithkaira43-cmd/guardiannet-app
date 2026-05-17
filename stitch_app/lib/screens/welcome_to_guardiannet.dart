import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class WelcomeToGuardiannetScreen extends StatelessWidget {
  const WelcomeToGuardiannetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Top Decorative Gradient Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.primary,
                  ],
                ),
              ),
            ),
          ),
          // Watermark in bottom right (Desktop only)
          if (isDesktop)
            const Positioned(
              bottom: 32,
              right: 32,
              child: Opacity(
                opacity: 0.05,
                child: Icon(
                  Icons.security,
                  size: 140,
                  color: AppColors.primary,
                ),
              ),
            ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      // Setup Complete Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.onTertiaryContainer.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AppColors.onTertiaryContainer.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.onTertiaryContainer,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'SETUP COMPLETE',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: AppColors.onTertiaryContainer,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Main Heading
                      Text(
                        'System Integrity Verified',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Subheading
                      Text(
                        'Your operative profile is now synced with the GuardianNet global security matrix. All protocols are active and monitoring is live.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Bento Grid Benefits Layout
                      isDesktop ? _buildDesktopBento() : _buildMobileBento(),
                      const SizedBox(height: 48),
                      // Enter Portal Action
                      ElevatedButton(
                        onPressed: () {
                          context.go('/admin_live_map_dashboard');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 8,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Enter Portal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Operative Signature Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.tertiaryFixedDim,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Signed in as Operative #0842 • Security Level 4',
                            style: TextStyle(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Desktop Bento Layout
  Widget _buildDesktopBento() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildHeroCard(height: 340),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildTrackingCard(height: 162),
                  const SizedBox(height: 16),
                  _buildAlertsCard(height: 162),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDetailCard(
                icon: Icons.security,
                title: 'ENCRYPTION',
                subtitle: 'AES-256 Multi-layer',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDetailCard(
                icon: Icons.storage,
                title: 'RECORDS',
                subtitle: 'Immutable Audit Logs',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDetailCard(
                icon: Icons.hub,
                title: 'NETWORK',
                subtitle: 'Mesh Protocol Enabled',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Mobile Bento Layout (Stacked)
  Widget _buildMobileBento() {
    return Column(
      children: [
        _buildHeroCard(height: 260),
        const SizedBox(height: 16),
        _buildTrackingCard(height: 140),
        const SizedBox(height: 16),
        _buildAlertsCard(height: 140),
        const SizedBox(height: 16),
        _buildDetailCard(
          icon: Icons.security,
          title: 'ENCRYPTION',
          subtitle: 'AES-256 Multi-layer',
        ),
        const SizedBox(height: 16),
        _buildDetailCard(
          icon: Icons.storage,
          title: 'RECORDS',
          subtitle: 'Immutable Audit Logs',
        ),
        const SizedBox(height: 16),
        _buildDetailCard(
          icon: Icons.hub,
          title: 'NETWORK',
          subtitle: 'Mesh Protocol Enabled',
        ),
      ],
    );
  }

  // Bento Component: Hero Card (Ready for Duty)
  Widget _buildHeroCard({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBUyuz7zqNvK93_qGXX23D2AsJ8cK6wBPo9VjnIgY4S14-DQC53d3OQBps8V56HdpWoeEJhGWQCqc6iR-k9MFOlKDz3MY47pbGBwSxQwGfn0e-imvG9ZyBeTuo451VN1fbjGxb_CcREyYiM4ul_E3mZ9tG8l0zI1SVXyUBmsXZfUgxdTGXegr8Krsj__ox_h3yI5WwqQezJ5MdudYvGSh9sSWg67VUYzEMM7_9aUtedkSopC-0D3Mwkysn38OQJyAPNzeDruu_OO1U',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.multiply,
          ),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.tertiaryFixedDim,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.security,
                  color: AppColors.tertiaryFixedDim,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SYSTEM STATUS',
                    style: TextStyle(
                      color: AppColors.tertiaryFixed,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    'Ready for Duty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('GPS Active', hasPulse: true),
              _buildTag('Encrypted Feed'),
              _buildTag('Biometric Sync'),
            ],
          ),
        ],
      ),
    );
  }

  // Bento Tag
  Widget _buildTag(String text, {bool hasPulse = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.tertiaryFixedDim,
              shape: BoxShape.circle,
              boxShadow: hasPulse
                  ? [
                      BoxShadow(
                        color: AppColors.tertiaryFixedDim.withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Bento Component: Tracking Card
  Widget _buildTrackingCard({required double height}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.location_on,
            color: AppColors.secondary,
            size: 28,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Precision Tracking',
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Sub-meter accuracy for personnel locations globally.',
                style: TextStyle(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bento Component: Alerts Card
  Widget _buildAlertsCard({required double height}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.notifications_active,
            color: AppColors.secondary,
            size: 28,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instant Alerts',
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Real-time emergency broadcast and response triggers.',
                style: TextStyle(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bento Component: Detail Card
  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
