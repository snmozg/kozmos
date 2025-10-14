import 'package:flutter/material.dart';
import 'design_system.dart';
import 'email_login_page.dart';
import 'services/auth_service.dart';
import 'main.dart'; // For HomePage navigation

/// Main Authentication Gate - Entry screen for new and returning users
/// Prioritizes social login (Apple, Google) with email option
class AuthenticationGate extends StatefulWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  State<AuthenticationGate> createState() => _AuthenticationGateState();
}

class _AuthenticationGateState extends State<AuthenticationGate>
    with SingleTickerProviderStateMixin {
  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Auth service instance
  final _authService = AuthService();

  // UI state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    // Logo & Welcome Message
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          // Kozmos Logo
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.dustyRose,
                                  AppColors.lightPeach,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.dustyRose.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.spa_rounded,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // App Name
                          const Text(
                            'Kozmos',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkPlum,
                              letterSpacing: 1.2,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Welcome Message
                          Text(
                            'Kişisel sığınağına hoş geldin',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lighterPlum.withOpacity(0.8),
                              letterSpacing: 0.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Social Login Buttons
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            // Apple Sign-In Button
                            _buildSocialLoginButton(
                              icon: Icons.apple,
                              label: 'Apple ile Devam Et',
                              backgroundColor: AppColors.darkPlum,
                              textColor: Colors.white,
                              onPressed: _handleAppleSignIn,
                            ),

                            const SizedBox(height: 16),

                            // Google Sign-In Button
                            _buildSocialLoginButton(
                              icon: Icons.g_mobiledata_rounded,
                              label: 'Google ile Devam Et',
                              backgroundColor: Colors.white,
                              textColor: AppColors.darkPlum,
                              onPressed: _handleGoogleSignIn,
                            ),

                            const SizedBox(height: 40),

                            // Divider with "or"
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColors.lighterPlum.withOpacity(0.2),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'veya',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lighterPlum.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColors.lighterPlum.withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            // Email Sign-In Option
                            AnimatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SmoothPageRoute(
                                    page: const EmailLoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'E-posta ile devam et',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkPlum,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Terms & Privacy
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'Devam ederek Hizmet Şartları\'nı ve Gizlilik Politikası\'nı kabul etmiş olursunuz.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lighterPlum.withOpacity(0.6),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Loading Overlay
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: PulsingOrb(size: 80),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: backgroundColor == Colors.white
                  ? AppColors.darkPlum.withOpacity(0.08)
                  : AppColors.darkPlum.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: textColor,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sign in with Apple
  Future<void> _handleAppleSignIn() async {
    setState(() => _isLoading = true);

    try {
      // Call Firebase Auth Service
      final user = await _authService.signInWithApple();
      
      if (mounted) {
        if (user != null) {
          // Sign-in successful - navigate to home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          // User canceled sign-in
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorSnackBar('Apple ile giriş başarısız: ${e.toString()}');
      }
    }
  }

  /// Sign in with Google
  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      // Call Firebase Auth Service
      final user = await _authService.signInWithGoogle();
      
      if (mounted) {
        if (user != null) {
          // Sign-in successful - navigate to home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          // User canceled sign-in
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorSnackBar('Google ile giriş başarısız: ${e.toString()}');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFE57373),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

class AppColors {
  static const Color warmCream = Color(0xFFFFFDD0);
  static const Color dustyRose = Color(0xFFFADCD9);
  static const Color darkPlum = Color(0xFF4A2C4B);
  static const Color softGold = Color(0xFFD4AF37);
  static const Color lightPeach = Color(0xFFFFF5E6);
  static const Color lighterPlum = Color(0xFF6B4C6D);
}
