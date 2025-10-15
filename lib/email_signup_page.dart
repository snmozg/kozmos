import 'package:flutter/material.dart';
import 'design_system.dart' hide AppColors;
import 'email_login_page.dart';
import 'services/auth_service.dart';
import 'main.dart'; // For HomePage navigation and AppColors

/// Email Sign-Up Page - For new users to create an account
class EmailSignupPage extends StatefulWidget {
  const EmailSignupPage({Key? key}) : super(key: key);

  @override
  State<EmailSignupPage> createState() => _EmailSignupPageState();
}

class _EmailSignupPageState extends State<EmailSignupPage> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Auth service instance
  final _authService = AuthService();

  // UI states
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Form validation states
  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _nameController.dispose();
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
                            'Hesabını Oluştur',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkPlum,
                              letterSpacing: 0.5,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Kişisel yolculuğuna başlamak için birkaç adım kaldı',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lighterPlum.withOpacity(0.7),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Name Field
                          _buildInputField(
                            label: 'İsim',
                            controller: _nameController,
                            errorText: _nameError,
                            keyboardType: TextInputType.name,
                            prefixIcon: Icons.person_rounded,
                            onChanged: (value) {
                              if (_nameError != null) {
                                setState(() => _nameError = null);
                              }
                            },
                          ),

                          const SizedBox(height: 20),

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
                            helperText: 'En az 8 karakter',
                            onChanged: (value) {
                              if (_passwordError != null) {
                                setState(() => _passwordError = null);
                              }
                            },
                          ),

                          const SizedBox(height: 40),

                          // Sign Up Button
                          AnimatedButton(
                            onPressed: _isLoading ? null : _handleSignUp,
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
                                        'Kayıt Ol',
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

                          // Login Link
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Zaten bir hesabın var mı? ',
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
                                        page: const EmailLoginPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Giriş Yap',
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
    String? helperText,
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
        ] else if (helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            helperText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.lighterPlum.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }

  /// Sign up user with email and password
  Future<void> _handleSignUp() async {
    // Clear previous errors
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
    });

    // Validate inputs
    bool hasError = false;

    if (_nameController.text.trim().isEmpty) {
      setState(() => _nameError = 'İsim gerekli');
      hasError = true;
    }

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
    } else if (_passwordController.text.length < 8) {
      setState(() => _passwordError = 'Şifre en az 8 karakter olmalı');
      hasError = true;
    }

    if (hasError) return;

    // Start loading
    setState(() => _isLoading = true);

    try {
      // Call Firebase Auth Service
      final user = await _authService.signUpWithEmailPassword(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        if (user != null) {
          // Sign-up successful - navigate to home
          _showSuccessSnackBar('Hesap başarıyla oluşturuldu!');
          
          // Wait for snackbar then navigate
          await Future.delayed(const Duration(milliseconds: 500));
          
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const KozmosHomePage(),
              ),
            );
          }
        } else {
          // Should not happen, but handle just in case
          setState(() {
            _emailError = 'Kayıt oluşturulamadı. Lütfen tekrar deneyin.';
          });
        }
      }
    } catch (e) {
      // Handle Firebase errors
      if (mounted) {
        // Check if it's a specific error message
        final errorMessage = e.toString();
        
        if (errorMessage.contains('email-already-in-use') ||
            errorMessage.contains('zaten kullanılıyor')) {
          setState(() {
            _emailError = 'Bu e-posta adresi zaten kullanılıyor';
          });
        } else if (errorMessage.contains('weak-password') ||
            errorMessage.contains('zayıf')) {
          setState(() {
            _passwordError = 'Şifre çok zayıf';
          });
        } else if (errorMessage.contains('invalid-email') ||
            errorMessage.contains('Geçersiz')) {
          setState(() {
            _emailError = 'Geçersiz e-posta adresi';
          });
        } else {
          // Generic error
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
