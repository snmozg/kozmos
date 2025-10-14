import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'program_detail_page.dart';
import 'design_system.dart';
import 'explore_page.dart';

// App Colors
class AppColors {
  static const warmCream = Color(0xFFFFFDD0);
  static const dustyRose = Color(0xFFFADCD9);
  static const darkPlum = Color(0xFF4A2C4B);
  static const softGold = Color(0xFFD4AF37);
  static const lightPeach = Color(0xFFFFF5E6);
  static const lighterPlum = Color(0xFF6B4C6D);
}

class ProgramsListingPage extends StatefulWidget {
  const ProgramsListingPage({super.key});

  @override
  State<ProgramsListingPage> createState() => _ProgramsListingPageState();
}

class _ProgramsListingPageState extends State<ProgramsListingPage> {
  // Sample program data
  List<Map<String, dynamic>> _getPrograms() {
    return [
      {
        'id': 'stress_7days',
        'title': '7 Günlük Stres Yönetimi Programı',
        'tagline': 'Her gün 10 dakika ile zihinsel yüklerinizden arının',
        'description': 'Stres yönetimi konusunda temel becerileri öğrenin ve günlük yaşamınızda uygulayın. Bu 7 günlük yolculukta, nefes çalışmaları, farkındalık meditasyonları ve zihinsel rahatlama teknikleriyle tanışacaksınız.',
        'duration': '7 Gün',
        'totalSessions': 7,
        'sessionDuration': '10 Dakika',
        'imageType': 'stress',
        'gradient': [
          const Color(0xFFB8A5D4),
          const Color(0xFF9C88C2),
        ],
        'progress': 0.43, // 3 out of 7 completed
        'completedSessions': 3,
        'isStarted': true,
      },
      {
        'id': 'focus_10days',
        'title': '10 Günlük Odaklanma Programı',
        'tagline': 'Dikkatinizi güçlendirin, verimliliğinizi artırın',
        'description': 'Modern hayatın dikkat dağıtıcı unsurlarına karşı zihinsel direncınızı artırın. Bu program boyunca, konsantrasyonu geliştiren teknikler ve derin odaklanma meditasyonları pratiği yapacaksınız.',
        'duration': '10 Gün',
        'totalSessions': 10,
        'sessionDuration': '12 Dakika',
        'imageType': 'focus',
        'gradient': [
          const Color(0xFF87CEEB),
          const Color(0xFF5F9FD9),
        ],
        'progress': 0.0,
        'completedSessions': 0,
        'isStarted': false,
      },
      {
        'id': 'sleep_14days',
        'title': '14 Günlük Uyku İyileştirme Programı',
        'tagline': 'Kaliteli uykuya giden yolculuğunuz başlıyor',
        'description': 'Uyku kalitenizi iyileştirmek için tasarlanmış kapsamlı bir program. Uyku öncesi rahatlama rutinleri, meditasyonlar ve sağlıklı uyku alışkanlıkları geliştirmeye yönelik pratik teknikler içerir.',
        'duration': '14 Gün',
        'totalSessions': 14,
        'sessionDuration': '15 Dakika',
        'imageType': 'sleep',
        'gradient': [
          const Color(0xFF6A5ACD),
          const Color(0xFF483D8B),
        ],
        'progress': 0.0,
        'completedSessions': 0,
        'isStarted': false,
      },
      {
        'id': 'gratitude_21days',
        'title': '21 Günlük Şükran Yolculuğu',
        'tagline': 'Yaşama yeni bir bakış açısı kazanın',
        'description': 'Şükran pratiği, zihinsel sağlığı ve mutluluğu artıran en güçlü araçlardan biridir. Bu 21 günlük programda, minnettarlık alışkanlığını hayatınıza entegre edecek ve olumlu düşünce kalıplarınızı güçlendireceksiniz.',
        'duration': '21 Gün',
        'totalSessions': 21,
        'sessionDuration': '8 Dakika',
        'imageType': 'gratitude',
        'gradient': [
          const Color(0xFFFFB6C1),
          const Color(0xFFFF8FAB),
        ],
        'progress': 1.0, // Completed
        'completedSessions': 21,
        'isStarted': true,
      },
      {
        'id': 'energy_7days',
        'title': '7 Günlük Enerji Artırma Programı',
        'tagline': 'Her gün enerjinizi yenileyin ve canlanın',
        'description': 'Yorgunluk ve tükenmişlik hissine son verin. Bu program, enerji seviyenizi artıracak meditasyonlar, nefes teknikleri ve zihinsel canlanma pratikleriyle doludur.',
        'duration': '7 Gün',
        'totalSessions': 7,
        'sessionDuration': '10 Dakika',
        'imageType': 'energy',
        'gradient': [
          const Color(0xFFFFA07A),
          const Color(0xFFFF7F50),
        ],
        'progress': 0.0,
        'completedSessions': 0,
        'isStarted': false,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final programs = _getPrograms();

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          // Elegant Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Programlar',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                      color: AppColors.darkPlum,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Adım Adım Yolculuklar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkPlum.withOpacity(0.6),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Program Cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final program = programs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _buildProgramCard(program),
                  );
                },
                childCount: programs.length,
              ),
            ),
          ),

          // Bottom Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(Map<String, dynamic> program) {
    final isCompleted = program['progress'] == 1.0;
    final isStarted = program['isStarted'] as bool;

    return AnimatedButton(
      onPressed: () {
        Navigator.push(
          context,
          SlideUpPageRoute(
            page: ProgramDetailPage(
              programData: program,
            ),
          ),
        );
      },
      child: Container(
        height: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPlum.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background Image/Gradient
              Positioned.fill(
                child: CustomPaint(
                  painter: ProgramBackgroundPainter(
                    imageType: program['imageType'],
                    gradient: program['gradient'],
                  ),
                ),
              ),

              // Glassmorphism Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Duration Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warmCream.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${program['duration']} • ${program['sessionDuration']}/gün',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkPlum,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        program['title'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkPlum,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Tagline
                      Text(
                        program['tagline'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkPlum.withOpacity(0.7),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action Button
                      if (isCompleted)
                        _buildCompletedButton()
                      else if (isStarted)
                        _buildContinueButton(program['progress'])
                      else
                        _buildStartButton(),
                    ],
                  ),
                ),
              ),

              // Completion Badge
              if (isCompleted)
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.softGold,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.softGold.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.softGold,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.softGold.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Başla',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(double progress) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.darkPlum,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Progress Background
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.softGold.withOpacity(0.3),
                          AppColors.softGold.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Text
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Devam Et',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.softGold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.softGold.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.softGold,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.replay,
            color: AppColors.darkPlum,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Tekrar Başla',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkPlum,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Program Card Backgrounds
