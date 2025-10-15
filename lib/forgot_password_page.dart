import 'package:flutter/material.dart';
import 'design_system.dart' hide AppColors;
import 'services/auth_service.dart';
import 'main.dart' show AppColors;

/// Forgot Password Page - For users to reset their password
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Text controller
  final _emailController = TextEditingController();
  
  // Auth service instance
  final _authService = AuthService();
  
  // UI states
  bool _isLoading = false;
  bool _emailSent = false;
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
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

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: _emailSent
                        ? _buildSuccessView()
                        : _buildResetForm(),
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

  Widget _buildResetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Title
        const Text(
          'Şifreni Sıfırla',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.darkPlum,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 16),

        // Instructional Text
        Text(
          'Kaydolduğun e-posta adresini gir, sana bir sıfırlama bağlantısı göndereceğiz.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.lighterPlum.withOpacity(0.7),
            height: 1.5,
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

        const SizedBox(height: 40),

        // Send Reset Link Button
        AnimatedButton(
          onPressed: _isLoading ? null : _handleSendResetLink,
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
                      'Sıfırlama Bağlantısı Gönder',
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
      ],
    );
  }

  Widget _buildSuccessView() {
    return Column(
      children: [
        const SizedBox(height: 60),

        // Success Icon
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF66BB6A),
                const Color(0xFF66BB6A).withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF66BB6A).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 70,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 32),

        // Success Title
        const Text(
          'E-posta Gönderildi!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.darkPlum,
          ),
        ),

        const SizedBox(height: 16),

        // Success Message
        Text(
          '${_emailController.text} adresine bir sıfırlama bağlantısı gönderdik. Lütfen e-posta kutunu kontrol et.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.lighterPlum.withOpacity(0.7),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        // Return to Login Button
        AnimatedButton(
          onPressed: () => Navigator.pop(context),
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
            child: const Center(
              child: Text(
                'Giriş Sayfasına Dön',
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

        const SizedBox(height: 24),

        // Resend Link
        AnimatedButton(
          onPressed: () {
            setState(() {
              _emailSent = false;
              _emailController.clear();
            });
          },
          child: Text(
            'Başka bir e-posta ile dene',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.darkPlum.withOpacity(0.8),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? errorText,
    TextInputType? keyboardType,
    IconData? prefixIcon,
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

  /// Send password reset email
  Future<void> _handleSendResetLink() async {
    // Clear previous errors
    setState(() => _emailError = null);

    // Validate email
    if (_emailController.text.trim().isEmpty) {
      setState(() => _emailError = 'E-posta adresi gerekli');
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      setState(() => _emailError = 'Geçersiz e-posta formatı');
      return;
    }

    // Start loading
    setState(() => _isLoading = true);

    try {
      // Call Firebase Auth Service
      await _authService.sendPasswordResetEmail(
        _emailController.text.trim(),
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = e.toString();
        
        setState(() {
          _isLoading = false;
          
          if (errorMessage.contains('user-not-found') ||
              errorMessage.contains('kayıtlı değil')) {
            _emailError = 'Bu e-posta adresi kayıtlı değil';
          } else if (errorMessage.contains('invalid-email') ||
              errorMessage.contains('Geçersiz')) {
            _emailError = 'Geçersiz e-posta adresi';
          } else {
            _emailError = 'E-posta gönderilemedi. Lütfen tekrar dene.';
          }
        });
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
