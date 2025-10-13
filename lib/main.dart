import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'meditation_detail_page.dart';

void main() {
  runApp(const KozmosApp());
}

// Color Constants
class AppColors {
  static const warmCream = Color(0xFFFFFDD0);
  static const dustyRose = Color(0xFFFADCD9);
  static const darkPlum = Color(0xFF4A2C4B);
  static const softGold = Color(0xFFD4AF37);
  static const lightPeach = Color(0xFFFFF5E6);
  static const lighterPlum = Color(0xFF6B4C6D);
}

class KozmosApp extends StatelessWidget {
  const KozmosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kozmos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFFADCD9), // Dusty Rose
        scaffoldBackgroundColor: const Color(0xFFFFFDD0), // Warm Cream
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
            color: Color(0xFF4A2C4B), // Dark Plum
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xFF4A2C4B), // Dark Plum
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Color(0xFF6B4C6D), // Lighter Plum
          ),
        ),
      ),
      home: const KozmosHomePage(),
    );
  }
}

class KozmosHomePage extends StatefulWidget {
  const KozmosHomePage({super.key});

  @override
  State<KozmosHomePage> createState() => _KozmosHomePageState();
}

class _KozmosHomePageState extends State<KozmosHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const CosmicBackground(),
          
          // Main Content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // Header with greeting
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Merhaba, Sinem',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkPlum,
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.dustyRose,
                          child: const Icon(
                            Icons.person_outline,
                            color: AppColors.darkPlum,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Featured Daily Meditation
                const SliverToBoxAdapter(child: DailyMeditationCard()),
                
                // Featured Carousel
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Öne Çıkanlar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkPlum,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const FeaturedCarousel(),
                      ],
                    ),
                  ),
                ),
                
                // Categories Grid
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kategoriler',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkPlum,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const CategoriesGrid(),
                      ],
                    ),
                  ),
                ),
                
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.warmCream,
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPlum.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_rounded, 'Ana Sayfa', 0),
                _buildNavItem(Icons.explore_outlined, 'Keşfet', 1),
                _buildNavItem(Icons.favorite_border, 'Favoriler', 2),
                _buildNavItem(Icons.person_outline, 'Profil', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.softGold : AppColors.lighterPlum,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? AppColors.softGold : AppColors.lighterPlum,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// Cosmic Background with animated stars
class CosmicBackground extends StatefulWidget {
  const CosmicBackground({super.key});

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF5E6), // Light Peach
            Color(0xFFFFFDD0), // Warm Cream
            Color(0xFFFADCD9), // Dusty Rose
            Color(0xFFFFF0E6), // Soft Peach
          ],
          stops: [0.0, 0.3, 0.6, 1.0],
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: StarsPainter(_controller.value),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class StarsPainter extends CustomPainter {
  final double animationValue;

  StarsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37) // Gold
      ..strokeWidth = 1;

    final random = math.Random(42);
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final opacity = (math.sin(animationValue * 2 * math.pi + i) + 1) / 2;
      paint.color = const Color(0xFFD4AF37).withOpacity(opacity * 0.4); // Gold sparkles
      canvas.drawCircle(Offset(x, y), random.nextDouble() * 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) => true;
}

