import 'package:flutter/material.dart';
import 'dart:ui';
import 'design_system.dart';

/// Redesigned Profile Page - Professional Personal Journey Hub
/// Modern, motivational dashboard inspired by Meditopia

class JourneyProfilePage extends StatelessWidget {
  const JourneyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Premium background - Warm Cream
        Container(
          color: AppColors.warmCream,
        ),

        SafeArea(
          child: CustomScrollView(
            slivers: [
              // 1. Refined Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Greeting
                      Text(
                        'Merhaba, Sinem',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkPlum,
                          letterSpacing: 0.5,
                        ),
                      ),

                      // Settings Icon
                      AnimatedButton(
                        onPressed: () {
                          // Navigate to settings
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.dustyRose.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.settings_rounded,
                            color: AppColors.darkPlum,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Dynamic Stats Dashboard (The Motivational Centerpiece)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.dustyRose,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkPlum.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Stat 1 - Daily Streak (HIGHLIGHT)
                        Expanded(
                          child: _buildDashboardStat(
                            icon: Icons.local_fire_department_rounded,
                            value: '14',
                            label: 'Günlük Seri',
                            isHighlight: true,
                          ),
                        ),
                        
                        Container(
                          width: 1,
                          height: 60,
                          color: AppColors.darkPlum.withOpacity(0.1),
                        ),

                        // Stat 2 - Total Minutes
                        Expanded(
                          child: _buildDashboardStat(
                            icon: Icons.access_time_rounded,
                            value: '280',
                            label: 'Toplam Dakika',
                            isHighlight: false,
                          ),
                        ),
                        
                        Container(
                          width: 1,
                          height: 60,
                          color: AppColors.darkPlum.withOpacity(0.1),
                        ),

                        // Stat 3 - Completed Sessions
                        Expanded(
                          child: _buildDashboardStat(
                            icon: Icons.check_circle_rounded,
                            value: '25',
                            label: 'Tamamlanan Seans',
                            isHighlight: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // 3. Activity Calendar (Visual Progress Tracker)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aktivite Takvimi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkPlum,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildActivityCalendar(),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // 4. Achievements / Badges Section
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Kazanımlar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkPlum,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: [
                          _buildBadge(
                            icon: Icons.star_rounded,
                            label: 'İlk Seans',
                            isUnlocked: true,
                          ),
                          const SizedBox(width: 12),
                          _buildBadge(
                            icon: Icons.local_fire_department_rounded,
                            label: '7 Günlük Seri',
                            isUnlocked: true,
                          ),
                          const SizedBox(width: 12),
                          _buildBadge(
                            icon: Icons.nightlight_round,
                            label: 'Uyku Ustası',
                            isUnlocked: true,
                          ),
                          const SizedBox(width: 12),
                          _buildBadge(
                            icon: Icons.center_focus_strong,
                            label: 'Odaklanma Pro',
                            isUnlocked: false,
                          ),
                          const SizedBox(width: 12),
                          _buildBadge(
                            icon: Icons.spa_rounded,
                            label: 'Zen Ustası',
                            isUnlocked: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // 5. Organized Menu List
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Group 1 Header
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 12),
                        child: Text(
                          'İÇERİKLERİM',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lighterPlum.withOpacity(0.6),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkPlum.withOpacity(0.04),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              icon: Icons.favorite_rounded,
                              label: 'Favorilerim',
                              onTap: () {},
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              icon: Icons.download_rounded,
                              label: 'İndirilenler',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Group 2 Header
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 12),
                        child: Text(
                          'TERCİHLER',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lighterPlum.withOpacity(0.6),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkPlum.withOpacity(0.04),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              icon: Icons.notifications_rounded,
                              label: 'Hatırlatıcılar',
                              onTap: () {},
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              icon: Icons.help_outline_rounded,
                              label: 'Yardım & Destek',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ],
    );
  }

  // Stats Dashboard Item
  Widget _buildDashboardStat({
    required IconData icon,
    required String value,
    required String label,
    bool isHighlight = false,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: isHighlight ? AppColors.softGold : AppColors.lighterPlum,
          size: 28,
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isHighlight ? AppColors.softGold : AppColors.darkPlum,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.lighterPlum.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  // Activity Calendar Heatmap
  Widget _buildActivityCalendar() {
    return Container(
      height: 120,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 28,
        itemBuilder: (context, index) {
          // Mock data: random activity for demo
          final isActive = index % 3 != 0;
          return Container(
            decoration: BoxDecoration(
              color: isActive 
                ? AppColors.softGold.withOpacity(0.8)
                : AppColors.dustyRose.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
          );
        },
      ),
    );
  }

  // Achievement Badge
  Widget _buildBadge({
    required IconData icon,
    required String label,
    required bool isUnlocked,
  }) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isUnlocked
              ? LinearGradient(
                  colors: [
                    AppColors.softGold,
                    AppColors.softGold.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    AppColors.dustyRose.withOpacity(0.3),
                    AppColors.dustyRose.withOpacity(0.2),
                  ],
                ),
            boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: AppColors.softGold.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
          ),
          child: Icon(
            icon,
            color: isUnlocked ? Colors.white : AppColors.lighterPlum.withOpacity(0.3),
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isUnlocked ? AppColors.darkPlum : AppColors.lighterPlum.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool showBadge = false,
  }) {
    return AnimatedButton(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.lightPeach,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.darkPlum,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkPlum,
                ),
              ),
            ),
            if (showBadge)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF6B6B),
                  shape: BoxShape.circle,
                ),
              ),
            const SizedBox(width: 12),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.lighterPlum,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 1,
        color: AppColors.darkPlum.withOpacity(0.08),
      ),
    );
  }
}
