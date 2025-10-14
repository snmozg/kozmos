import 'package:flutter/material.dart';
import 'dart:ui';

// App Colors
class AppColors {
  static const warmCream = Color(0xFFFFFDD0);
  static const dustyRose = Color(0xFFFADCD9);
  static const darkPlum = Color(0xFF4A2C4B);
  static const softGold = Color(0xFFD4AF37);
  static const lightPeach = Color(0xFFFFF5E6);
  static const lighterPlum = Color(0xFF6B4C6D);
}

// Design System Constants
class DesignSystem {
  // Shadow Elevations
  static const shadowLevel1 = 2.0;
  static const shadowLevel2 = 4.0;
  static const shadowLevel3 = 8.0;
  static const shadowLevel4 = 12.0;
  static const shadowLevel5 = 16.0;

  // Blur Amounts
  static const blurSmall = 5.0;
  static const blurMedium = 10.0;
  static const blurLarge = 15.0;

  // Animation Durations
  static const durationInstant = Duration(milliseconds: 100);
  static const durationQuick = Duration(milliseconds: 200);
  static const durationStandard = Duration(milliseconds: 400);
  static const durationSmooth = Duration(milliseconds: 600);
  static const durationAmbient = Duration(seconds: 3);

  // Border Radius
  static const radiusSmall = 8.0;
  static const radiusMedium = 16.0;
  static const radiusLarge = 24.0;
  static const radiusXLarge = 32.0;

  // Glassmorphism
  static const glassOpacity = 0.15;
  static const glassBorderOpacity = 0.2;
  static const glassBlur = 10.0;

  // Shadow Presets
  static List<BoxShadow> getShadow(int level) {
    switch (level) {
      case 1:
        return [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      case 2:
        return [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ];
      case 3:
        return [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ];
      case 4:
        return [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ];
      case 5:
        return [
          BoxShadow(
            color: AppColors.softGold.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ];
      default:
        return [];
    }
  }
}

/// Glassmorphism Container - Frosted glass effect
class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.15,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(DesignSystem.radiusMedium);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: radius,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Floating Card - Elevated card with soft shadows
class FloatingCard extends StatelessWidget {
  final Widget child;
  final int shadowLevel;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const FloatingCard({
    super.key,
    required this.child,
    this.shadowLevel = 3,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(DesignSystem.radiusLarge);

    Widget cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: radius,
        boxShadow: DesignSystem.getShadow(shadowLevel),
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

/// Animated Button - Button with press animation
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;

  const AnimatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.duration = DesignSystem.durationInstant,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.onPressed != null
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed!();
            }
          : null,
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: widget.duration,
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}

/// Staggered List - List with sequential fade-in animation
class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final int staggerDelay;
  final Axis scrollDirection;

  const StaggeredList({
    super.key,
    required this.children,
    this.staggerDelay = 100,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if (scrollDirection == Axis.vertical) {
      return Column(
        children: _buildStaggeredChildren(),
      );
    } else {
      return Row(
        children: _buildStaggeredChildren(),
      );
    }
  }

  List<Widget> _buildStaggeredChildren() {
    return List.generate(children.length, (index) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 400 + (index * staggerDelay)),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          );
        },
        child: children[index],
      );
    });
  }
}

/// Pulsing Orb - Loading indicator
class PulsingOrb extends StatefulWidget {
  final double size;
  final Color color;

  const PulsingOrb({
    super.key,
    this.size = 60.0,
    this.color = AppColors.softGold,
  });

  @override
  State<PulsingOrb> createState() => _PulsingOrbState();
}

class _PulsingOrbState extends State<PulsingOrb> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    widget.color,
                    widget.color.withOpacity(0.5),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Animated Gradient Background
class AnimatedGradientBackground extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;
  final Widget? child;

  const AnimatedGradientBackground({
    super.key,
    required this.colors,
    this.duration = const Duration(seconds: 5),
    this.child,
  });

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _beginAnimation;
  late Animation<Alignment> _endAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _beginAnimation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ).animate(_controller);

    _endAnimation = AlignmentTween(
      begin: Alignment.bottomRight,
      end: Alignment.topRight,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: _beginAnimation.value,
              end: _endAnimation.value,
              colors: widget.colors,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Smooth Page Transition
class SmoothPageRoute extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  SmoothPageRoute({
    required this.page,
    this.duration = DesignSystem.durationStandard,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubic,
              ),
              child: child,
            );
          },
        );
}

/// Slide Up Page Transition
class SlideUpPageRoute extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  SlideUpPageRoute({
    required this.page,
    this.duration = DesignSystem.durationStandard,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.easeInOutCubic;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}

/// Sequential Fade In Widget
class SequentialFadeIn extends StatelessWidget {
  final Widget child;
  final int index;
  final int delayMs;

  const SequentialFadeIn({
    super.key,
    required this.child,
    required this.index,
    this.delayMs = 100,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * delayMs)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
