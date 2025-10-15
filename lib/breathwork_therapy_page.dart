import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';
import 'main.dart' show AppColors;

// Breathwork Therapy Listing Page
class BreathworkTherapyListPage extends StatelessWidget {
  const BreathworkTherapyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final therapies = [
      {
        'title': 'Sakinleştirici Kutu Nefesi',
        'goal': 'Zihinsel denge ve sükunet için',
        'duration': '5 Dakika',
        'icon': Icons.crop_square_rounded,
        'pattern': BreathPattern(
          inhale: 4,
          hold1: 4,
          exhale: 4,
          hold2: 4,
          cycles: 5,
        ),
        'type': 'calming',
      },
      {
        'title': 'Odak Artıran Ritim',
        'goal': 'Anlık berraklık ve konsantrasyon',
        'duration': '5 Dakika',
        'icon': Icons.show_chart,
        'pattern': BreathPattern(
          inhale: 4,
          hold1: 2,
          exhale: 6,
          hold2: 2,
          cycles: 6,
        ),
        'type': 'focus',
      },
      {
        'title': 'Uyku Öncesi Gevşeme',
        'goal': 'Huzurlu bir uykuya geçiş',
        'duration': '5 Dakika',
        'icon': Icons.nightlight_round,
        'pattern': BreathPattern(
          inhale: 4,
          hold1: 7,
          exhale: 8,
          hold2: 0,
          cycles: 4,
        ),
        'type': 'sleep',
      },
      {
        'title': 'Enerji Nefesi',
        'goal': 'Canlılık ve motivasyon',
        'duration': '5 Dakika',
        'icon': Icons.flash_on,
        'pattern': BreathPattern(
          inhale: 2,
          hold1: 1,
          exhale: 2,
          hold2: 1,
          cycles: 10,
        ),
        'type': 'energy',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: therapies.length,
                itemBuilder: (context, index) {
                  return _buildTherapyCard(context, therapies[index]);
                },
              ),
            ),
          ],
        ),
      ),
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
          const Expanded(
            child: Text(
              'Nefes Terapileri',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.darkPlum,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildTherapyCard(BuildContext context, Map<String, dynamic> therapy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InteractiveBreathworkSession(
                  title: therapy['title'],
                  pattern: therapy['pattern'],
                  type: therapy['type'],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.dustyRose, AppColors.softGold],
                    ),
                  ),
                  child: Icon(
                    therapy['icon'],
                    size: 36,
                    color: AppColors.darkPlum.withOpacity(0.5),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        therapy['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkPlum,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        therapy['goal'],
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.darkPlum.withOpacity(0.7),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        therapy['duration'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.softGold,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.darkPlum.withOpacity(0.3),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Breath Pattern Model
class BreathPattern {
  final int inhale;
  final int hold1;
  final int exhale;
  final int hold2;
  final int cycles;

  BreathPattern({
    required this.inhale,
    required this.hold1,
    required this.exhale,
    required this.hold2,
    required this.cycles,
  });

  int get totalCycleDuration => inhale + hold1 + exhale + hold2;
  int get totalSessionDuration => totalCycleDuration * cycles;
}

// Interactive Breathwork Session
class InteractiveBreathworkSession extends StatefulWidget {
  final String title;
  final BreathPattern pattern;
  final String type;

  const InteractiveBreathworkSession({
    super.key,
    required this.title,
    required this.pattern,
    required this.type,
  });

  @override
  State<InteractiveBreathworkSession> createState() =>
      _InteractiveBreathworkSessionState();
}

class _InteractiveBreathworkSessionState
    extends State<InteractiveBreathworkSession>
    with SingleTickerProviderStateMixin {
  late AnimationController _orbController;
  late Timer _sessionTimer;
  late Timer _phaseTimer;

  String currentPhase = 'Hazırlan...';
  int currentCycle = 0;
  int elapsedSeconds = 0;
  bool sessionStarted = false;
  bool sessionCompleted = false;

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Start session after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _startSession();
      }
    });
  }

  @override
  void dispose() {
    _orbController.dispose();
    if (sessionStarted) {
      _sessionTimer.cancel();
      _phaseTimer.cancel();
    }
    super.dispose();
  }

  void _startSession() {
    setState(() {
      sessionStarted = true;
      currentCycle = 1;
    });

    _startCycle();

    // Overall session timer
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });

      if (elapsedSeconds >= widget.pattern.totalSessionDuration) {
        _completeSession();
      }
    });
  }

  void _startCycle() {
    if (currentCycle > widget.pattern.cycles) {
      return;
    }

    // Inhale phase
    _startPhase('Nefes Al...', widget.pattern.inhale, 1.0);

    // Schedule hold1 phase
    Future.delayed(Duration(seconds: widget.pattern.inhale), () {
      if (mounted && sessionStarted) {
        _startPhase('Tut...', widget.pattern.hold1, 1.0);

        // Schedule exhale phase
        Future.delayed(Duration(seconds: widget.pattern.hold1), () {
          if (mounted && sessionStarted) {
            _startPhase('Yavaşça Ver...', widget.pattern.exhale, 0.0);

            // Schedule hold2 phase
            Future.delayed(Duration(seconds: widget.pattern.exhale), () {
              if (mounted && sessionStarted && widget.pattern.hold2 > 0) {
                _startPhase('Tut...', widget.pattern.hold2, 0.0);

                // Schedule next cycle
                Future.delayed(Duration(seconds: widget.pattern.hold2), () {
                  if (mounted && sessionStarted) {
                    setState(() {
                      currentCycle++;
                    });
                    _startCycle();
                  }
                });
              } else if (mounted && sessionStarted) {
                setState(() {
                  currentCycle++;
                });
                _startCycle();
              }
            });
          }
        });
      }
    });
  }

  void _startPhase(String phase, int duration, double targetValue) {
    if (!mounted) return;
    
    setState(() {
      currentPhase = phase;
    });

    _orbController.duration = Duration(seconds: duration);
    
    if (targetValue == 1.0) {
      _orbController.forward(from: 0.0);
    } else {
      _orbController.reverse(from: 1.0);
    }
  }

  void _completeSession() {
    _sessionTimer.cancel();
    setState(() {
      sessionCompleted = true;
      sessionStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sessionCompleted) {
      return _buildCompletionScreen();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.warmCream, AppColors.dustyRose],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Progress Ring
              Positioned.fill(
                child: CustomPaint(
                  painter: ProgressRingPainter(
                    progress: elapsedSeconds / widget.pattern.totalSessionDuration,
                  ),
                ),
              ),
              // Central Orb
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _orbController,
                      builder: (context, child) {
                        return CosmicOrb(
                          animation: _orbController,
                        );
                      },
                    ),
                    const SizedBox(height: 60),
                    Text(
                      currentPhase,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: AppColors.darkPlum,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              // Exit Button
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Bitir',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.darkPlum,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.warmCream, AppColors.dustyRose],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: AppColors.softGold,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Seans Tamamlandı',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: AppColors.darkPlum,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Zihnindeki berraklığın ve bedenindeki hafifliğin tadını çıkar.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkPlum.withOpacity(0.8),
                      height: 1.6,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.softGold,
                      foregroundColor: AppColors.darkPlum,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Ana Sayfaya Dön',
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
      ),
    );
  }
}

// Cosmic Orb Widget
class CosmicOrb extends StatelessWidget {
  final Animation<double> animation;

  const CosmicOrb({
    super.key,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final size = 150.0 + (animation.value * 100);
    final opacity = 0.3 + (animation.value * 0.7);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.softGold.withOpacity(opacity),
            AppColors.dustyRose.withOpacity(opacity * 0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.softGold.withOpacity(opacity * 0.5),
            blurRadius: 50 * animation.value,
            spreadRadius: 20 * animation.value,
          ),
        ],
      ),
    );
  }
}

// Progress Ring Painter
class ProgressRingPainter extends CustomPainter {
  final double progress;

  ProgressRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    final paint = Paint()
      ..color = AppColors.softGold.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
