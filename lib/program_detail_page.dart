import 'package:flutter/material.dart';
import 'dart:ui';
import 'meditation_detail_page.dart';
import 'main.dart' show AppColors;

class ProgramDetailPage extends StatefulWidget {
  final Map<String, dynamic> programData;

  const ProgramDetailPage({
    super.key,
    required this.programData,
  });

  @override
  State<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  // Generate session data based on program
  List<Map<String, dynamic>> _generateSessions() {
    final totalSessions = widget.programData['totalSessions'] as int;
    final completedSessions = widget.programData['completedSessions'] as int;
    final programId = widget.programData['id'] as String;

    List<Map<String, dynamic>> sessions = [];

    // Define session titles based on program type
    final sessionTitles = _getSessionTitles(programId, totalSessions);

    for (int i = 0; i < totalSessions; i++) {
      final dayNumber = i + 1;
      final isCompleted = i < completedSessions;
      final isUnlocked = i <= completedSessions;

      sessions.add({
        'dayNumber': dayNumber,
        'title': sessionTitles[i],
        'duration': widget.programData['sessionDuration'],
        'isCompleted': isCompleted,
        'isUnlocked': isUnlocked,
        'description': _getSessionDescription(programId, dayNumber),
        'heroImageType': widget.programData['imageType'],
        'gradient': widget.programData['gradient'],
      });
    }

    return sessions;
  }

  List<String> _getSessionTitles(String programId, int totalSessions) {
    switch (programId) {
      case 'stress_7days':
        return [
          'Temeller ve İlk Nefes',
          'Bedensel Farkındalık',
          'Düşünceleri Gözlemlemek',
          'Rahatlamaya İzin Vermek',
          'Stresle Barış',
          'Güçlü Kalmak',
          'Yeni Bir Başlangıç',
        ];
      case 'focus_10days':
        return [
          'Dikkat Nedir?',
          'Tek Noktaya Odaklanma',
          'Dikkati Güçlendirmek',
          'Zihinsel Netlik',
          'Derinleşen Konsantrasyon',
          'Sakin ve Odaklı',
          'Akış Halinde Olmak',
          'Sürdürülebilir Odak',
          'Gelişmiş Farkındalık',
          'Ustalaşmak',
        ];
      case 'sleep_14days':
        return [
          'Uyku ve Dinlenme',
          'Gevşeme Temelleri',
          'Bedeni Rahatlatmak',
          'Zihinsel Sakinlik',
          'Gece Rutini Oluşturmak',
          'Derin Gevşeme',
          'Uykuya Hazırlanmak',
          'Düşünceleri Bırakmak',
          'Huzurlu Bir Gece',
          'Kaliteli Uyku',
          'Sabah Enerjisi',
          'Uyku Döngüsü',
          'Uyum ve Denge',
          'Mükemmel Bir Gece',
        ];
      case 'gratitude_21days':
        return List.generate(
          totalSessions,
          (i) => 'Şükran Günü ${i + 1}',
        );
      case 'energy_7days':
        return [
          'Enerji Farkındalığı',
          'Sabah Canlanması',
          'Zihinsel Tazelenme',
          'İç Gücü Bulmak',
          'Dinamik Nefes',
          'Sürekli Canlılık',
          'Yenilenmiş Enerji',
        ];
      default:
        return List.generate(
          totalSessions,
          (i) => 'Gün ${i + 1}',
        );
    }
  }

