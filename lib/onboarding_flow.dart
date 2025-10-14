import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'design_system.dart';
import 'main.dart' hide AppColors;

/// Interactive Onboarding Flow - Meditopia Style
/// Part 1: Personalized journey starts here

// Onboarding Flow Manager
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _currentStep = 0;
  List<String> _selectedGoals = [];

  final List<Widget> _steps = [];

  @override
  void initState() {
    super.initState();
    _steps.addAll([
      WelcomeScreen(onContinue: () => _nextStep()),
      GoalSelectionScreen(
        selectedGoals: _selectedGoals,
        onGoalsChanged: (goals) => setState(() => _selectedGoals = goals),
        onContinue: () => _nextStep(),
      ),
      AuthenticationScreen(
        selectedGoals: _selectedGoals,
        onComplete: () => _completeOnboarding(),
      ),
    ]);
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _completeOnboarding() {
    // Navigate to main app
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const KozmosHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: DesignSystem.durationStandard,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.3, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _steps[_currentStep],
      ),
    );
  }
}

/// Screen 1: The Welcome - Animated Kozmos Orb
class WelcomeScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const WelcomeScreen({super.key, required this.onContinue});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Premium gradient background
        AnimatedGradientBackground(
          colors: [
            AppColors.lightPeach,
            AppColors.warmCream,
            AppColors.dustyRose,
          ],
          duration: const Duration(seconds: 5),
        ),

        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Animated Kozmos Orb
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (_controller.value * 0.1),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.softGold,
                            AppColors.softGold.withOpacity(0.6),
                            AppColors.dustyRose.withOpacity(0.3),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.softGold.withOpacity(0.4),
                            blurRadius: 40 + (_controller.value * 20),
                            spreadRadius: 10 + (_controller.value * 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.self_improvement,
                          size: 80,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 60),

              // Headline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Kozmos\'a Hoş Geldin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.5,
                    color: AppColors.darkPlum,
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Subtext
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Kişisel zihin sağlığı rehberin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkPlum.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const Spacer(flex: 3),

              // CTA Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: AnimatedButton(
                  onPressed: widget.onContinue,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.softGold,
                          AppColors.softGold.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: DesignSystem.getShadow(3),
                    ),
                    child: const Text(
                      'Yolculuğuna Başla',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkPlum,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }
}

/// Screen 2: Goal Selection - Personalization
class GoalSelectionScreen extends StatelessWidget {
  final List<String> selectedGoals;
  final ValueChanged<List<String>> onGoalsChanged;
  final VoidCallback onContinue;

  const GoalSelectionScreen({
    super.key,
    required this.selectedGoals,
    required this.onGoalsChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final goals = [
      {
        'id': 'stress',
        'title': 'Stresi Azaltmak',
        'icon': Icons.spa,
        'gradient': [const Color(0xFFB8A5D4), const Color(0xFF9C88C2)],
      },
      {
        'id': 'sleep',
        'title': 'Daha İyi Uyumak',
        'icon': Icons.nightlight_round,
        'gradient': [const Color(0xFFFADCD9), const Color(0xFFF4C2C2)],
      },
      {
        'id': 'focus',
        'title': 'Odaklanmayı Artırmak',
        'icon': Icons.center_focus_strong,
        'gradient': [const Color(0xFFFFD6BA), const Color(0xFFFADCD9)],
      },
      {
        'id': 'explore',
        'title': 'Sadece Merak Ediyorum',
        'icon': Icons.explore,
        'gradient': [const Color(0xFFFFE5B4), const Color(0xFFFFD6BA)],
      },
    ];

    return Stack(
      children: [
        AnimatedGradientBackground(
          colors: [
            AppColors.warmCream,
            AppColors.lightPeach,
          ],
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.softGold,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.softGold.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.softGold.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // Headline
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Sana nasıl yardımcı olabiliriz?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkPlum,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Bir veya birden fazla seçenek seçebilirsin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.darkPlum.withOpacity(0.6),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Goal cards
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    final isSelected = selectedGoals.contains(goal['id']);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AnimatedButton(
                        onPressed: () {
                          final newGoals = List<String>.from(selectedGoals);
                          if (isSelected) {
                            newGoals.remove(goal['id']);
                          } else {
                            newGoals.add(goal['id'] as String);
                          }
                          onGoalsChanged(newGoals);
                        },
                        child: AnimatedContainer(
                          duration: DesignSystem.durationQuick,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: goal['gradient'] as List<Color>,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.softGold
                                  : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: isSelected
                                ? DesignSystem.getShadow(5)
                                : DesignSystem.getShadow(2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  goal['icon'] as IconData,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  goal['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: AppColors.softGold,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColors.darkPlum,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                child: AnimatedButton(
                  onPressed: selectedGoals.isEmpty ? null : onContinue,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: selectedGoals.isEmpty
                          ? AppColors.dustyRose.withOpacity(0.3)
                          : AppColors.softGold,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: selectedGoals.isEmpty
                          ? []
                          : DesignSystem.getShadow(3),
                    ),
                    child: Text(
                      'Devam Et',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: selectedGoals.isEmpty
                            ? AppColors.darkPlum.withOpacity(0.4)
                            : AppColors.darkPlum,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Screen 3: Authentication - Modern & Secure
class AuthenticationScreen extends StatelessWidget {
  final List<String> selectedGoals;
  final VoidCallback onComplete;

  const AuthenticationScreen({
    super.key,
    required this.selectedGoals,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedGradientBackground(
          colors: [
            AppColors.warmCream,
            AppColors.dustyRose,
          ],
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.softGold,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.softGold,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.softGold.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.softGold,
                      AppColors.softGold.withOpacity(0.6),
                    ],
                  ),
                  boxShadow: DesignSystem.getShadow(4),
                ),
                child: const Icon(
                  Icons.self_improvement,
                  size: 50,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              // Headline
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Hesabını oluştur ve\nyolculuğuna başla',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkPlum,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Social sign-in buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // Apple Sign In
                    AnimatedButton(
                      onPressed: onComplete,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.darkPlum,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: DesignSystem.getShadow(3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.apple,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Apple ile Devam Et',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Google Sign In
                    AnimatedButton(
                      onPressed: onComplete,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: DesignSystem.getShadow(3),
                          border: Border.all(
                            color: AppColors.darkPlum.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google icon placeholder
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.softGold.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  'G',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkPlum,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Google ile Devam Et',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkPlum,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Email option
                    TextButton(
                      onPressed: onComplete,
                      child: Text(
                        'Veya e-posta ile devam et',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.darkPlum.withOpacity(0.6),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Legal text
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 40),
                child: Text(
                  'Devam ederek Kullanım Koşulları\'nı ve Gizlilik Politikası\'nı kabul etmiş olursun.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkPlum.withOpacity(0.5),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
