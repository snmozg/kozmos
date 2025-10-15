import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'main.dart' show AppColors;

// Meditation Model
class Meditation {
  final String title;
  final String shortDescription;
  final String detailedDescription;
  final String duration;
  final String heroImageType;
  final List<Color> heroGradient;
  final List<Meditation> relatedMeditations;

  Meditation({
    required this.title,
    required this.shortDescription,
    required this.detailedDescription,
    required this.duration,
    required this.heroImageType,
    required this.heroGradient,
    this.relatedMeditations = const [],
  });
}

// Main Meditation Detail Page - Acts as Player
class MeditationDetailPage extends StatefulWidget {
  final Meditation meditation;

  const MeditationDetailPage({
    super.key,
    required this.meditation,
  });

  @override
  State<MeditationDetailPage> createState() => _MeditationDetailPageState();
}

class _MeditationDetailPageState extends State<MeditationDetailPage>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  double progress = 0.0;
  double volume = 0.7;
  bool isFavorite = false;
  bool showDetails = false;
  bool contentSoundEnabled = true;
  String? selectedBackgroundSound;
  bool hasShownWelcome = false;

  late AnimationController _backgroundController;
  late AnimationController _breathController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Show welcome dialog after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!hasShownWelcome) {
        _showWelcomeDialog();
        hasShownWelcome = true;
      }
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _breathController.dispose();
    super.dispose();
  }

  void _skipBackward() {
    setState(() {
      progress = (progress - 0.1).clamp(0.0, 1.0);
    });
  }

  void _skipForward() {
    setState(() {
      progress = (progress + 0.1).clamp(0.0, 1.0);
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.meditation.heroGradient,
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkPlum.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getWelcomeIcon(),
                        size: 50,
                        color: AppColors.darkPlum,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.meditation.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkPlum,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.meditation.detailedDescription,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.darkPlum,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.softGold,
                        foregroundColor: AppColors.darkPlum,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Hadi Başlayalım',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getWelcomeIcon() {
    switch (widget.meditation.heroImageType) {
      case 'sleep':
        return Icons.nightlight_round;
      case 'stress':
        return Icons.self_improvement;
      case 'focus':
        return Icons.center_focus_strong;
      case 'breathwork':
        return Icons.air;
      default:
        return Icons.spa;
    }
  }

  List<String> _getBackgroundSounds() {
    switch (widget.meditation.heroImageType) {
      case 'sleep':
        return [
          '🌧️ Yağmur Sesi',
          '🌊 Okyanus Dalgaları',
          '🔥 Şömine Sesi',
          '🌲 Orman Sesleri',
          '⭐ Gece Kriketleri',
        ];
      case 'stress':
        return [
          '🎋 Bambu Ormanı',
          '💧 Su Damlası',
          '🕊️ Kuş Sesleri',
          '🎐 Rüzgar Çanları',
          '🏞️ Dere Sesi',
        ];
      case 'focus':
        return [
          '☕ Kahve Dükkanı',
          '📚 Kütüphane Sessizliği',
          '🎵 Beyaz Gürültü',
          '⚡ Binaural Beats',
          '🌬️ Hafif Rüzgar',
        ];
      case 'breathwork':
        return [
          '🌬️ Derin Nefes',
          '🧘 Om Mantrası',
          '🎶 Tibetan Bowl',
          '🔔 Meditasyon Zili',
          '🌊 Okyanus Nefesi',
        ];
      default:
        return [
          '🎵 Rahatlatıcı Müzik',
          '🌿 Doğa Sesleri',
          '💫 Ambient Ses',
          '🎼 Piyano Müziği',
          '🌙 Gece Sesleri',
        ];
    }
  }

  void _showBackgroundSoundsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.warmCream.withOpacity(0.95),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: AppColors.softGold.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkPlum.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Arka Plan Sesleri',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkPlum,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: AppColors.darkPlum),
                          onPressed: () => Navigator.of(context).pop(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ..._getBackgroundSounds().map((sound) {
                      final isSelected = selectedBackgroundSound == sound;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedBackgroundSound = isSelected ? null : sound;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.softGold.withOpacity(0.2)
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.softGold
                                    : AppColors.darkPlum.withOpacity(0.1),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    sound,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: AppColors.darkPlum,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.softGold,
                                    size: 24,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildImmersiveBackground(),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const Spacer(),
                if (!showDetails) _buildCentralContent(),
                if (showDetails)
                  Expanded(
                    child: _buildDetailsSection(),
                  ),
                if (!showDetails) const Spacer(),
                if (!showDetails) _buildPlayerControls(),
                const SizedBox(height: 40),
                _buildBottomActionBar(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImmersiveBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: widget.meditation.heroGradient,
        ),
      ),
      child: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return CustomPaint(
            painter: _getBackgroundPainter(),
            size: Size.infinite,
          );
        },
      ),
    );
  }

  CustomPainter _getBackgroundPainter() {
    switch (widget.meditation.heroImageType) {
      case 'sleep':
        return SleepBackgroundPainter(_backgroundController.value);
      case 'stress':
        return StressBackgroundPainter(_backgroundController.value);
      case 'focus':
        return FocusBackgroundPainter(_breathController.value);
      case 'breathwork':
        return BreathworkBackgroundPainter(_breathController.value);
      default:
        return SleepBackgroundPainter(_backgroundController.value);
    }
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.darkPlum, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: Icon(
              showDetails ? Icons.music_note : Icons.info_outline,
              color: AppColors.darkPlum,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                showDetails = !showDetails;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCentralContent() {
    return Column(
      children: [
        Text(
          widget.meditation.title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w300,
            color: AppColors.darkPlum,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          widget.meditation.duration,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.lighterPlum,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Bu Meditasyon Hakkında',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.darkPlum,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Text(
                  widget.meditation.detailedDescription,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.darkPlum,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPlayerControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10, size: 32),
          color: AppColors.darkPlum.withOpacity(0.6),
          onPressed: _skipBackward,
        ),
        const SizedBox(width: 40),
        GestureDetector(
          onTap: () {
            setState(() {
              isPlaying = !isPlaying;
            });
          },
          child: SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CustomPaint(
                    painter: CircularProgressPainter(
                      progress: progress,
                      color: AppColors.softGold,
                      backgroundColor: AppColors.darkPlum.withOpacity(0.15),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.softGold,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.softGold.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 48,
                    color: AppColors.darkPlum,
                  ),
                ),
                Positioned(
                  bottom: -30,
                  child: Text(
                    '${_formatTime(progress)} / ${widget.meditation.duration}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.darkPlum,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40),
        IconButton(
          icon: const Icon(Icons.forward_10, size: 32),
          color: AppColors.darkPlum.withOpacity(0.6),
          onPressed: _skipForward,
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: contentSoundEnabled
                    ? Icons.volume_up_outlined
                    : Icons.volume_off_outlined,
                label: 'İçerik Sesi',
                onTap: () {
                  setState(() {
                    contentSoundEnabled = !contentSoundEnabled;
                  });
                },
              ),
              _buildActionButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                label: 'Favori',
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
              _buildActionButton(
                icon: selectedBackgroundSound != null
                    ? Icons.music_note
                    : Icons.queue_music_outlined,
                label: 'Arka Plan',
                onTap: _showBackgroundSoundsDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.darkPlum, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.darkPlum,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTime(double progress) {
    final totalMinutes = int.parse(widget.meditation.duration.split(' ')[0]);
    final currentMinutes = (totalMinutes * progress).floor();
    final currentSeconds = ((totalMinutes * progress - currentMinutes) * 60).floor();
    return '${currentMinutes.toString().padLeft(2, '0')}:${currentSeconds.toString().padLeft(2, '0')}';
  }
}

// Circular Progress Painter
class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 4, backgroundPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 4),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// Background Painters
class SleepBackgroundPainter extends CustomPainter {
  final double animationValue;
  SleepBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random(42);

    for (int i = 0; i < 80; i++) {
      final x = (random.nextDouble() * size.width + animationValue * 20) % size.width;
      final y = (random.nextDouble() * size.height + animationValue * 10) % size.height;
      final opacity = (math.sin(animationValue * 2 * math.pi + i) + 1) / 2;
      paint.color = AppColors.softGold.withOpacity(opacity * 0.4);
      canvas.drawCircle(Offset(x, y), random.nextDouble() * 2 + 1, paint);
    }
  }

  @override
  bool shouldRepaint(SleepBackgroundPainter oldDelegate) => true;
}

class StressBackgroundPainter extends CustomPainter {
  final double animationValue;
  StressBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * math.pi;
      final distance = 150 + math.sin(animationValue * 2 * math.pi + i) * 50;
      final x = size.width / 2 + math.cos(angle) * distance;
      final y = size.height / 2 + math.sin(angle) * distance;
      final radius = 80 + math.sin(animationValue * math.pi + i) * 30;

      paint.color = AppColors.softGold.withOpacity(0.08 - i * 0.008);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(StressBackgroundPainter oldDelegate) => true;
}

class FocusBackgroundPainter extends CustomPainter {
  final double breathValue;
  FocusBackgroundPainter(this.breathValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 5; i++) {
      final scale = 0.5 + breathValue * 0.5;
      final radius = (80 + i * 60) * scale;
      paint.color = AppColors.softGold.withOpacity(0.15 - i * 0.025);
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(FocusBackgroundPainter oldDelegate) => true;
}

class BreathworkBackgroundPainter extends CustomPainter {
  final double breathValue;
  BreathworkBackgroundPainter(this.breathValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.softGold.withOpacity(0.1);

    final waveHeight = size.height * breathValue;
    final rect = Rect.fromLTWH(0, size.height - waveHeight, size.width, waveHeight);

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.softGold.withOpacity(0),
        AppColors.softGold.withOpacity(0.15),
      ],
    );

    paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(BreathworkBackgroundPainter oldDelegate) => true;
}
