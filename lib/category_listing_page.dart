import 'package:flutter/material.dart';
import 'dart:ui';
import 'meditation_detail_page.dart';

// Color Constants
class AppColors {
  static const warmCream = Color(0xFFFFFDD0);
  static const dustyRose = Color(0xFFFADCD9);
  static const darkPlum = Color(0xFF4A2C4B);
  static const softGold = Color(0xFFD4AF37);
  static const lightPeach = Color(0xFFFFF5E6);
  static const lighterPlum = Color(0xFF6B4C6D);
}

class CategoryListingPage extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;
  final String categoryType;
  final List<Map<String, dynamic>> meditations;

  const CategoryListingPage({
    super.key,
    required this.categoryName,
    required this.categoryDescription,
    required this.categoryType,
    required this.meditations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildHeroSection(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _buildMeditationCard(context, meditations[index]);
                        },
                        childCount: meditations.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkPlum,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              categoryName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.darkPlum,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Hero Image
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: _getCategoryGradient(),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkPlum.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _getCategoryBackgroundPainter(),
                    ),
                  ),
                  Center(
                    child: Icon(
                      _getCategoryIcon(),
                      size: 60,
                      color: AppColors.darkPlum.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Inspirational Quote/Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              categoryDescription,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: AppColors.darkPlum.withOpacity(0.8),
                height: 1.5,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          // Meditation Count
          Text(
            '${meditations.length} Meditasyon',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.lighterPlum,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationCard(BuildContext context, Map<String, dynamic> meditation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Safely cast gradient to List<Color>
            List<Color> gradientColors;
            if (meditation['gradient'] != null) {
              gradientColors = (meditation['gradient'] as List).cast<Color>();
            } else {
              gradientColors = _getCategoryGradientColors();
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeditationDetailPage(
                  meditation: Meditation(
                    title: meditation['title'],
                    shortDescription: meditation['description'],
                    detailedDescription: meditation['detailedDescription'],
                    duration: meditation['duration'],
                    heroImageType: meditation['type'] ?? categoryType,
                    heroGradient: gradientColors,
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Thumbnail
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: meditation['gradient'] != null
                          ? (meditation['gradient'] as List).cast<Color>()
                          : _getCategoryGradientColors(),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getCategoryIcon(),
                      size: 32,
                      color: AppColors.darkPlum.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meditation['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkPlum,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            meditation['duration'],
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.darkPlum.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            ' • ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.darkPlum.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            meditation['type'] ?? 'Rehberli Meditasyon',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.darkPlum.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Play Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.softGold.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: AppColors.softGold,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_outlined,
                label: 'Anasayfa',
                isActive: true,
                onTap: () => Navigator.pop(context),
              ),
              _buildNavItem(
                icon: Icons.explore_outlined,
                label: 'Keşfet',
                isActive: false,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.favorite_border,
                label: 'Favoriler',
                isActive: false,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profil',
                isActive: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.softGold : AppColors.lighterPlum,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.softGold : AppColors.lighterPlum,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _getCategoryGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: _getCategoryGradientColors(),
    );
  }

  List<Color> _getCategoryGradientColors() {
    switch (categoryType) {
      case 'sleep':
        return [const Color(0xFFFADCD9), const Color(0xFFF4C2C2)];
      case 'stress':
        return [const Color(0xFFFFE5B4), const Color(0xFFFFD6BA)];
      case 'focus':
        return [const Color(0xFFFFD6BA), const Color(0xFFFADCD9)];
      case 'breathwork':
        return [const Color(0xFFFFF5E6), const Color(0xFFFADCD9)];
      case 'morning':
        return [const Color(0xFFFFF5E6), const Color(0xFFFFE5B4)];
      case 'gratitude':
        return [const Color(0xFFFFD6BA), const Color(0xFFFFF5E6)];
      default:
        return [const Color(0xFFFADCD9), const Color(0xFFFFF5E6)];
    }
  }

  IconData _getCategoryIcon() {
    switch (categoryType) {
      case 'sleep':
        return Icons.nightlight_round;
      case 'stress':
        return Icons.self_improvement;
      case 'focus':
        return Icons.center_focus_strong;
      case 'breathwork':
        return Icons.air;
      case 'morning':
        return Icons.wb_sunny;
      case 'gratitude':
        return Icons.favorite;
      default:
        return Icons.spa;
    }
  }

  CustomPainter _getCategoryBackgroundPainter() {
    return CategoryHeroPainter(categoryType);
  }
}

// Category Hero Background Painter
class CategoryHeroPainter extends CustomPainter {
  final String categoryType;

  CategoryHeroPainter(this.categoryType);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    switch (categoryType) {
      case 'sleep':
        _paintSleepPattern(canvas, size, paint);
        break;
      case 'stress':
        _paintStressPattern(canvas, size, paint);
        break;
      case 'focus':
        _paintFocusPattern(canvas, size, paint);
        break;
      case 'breathwork':
        _paintBreathworkPattern(canvas, size, paint);
        break;
      default:
        _paintDefaultPattern(canvas, size, paint);
    }
  }

  void _paintSleepPattern(Canvas canvas, Size size, Paint paint) {
    // Soft clouds effect
    for (int i = 0; i < 5; i++) {
      paint.color = AppColors.softGold.withOpacity(0.1 - i * 0.015);
      final radius = 40.0 + i * 15;
      canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.4),
        radius,
        paint,
      );
      canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.6),
        radius * 0.8,
        paint,
      );
    }
  }

  void _paintStressPattern(Canvas canvas, Size size, Paint paint) {
    // Calm water ripples
    for (int i = 0; i < 4; i++) {
      paint.color = AppColors.softGold.withOpacity(0.08 - i * 0.015);
      final radius = 50.0 + i * 25;
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.5),
        radius,
        paint,
      );
    }
  }

  void _paintFocusPattern(Canvas canvas, Size size, Paint paint) {
    // Concentric circles
    final center = Offset(size.width * 0.5, size.height * 0.5);
    for (int i = 0; i < 5; i++) {
      paint.color = AppColors.softGold.withOpacity(0.1 - i * 0.018);
      canvas.drawCircle(center, 30.0 + i * 20, paint);
    }
  }

  void _paintBreathworkPattern(Canvas canvas, Size size, Paint paint) {
    // Wave pattern
    final path = Path();
    path.moveTo(0, size.height * 0.6);
    
    for (double i = 0; i <= size.width; i += 20) {
      path.lineTo(i, size.height * 0.6 + 15 * (i % 40 == 0 ? 1 : -1));
    }
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    paint.color = AppColors.softGold.withOpacity(0.1);
    canvas.drawPath(path, paint);
  }

  void _paintDefaultPattern(Canvas canvas, Size size, Paint paint) {
    // Simple gradient overlay
    paint.color = AppColors.softGold.withOpacity(0.05);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CategoryHeroPainter oldDelegate) => false;
}
