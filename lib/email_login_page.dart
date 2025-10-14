import 'package:flutter/material.dart';
import 'design_system.dart';
import 'email_signup_page.dart';
import 'forgot_password_page.dart';
import 'services/auth_service.dart';
import 'main.dart'; // For HomePage navigation

/// Email Login Page - For existing users to log in
class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Auth service instance
  final _authService = AuthService();

  // UI states
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Form validation states
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            Column(
              children: [
                // Custom App Bar
                _buildAppBar(),

                // Scrollable Form
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // Title
                          const Text(
                            'Tekrar Hoş Geldin',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkPlum,
                              letterSpacing: 0.5,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Yolculuğuna kaldığın yerden devam et',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lighterPlum.withOpacity(0.7),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Email Field
                          _buildInputField(
                            label: 'E-posta Adresi',
                            controller: _emailController,
                            errorText: _emailError,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_rounded,
                            onChanged: (value) {
                              if (_emailError != null) {
                                setState(() => _emailError = null);
                              }
                            },
                          ),

                          const SizedBox(height: 20),

                          // Password Field
                          _buildInputField(
                            label: 'Şifre',
                            controller: _passwordController,
                            errorText: _passwordError,
                            obscureText: !_isPasswordVisible,
                            prefixIcon: Icons.lock_rounded,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                color: AppColors.lighterPlum.withOpacity(0.6),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            onChanged: (value) {
                              if (_passwordError != null) {
                                setState(() => _passwordError = null);
                              }
                            },
                          ),

                          const SizedBox(height: 12),

                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SlideUpPageRoute(
                                    page: const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Şifremi Unuttum',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkPlum.withOpacity(0.8),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Login Button
                          AnimatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
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
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.softGold.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'Giriş Yap',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Sign Up Link
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hesabın yok mu? ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lighterPlum.withOpacity(0.7),
                                  ),
                                ),
                                AnimatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      SmoothPageRoute(
                                        page: const EmailSignupPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Kayıt Ol',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkPlum,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Loading Overlay
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.2),
                child: const Center(
                  child: PulsingOrb(size: 80),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          AnimatedButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkPlum.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.darkPlum,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? errorText,
    bool obscureText = false,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    Widget? suffixIcon,
    Function(String)? onChanged,
  }) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.darkPlum,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.dustyRose.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasError
                  ? const Color(0xFFE57373)
                  : controller.text.isNotEmpty
                      ? AppColors.softGold
                      : Colors.transparent,
              width: 2,
            ),
            boxShadow: controller.text.isNotEmpty
                ? [
                    BoxShadow(
                      color: AppColors.softGold.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.darkPlum,
            ),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(
                color: AppColors.lighterPlum.withOpacity(0.4),
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: hasError
                          ? const Color(0xFFE57373)
                          : controller.text.isNotEmpty
                              ? AppColors.softGold
                              : AppColors.lighterPlum.withOpacity(0.4),
                    )
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 16,
                color: Color(0xFFE57373),
              ),
              const SizedBox(width: 6),
              Text(
                errorText,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFE57373),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Log in user with email and password
  Future<void> _handleLogin() async {
    // Clear previous errors
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Validate inputs
    bool hasError = false;

    if (_emailController.text.trim().isEmpty) {
      setState(() => _emailError = 'E-posta adresi gerekli');
      hasError = true;
    } else if (!_isValidEmail(_emailController.text.trim())) {
      setState(() => _emailError = 'Geçersiz e-posta formatı');
      hasError = true;
    }

    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = 'Şifre gerekli');
      hasError = true;
    }

    if (hasError) return;

    // Start loading
    setState(() => _isLoading = true);

    try {
      // Call Firebase Auth Service
      final user = await _authService.signInWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        if (user != null) {
          // Login successful - navigate to home
          _showSuccessSnackBar('Giriş başarılı!');
          
          // Wait for snackbar then navigate
          await Future.delayed(const Duration(milliseconds: 500));
          
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        } else {
          // Should not happen, but handle just in case
          setState(() {
            _passwordError = 'Giriş yapılamadı. Lütfen tekrar deneyin.';
          });
        }
      }
    } catch (e) {
      // Handle Firebase errors
      if (mounted) {
        final errorMessage = e.toString();
        
        if (errorMessage.contains('user-not-found') ||
            errorMessage.contains('wrong-password') ||
            errorMessage.contains('yanlış')) {
          setState(() {
            _passwordError = 'E-posta veya şifre yanlış';
          });
        } else if (errorMessage.contains('invalid-email') ||
            errorMessage.contains('Geçersiz')) {
          setState(() {
            _emailError = 'Geçersiz e-posta adresi';
          });
        } else if (errorMessage.contains('user-disabled')) {
          setState(() {
            _passwordError = 'Bu hesap devre dışı bırakılmış';
          });
        } else if (errorMessage.contains('too-many-requests')) {
          _showErrorSnackBar(
              'Çok fazla başarısız deneme. Lütfen daha sonra tekrar deneyin.');
        } else {
          _showErrorSnackBar(errorMessage);
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF66BB6A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
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