  String _getSessionDescription(String programId, int dayNumber) {
    // Generate contextual descriptions for each session
    switch (programId) {
      case 'stress_7days':
        final descriptions = [
          'Stres yönetiminin temel prensiplerini öğrenin ve nefes farkındalığına giriş yapın.',
          'Bedeninizde stresi nasıl taşıdığınızı keşfedin ve bu gerginlikleri serbest bırakmayı öğrenin.',
          'Düşüncelerinizi yargılamadan gözlemlemeyi ve onlara mesafe koymayı deneyin.',
          'Kontrolü bırakma ve gevşemeye izin verme pratiği yapın.',
          'Stresle savaşmak yerine onunla barış içinde yaşamayı öğrenin.',
          'Zorluklar karşısında içsel gücünüzü ve direncınızı keşfedin.',
          'Öğrendiklerinizi entegre edin ve yeni bir bakış açısıyla ilerleyin.',
        ];
        return descriptions[dayNumber - 1];
      case 'focus_10days':
        final descriptions = [
          'Dikkat ve konsantrasyonun doğasını anlamaya başlayın.',
          'Zihinsel odağınızı tek bir noktada toplamayı pratik edin.',
          'Dikkatinizi güçlendiren egzersizler yapın.',
          'Zihinsel netliği artırmak için meditasyon teknikleri öğrenin.',
          'Daha derin seviyede konsantre olma yeteneğinizi geliştirin.',
          'Sakinlik ve odak arasındaki dengeyi bulun.',
          'Akış durumuna girmeyi deneyimleyin.',
          'Uzun süreli odaklanma kapasitesini geliştirin.',
          'Gelişmiş farkındalık ve konsantrasyon birlikte çalışsın.',
          'Öğrendiğiniz tüm tekniklerde ustalaşın.',
        ];
        return descriptions[dayNumber - 1];
      default:
        return 'Bugünün meditasyonu sizi bir adım daha ileriye taşıyacak.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessions = _generateSessions();
    final progress = widget.programData['progress'] as double;
    final completedCount = widget.programData['completedSessions'] as int;
    final totalCount = widget.programData['totalSessions'] as int;

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: AppColors.warmCream,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.warmCream.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkPlum.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.darkPlum),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Hero Image/Gradient
                  Positioned.fill(
                    child: CustomPaint(
                      painter: ProgramHeroPainter(
                        imageType: widget.programData['imageType'],
                        gradient: widget.programData['gradient'],
                      ),
                    ),
                  ),

                  // Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.warmCream.withOpacity(0.7),
                            AppColors.warmCream,
                          ],
                          stops: const [0.3, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Content
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softGold,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$completedCount / $totalCount Tamamlandı',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          widget.programData['title'],
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkPlum,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Description Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.programData['description'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkPlum.withOpacity(0.7),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'İlerleme',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkPlum,
                            ),
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.softGold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 8,
                          color: AppColors.darkPlum.withOpacity(0.1),
                          child: FractionallySizedBox(
                            widthFactor: progress,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.softGold,
                                    AppColors.softGold.withOpacity(0.8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Sessions Header
                  Text(
                    'Seanslar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkPlum,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Session List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final session = sessions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildSessionCard(session),
                  );
                },
                childCount: sessions.length,
              ),
            ),
          ),

          // Bottom Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
    final isCompleted = session['isCompleted'] as bool;
    final isUnlocked = session['isUnlocked'] as bool;
    final dayNumber = session['dayNumber'] as int;

    return GestureDetector(
      onTap: isUnlocked
          ? () {
              // Navigate to meditation detail page
              List<Color> gradientColors;
              if (session['gradient'] != null) {
                gradientColors = (session['gradient'] as List).cast<Color>();
              } else {
                gradientColors = [
                  AppColors.dustyRose,
                  AppColors.lighterPlum,
                ];
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeditationDetailPage(
                    meditation: Meditation(
                      title: '${widget.programData['title']} - Gün $dayNumber',
                      shortDescription: session['title'],
                      detailedDescription: session['description'],
                      duration: session['duration'],
                      heroImageType: session['heroImageType'],
                      heroGradient: gradientColors,
                      relatedMeditations: [],
                    ),
                  ),
                ),
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isUnlocked
              ? Colors.white
              : AppColors.darkPlum.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
                ? AppColors.softGold.withOpacity(0.3)
                : AppColors.darkPlum.withOpacity(0.05),
            width: isCompleted ? 2 : 1,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: AppColors.darkPlum.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Status Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.softGold
                    : isUnlocked
                        ? AppColors.darkPlum.withOpacity(0.1)
                        : AppColors.darkPlum.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isCompleted
                    ? Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 24,
                      )
                    : isUnlocked
                        ? Icon(
                            Icons.play_arrow_rounded,
                            color: AppColors.darkPlum,
                            size: 28,
                          )
                        : Icon(
                            Icons.lock_outline,
                            color: AppColors.darkPlum.withOpacity(0.3),
                            size: 20,
                          ),
              ),
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day Number
                  Text(
                    'Gün $dayNumber',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isCompleted
                          ? AppColors.softGold
                          : AppColors.darkPlum.withOpacity(0.5),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Title
                  Text(
                    session['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isUnlocked
                          ? AppColors.darkPlum
                          : AppColors.darkPlum.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Duration
                  Text(
                    session['duration'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkPlum.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            if (isUnlocked)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.darkPlum.withOpacity(0.3),
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Hero Section
class ProgramHeroPainter extends CustomPainter {
  final String imageType;
  final List<Color> gradient;

  ProgramHeroPainter({
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

    // Add large decorative element
    final decorPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    switch (imageType) {
      case 'stress':
        // Large calm circle
        canvas.drawCircle(
          Offset(size.width * 0.7, size.height * 0.3),
          120,
          decorPaint,
        );
        break;
      case 'focus':
        // Target circles
        for (int i = 0; i < 3; i++) {
          final strokePaint = Paint()
            ..color = Colors.white.withOpacity(0.1)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3;
          canvas.drawCircle(
            Offset(size.width * 0.5, size.height * 0.4),
            60.0 + (i * 40),
            strokePaint,
          );
        }
        break;
      case 'sleep':
        // Moon
        canvas.drawCircle(
          Offset(size.width * 0.3, size.height * 0.25),
          80,
          decorPaint,
        );
        break;
      case 'gratitude':
        // Heart shape
        final path = Path();
        final center = Offset(size.width * 0.7, size.height * 0.3);
        final scale = 2.0;

        path.moveTo(center.dx, center.dy + 30 * scale);
        path.cubicTo(
          center.dx - 30 * scale,
          center.dy - 10 * scale,
          center.dx - 50 * scale,
          center.dy - 30 * scale,
          center.dx,
          center.dy - 50 * scale,
        );
        path.cubicTo(
          center.dx + 50 * scale,
          center.dy - 30 * scale,
          center.dx + 30 * scale,
          center.dy - 10 * scale,
          center.dx,
          center.dy + 30 * scale,
        );

        canvas.drawPath(path, decorPaint);
        break;
      case 'energy':
        // Sun rays
        final center = Offset(size.width * 0.5, size.height * 0.3);
        canvas.drawCircle(center, 60, decorPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