class ProgramBackgroundPainter extends CustomPainter {
  final String imageType;
  final List<Color> gradient;

  ProgramBackgroundPainter({
    required this.imageType,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Base Gradient
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Add decorative patterns based on type
    switch (imageType) {
      case 'stress':
        _drawRipplePattern(canvas, size);
        break;
      case 'focus':
        _drawConcentricCircles(canvas, size);
        break;
      case 'sleep':
        _drawStarsPattern(canvas, size);
        break;
      case 'gratitude':
        _drawHeartPattern(canvas, size);
        break;
      case 'energy':
        _drawRaysPattern(canvas, size);
        break;
    }
  }

  void _drawRipplePattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.3),
        50.0 + (i * 30),
        paint,
      );
    }
  }

  void _drawConcentricCircles(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < 6; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.4),
        30.0 + (i * 20),
        paint,
      );
    }
  }

  void _drawStarsPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final positions = [
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.15),
      Offset(size.width * 0.7, size.height * 0.5),
      Offset(size.width * 0.3, size.height * 0.4),
    ];

    for (final pos in positions) {
      canvas.drawCircle(pos, 3, paint);
    }
  }

  void _drawHeartPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width * 0.8, size.height * 0.3);
    final scale = 0.5;

    path.moveTo(center.dx, center.dy + 15 * scale);
    path.cubicTo(
      center.dx - 15 * scale,
      center.dy - 5 * scale,
      center.dx - 25 * scale,
      center.dy - 15 * scale,
      center.dx,
      center.dy - 25 * scale,
    );
    path.cubicTo(
      center.dx + 25 * scale,
      center.dy - 15 * scale,
      center.dx + 15 * scale,
      center.dy - 5 * scale,
      center.dx,
      center.dy + 15 * scale,
    );

    canvas.drawPath(path, paint);
  }

  void _drawRaysPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width * 0.5, size.height * 0.2);
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * 3.14159 / 180;
      final endX = center.dx + 40 * Math.cos(angle);
      final endY = center.dy + 40 * Math.sin(angle);
      canvas.drawLine(center, Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Math helper
class Math {
  static double cos(double angle) => math.cos(angle);
  static double sin(double angle) => math.sin(angle);
}