// Daily Meditation Card (Günün Meditasyonu)
class DailyMeditationCard extends StatelessWidget {
  const DailyMeditationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.dustyRose.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Abstract background pattern
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.softGold.withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkPlum.withOpacity(0.08),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softGold.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Günün Meditasyonu',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkPlum,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sabah Huzuru',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkPlum,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '10 Dakika',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.lighterPlum,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MeditationDetailPage(
                          meditation: Meditation(
                            title: 'Sabah Huzuru',
                            shortDescription: 'Güne huzurlu bir başlangıç yapın',
                            detailedDescription: 'Bu meditasyon, güne pozitif bir enerji ile başlamanıza yardımcı olur. Sabah saatlerinde yapılan bu nefes egzersizleri ve farkındalık pratikleri, gününüzü daha sakin ve dengeli geçirmenize katkı sağlar. Düzenli olarak yapıldığında, genel refah halinizi artırır ve stres seviyenizi düşürür.',
                            duration: '10 Dakika',
                            heroImageType: 'focus',
                            heroGradient: [
                              const Color(0xFFFFD6BA),
                              const Color(0xFFFADCD9),
                            ],
                            relatedMeditations: [],
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.softGold,
                    foregroundColor: AppColors.darkPlum,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Başla',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
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

// Featured Carousel (Öne Çıkanlar)
class FeaturedCarousel extends StatelessWidget {
  const FeaturedCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = [
      {
        'title': 'Derin Uyku',
        'duration': '15 dk',
        'description': 'Rahat ve derin bir uyku için',
        'type': 'sleep',
        'gradient': [const Color(0xFFFADCD9), const Color(0xFFF4C2C2)],
      },
      {
        'title': 'Stres Azaltma',
        'duration': '12 dk',
        'description': 'Sakinliğini bul',
        'type': 'stress',
        'gradient': [const Color(0xFFFFE5B4), const Color(0xFFFFD6BA)],
      },
      {
        'title': 'Odaklanma',
        'duration': '8 dk',
        'description': 'Zihinsel netlik kazanın',
        'type': 'focus',
        'gradient': [const Color(0xFFFFD6BA), const Color(0xFFFADCD9)],
      },
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featured.length,
        itemBuilder: (context, index) {
          final item = featured[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeditationDetailPage(
                    meditation: Meditation(
                      title: item['title'] as String,
                      shortDescription: item['description'] as String,
                      detailedDescription: _getDetailedDescription(item['title'] as String),
                      duration: item['duration'] as String,
                      heroImageType: item['type'] as String,
                      heroGradient: item['gradient'] as List<Color>,
                      relatedMeditations: [],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: AppColors.dustyRose,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dustyRose.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            child: Stack(
              children: [
                // Abstract background circle
                Positioned(
                  right: -15,
                  bottom: -15,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.softGold.withOpacity(0.15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkPlum,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['duration'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.lighterPlum,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.softGold.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: AppColors.darkPlum,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          );
        },
      ),
    );
  }

  String _getDetailedDescription(String title) {
    switch (title) {
      case 'Derin Uyku':
        return 'Bu özel uyku meditasyonu, zihninizi sakinleştirerek derin ve dinlendirici bir uykuya dalmanıza yardımcı olur. Yumuşak rehberlik ve rahatlatıcı nefes teknikleriyle vücudunuzun tamamen gevşemesini sağlar.';
      case 'Stres Azaltma':
        return 'Günlük stres ve endişelerinizi azaltmak için tasarlanmış bu meditasyon, zihinsel ve fiziksel gerilimi serbest bırakmanıza yardımcı olur. Düzenli pratik ile daha sakin ve dengeli hissedeceksiniz.';
      case 'Odaklanma':
        return 'Dikkat dağınıklığını azaltın ve zihinsel netliğinizi artırın. Bu meditasyon, konsantrasyon gücünüzü geliştirerek günlük görevlerinizde daha verimli olmanızı sağlar.';
      default:
        return 'Bu meditasyon size huzur ve denge kazandıracak.';
    }
  }
}

// Featured Meditations Carousel
class FeaturedMeditations extends StatelessWidget {
  const FeaturedMeditations({super.key});

  @override
  Widget build(BuildContext context) {
    final meditations = [
      {
        'title': 'Sabah Uyanışı',
        'duration': '10 dk',
        'description': 'Günü huzurla başla',
        'gradient': [const Color(0xFFFFD6BA), const Color(0xFFFADCD9)], // Warm sunrise
      },
      {
        'title': 'Derin Uyku',
        'duration': '15 dk',
        'description': 'Rahat bir uyku için',
        'gradient': [const Color(0xFFFADCD9), const Color(0xFFF4C2C2)], // Soft rose
      },
      {
        'title': 'Stres Azaltma',
        'duration': '12 dk',
        'description': 'Sakinliğini bul',
        'gradient': [const Color(0xFFFFE5B4), const Color(0xFFFFD6BA)], // Peachy glow
      },
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: meditations.length,
        itemBuilder: (context, index) {
          final meditation = meditations[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: meditation['gradient'] as List<Color>,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (meditation['gradient'] as List<Color>)[0].withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meditation['title'] as String,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4A2C4B), // Dark Plum
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            meditation['description'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B4C6D), // Lighter Plum
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A2C4B).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              meditation['duration'] as String,
                              style: const TextStyle(
                                color: Color(0xFF4A2C4B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4AF37).withOpacity(0.5), // Gold
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Color(0xFF4A2C4B),
                              size: 28,
                            ),
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
}

// Categories Grid (with CategoriesGrid alias)
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Nefes\nÇalışmaları', 'icon': Icons.air},
      {'name': 'Uyku\nMeditasyonları', 'icon': Icons.nightlight_round},
      {'name': 'Stres\nYönetimi', 'icon': Icons.spa},
      {'name': 'Odaklanma', 'icon': Icons.center_focus_strong},
      {'name': 'Şükran', 'icon': Icons.favorite_border},
      {'name': 'Enerji', 'icon': Icons.flash_on},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.lightPeach.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.dustyRose,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category['icon'] as IconData,
                size: 32,
                color: AppColors.softGold,
              ),
              const SizedBox(height: 8),
              Text(
                category['name'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.darkPlum,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Alias for CategoriesGrid
class CategoriesGrid extends CategoryGrid {
  const CategoriesGrid({super.key});
}

// Recommended Meditations
class RecommendedMeditations extends StatelessWidget {
  const RecommendedMeditations({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendations = [
      {'title': 'Öğle Arası Dinlenme', 'duration': '5 dk', 'icon': Icons.wb_sunny},
      {'title': 'Akşam Rahatlama', 'duration': '8 dk', 'icon': Icons.nights_stay},
      {'title': 'Farkındalık Nefesi', 'duration': '7 dk', 'icon': Icons.self_improvement},
    ];

    return Column(
      children: recommendations.map((meditation) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF5E6).withOpacity(0.6), // Light Peach
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFADCD9), // Dusty Rose
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFD6BA), // Warm peach
                      Color(0xFFFADCD9), // Dusty Rose
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  meditation['icon'] as IconData,
                  color: const Color(0xFF4A2C4B), // Dark Plum
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meditation['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4A2C4B), // Dark Plum
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meditation['duration'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B4C6D), // Lighter Plum
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.play_circle_outline,
                color: Color(0xFFD4AF37), // Gold
                size: 32,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
