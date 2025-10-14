# 🎨 Kozmos - Premium Design System Upgrade

## Genel Bakış
Bu belge, Kozmos uygulamasının tüm ekranlarında uygulanacak **profesyonel tasarım yükseltmelerini** tanımlar. Hedef: Derinlik, akıcılık ve몰입감 (immersive) deneyim.

## 🎯 4 Temel Yükseltme Prensibi

### 1. **Depth & Layering** (Derinlik ve Katmanlar)
Elemanlar arka plandan nazikçe yükselir, dokunsal bir kalite hissi verir.

#### Uygulama:
```dart
// Soft, diffused shadow for floating effect
BoxShadow(
  color: AppColors.darkPlum.withOpacity(0.08),
  blurRadius: 20,
  offset: const Offset(0, 8),
  spreadRadius: 0,
)

// Multiple shadow layers for more depth
boxShadow: [
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
]
```

#### Hangi Elemanlarda:
- ✅ Meditasyon kartları
- ✅ Program kartları
- ✅ Koleksiyon kartları
- ✅ Liste elemanları
- ✅ Arama çubuğu
- ✅ Butonlar

### 2. **Glassmorphism** (Buzlu Cam Efekti)
Yarı saydam, bulanık arka planlı modern efekt.

#### Uygulama:
```dart
// Glassmorphism widget
ClipRRect(
  borderRadius: BorderRadius.circular(radius),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: child,
    ),
  ),
)
```

#### Hangi Elemanlarda:
- ✅ **Bottom Navigation Bar** (mutlaka!)
- ✅ **Player kontrol paneli**
- ✅ Modal sheet'ler
- ✅ Overlay'ler
- ✅ Floating action button'lar

### 3. **Fluid Animations** (Akıcı Animasyonlar)
Yumuşak, doğal hareketler.

#### Uygulama:
```dart
// Screen transitions
PageRouteBuilder(
  transitionDuration: const Duration(milliseconds: 400),
  pageBuilder: (context, animation, secondaryAnimation) => page,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      ),
      child: child,
    );
  },
)

// Button press animation
AnimatedScale(
  scale: _isPressed ? 0.95 : 1.0,
  duration: const Duration(milliseconds: 100),
  curve: Curves.easeInOut,
  child: child,
)

// Sequential fade-in for lists
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: 1.0),
  duration: Duration(milliseconds: 400 + (index * 100)),
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
)
```

#### Animasyon Tipleri:
- **Sayfa Geçişleri:** Cross-fade veya slide-up
- **Buton Press:** Scale down (0.95) → up (1.0)
- **Liste Yükleme:** Sequential fade-in (stagger)
- **Loading:** Pulsing gold orb
- **Scroll:** Parallax efekti (opsiyonel)

### 4. **Dynamic Visuals** (Dinamik Görseller)
Statik yerine canlı, hareketli arka planlar.

#### Uygulama:
```dart
// Animated gradient background
AnimatedContainer(
  duration: const Duration(seconds: 3),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: _gradientBegin,
      end: _gradientEnd,
      colors: colors,
    ),
  ),
)

// Slow-moving particles/shapes
CustomPaint(
  painter: AnimatedBackgroundPainter(
    animation: _controller,
    colors: colors,
  ),
)
```

#### Hangi Yerlerde:
- ✅ **Player ekran arka planı** (mutlaka!)
- ✅ Ana sayfa "Günün Meditasyonu" kartı
- ✅ Program detay hero bölümü
- ✅ Koleksiyon kartları (subtle)

## 📱 Ekran Bazlı Uygulamalar

### **Homepage (Ana Sayfa)**

#### Yükseltmeler:
1. **Floating Cards:**
   ```
   Günün Meditasyonu:
   - Çift katmanlı gölge
   - Subtle parallax (scroll ile hafif hareket)
   - Gradient animasyonu (3 saniye döngü)
   
   Öne Çıkanlar:
   - Soft shadow (20px blur)
   - Hover/press scale efekti
   
   Kategoriler:
   - Sequential fade-in (her kart 100ms arayla)
   - Floating shadow
   ```

2. **Glassmorphism Bottom Nav:**
   ```
   - Backdrop blur (10px)
   - White 15% opacity
   - Border: White 20% opacity
   - Elevated shadow
   - İçerikler altında kayarken blur efekti görünür
   ```

3. **Animated Background:**
   ```
   - Cosmic background'daki yıldızlar daha smooth
   - Yavaş dönen nebula efekti (opsiyonel)
   - Gradient shift (çok subtle)
   ```

### **Meditation Player (Oynatıcı)**

#### Yükseltmeler:
1. **Dynamic Video Background:**
   ```
   Sleep Teması:
   - Yavaş akan bulutlar (looping video)
   - Soft purple → dark blue gradient overlay
   
   Stress Teması:
   - Yumuşak dalga hareketleri
   - Calming ripple efekti
   
   Focus Teması:
   - Minimal geometric shapes
   - Slow rotation
   
   Breathwork Teması:
   - Expanding/contracting orb (mevcut ama daha smooth)
   ```

2. **Glassmorphism Controls:**
   ```
   Alt kontrol paneli:
   - Backdrop blur
   - Semi-transparent
   - Soft shadow
   - Play/pause butonu scale animation
   ```

3. **Progress Ring Animation:**
   ```
   - Smooth circular progress
   - Gold glow efekti
   - Pulsing animation (subtle)
   ```

### **Explore Page (Keşfet)**

#### Yükseltmeler:
1. **Search Bar:**
   ```
   - Glassmorphism (blur background)
   - Floating shadow
   - Focus animation (scale up 1.02)
   ```

2. **Mood Collection Cards:**
   ```
   - Gradient animation (slow shift)
   - Glassmorphism overlay
   - Sequential load animation
   - Press scale efekti
   ```

3. **Content Type Grid:**
   ```
   - Hover animation (tilt efekti - opsiyonel)
   - Stagger fade-in
   - Icon pulse on load
   ```

### **Programs Listing**

#### Yükseltmeler:
1. **Program Cards:**
   ```
   - Multi-layer shadow
   - Background video (subtle loop)
   - Progress bar smooth animation
   - Card flip animation (front/back - opsiyonel)
   ```

2. **Progress Indicators:**
   ```
   - Animated fill (smooth transition)
   - Gold glow on complete
   - Percentage count-up animation
   ```

### **Program Detail**

#### Yükseltmeler:
1. **Hero Section:**
   ```
   - Parallax scroll efekti
   - Gradient animation
   - Glassmorphism overlay on scroll
   ```

2. **Session Cards:**
   ```
   - Sequential reveal (stagger)
   - Check animation on complete (bounce)
   - Lock icon subtle shake
   - Unlock animation (burst efekti)
   ```

### **Category Listing**

#### Yükseltmeler:
1. **Header:**
   ```
   - Glassmorphism on scroll (sticky)
   - Smooth collapse animation
   ```

2. **Meditation Cards:**
   ```
   - Stagger load
   - Thumbnail gradient animation
   - Play icon pulse
   ```

### **Breathwork Therapy**

#### Yükseltmeler:
1. **Orb Animation:**
   ```
   - Daha smooth scale transitions
   - Glow efekti (outer ring)
   - Breathing rhythm sync
   ```

2. **Progress Ring:**
   ```
   - Smooth circular progress
   - Color shift during phases
   - Completion burst animation
   ```

## 🎨 Global Component Library

### **GlassmorphismContainer**
```dart
class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;
  
  const GlassmorphismContainer({
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.15,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius,
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
```

### **FloatingCard**
```dart
class FloatingCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  
  const FloatingCard({
    required this.child,
    this.elevation = 8.0,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.06),
            blurRadius: elevation * 3,
            offset: Offset(0, elevation),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.darkPlum.withOpacity(0.04),
            blurRadius: elevation,
            offset: Offset(0, elevation / 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
```

### **AnimatedButton**
```dart
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  
  const AnimatedButton({
    required this.child,
    required this.onPressed,
  });
  
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
```

### **StaggeredList**
```dart
class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final int staggerDelay; // milliseconds
  
  const StaggeredList({
    required this.children,
    this.staggerDelay = 100,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(children.length, (index) {
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
      }),
    );
  }
}
```

### **PulsingOrb (Loading)**
```dart
class PulsingOrb extends StatefulWidget {
  final double size;
  final Color color;
  
  const PulsingOrb({
    this.size = 60.0,
    this.color = AppColors.softGold,
  });
  
  @override
  State<PulsingOrb> createState() => _PulsingOrbState();
}

class _PulsingOrbState extends State<PulsingOrb>
    with SingleTickerProviderStateMixin {
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
```

### **AnimatedGradientBackground**
```dart
class AnimatedGradientBackground extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;
  
  const AnimatedGradientBackground({
    required this.colors,
    this.duration = const Duration(seconds: 5),
  });
  
  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground>
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
```

## 🎬 Animation Curves Guide

```dart
// Page transitions (smooth, elegant)
Curves.easeInOutCubic

// Button press (snappy)
Curves.easeInOut

// List item entrance (natural)
Curves.easeOutCubic

// Loading pulse (breathing)
Curves.easeInOut

// Scale animations (bounce alternative - subtle)
Curves.easeOutBack

// Slide animations (smooth)
Curves.easeInOutQuart
```

## 📏 Shadow System

### Level 1 - Minimal (Subtle Elevation)
```dart
BoxShadow(
  color: AppColors.darkPlum.withOpacity(0.04),
  blurRadius: 8,
  offset: const Offset(0, 2),
)
```
**Kullanım:** Tag'ler, küçük butonlar

### Level 2 - Standard (Normal Cards)
```dart
boxShadow: [
  BoxShadow(
    color: AppColors.darkPlum.withOpacity(0.06),
    blurRadius: 15,
    offset: const Offset(0, 4),
  ),
]
```
**Kullanım:** Liste kartları, içerik türü kartları

### Level 3 - Elevated (Prominent Elements)
```dart
boxShadow: [
  BoxShadow(
    color: AppColors.darkPlum.withOpacity(0.08),
    blurRadius: 20,
    offset: const Offset(0, 8),
  ),
]
```
**Kullanım:** Meditasyon kartları, arama çubuğu

### Level 4 - Floating (Hero Elements)
```dart
boxShadow: [
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
]
```
**Kullanım:** Günün meditasyonu, program kartları

### Level 5 - Premium (Special Moments)
```dart
boxShadow: [
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
]
```
**Kullanım:** Completion badge, premium butonlar

## ⏱️ Animation Timings

```dart
// Instant feedback
const Duration(milliseconds: 100)  // Button press

// Quick transitions
const Duration(milliseconds: 200)  // Icon changes, color shifts

// Standard animations
const Duration(milliseconds: 400)  // Page transitions, fade-ins

// Smooth, noticeable
const Duration(milliseconds: 600)  // Drawer open, large movements

// Slow, ambient
const Duration(seconds: 3-5)       // Gradient shifts, background animations
```

## 🎯 Implementation Priority

### Phase 1 - Core Foundations (İlk Öncelik)
1. ✅ **Glassmorphism Bottom Nav** → Tüm sayfalarda görünür, büyük etki
2. ✅ **Floating Card Shadows** → Tüm kartlara uygula
3. ✅ **Button Press Animations** → Tüm butonlara uygula
4. ✅ **Page Transition Animations** → Navigator'da global

### Phase 2 - Visual Enhancement
1. ✅ **Player Dynamic Background** → En몰입감 yüksek ekran
2. ✅ **Pulsing Orb Loader** → Loading states
3. ✅ **Staggered List Animations** → Explore, Programs
4. ✅ **Animated Gradients** → Hero sections

### Phase 3 - Polish & Delight
1. ✅ **Sequential Reveals** → Tüm liste elemanları
2. ✅ **Completion Animations** → Program tamamlama
3. ✅ **Micro-interactions** → Hover efektleri (opsiyonel)
4. ✅ **Parallax Scrolling** → Hero sections (opsiyonel)

## 📊 Performance Considerations

### Do's ✅
- Use `RepaintBoundary` for animated widgets
- Cache complex CustomPaint operations
- Limit simultaneous animations (max 3-4)
- Use `const` constructors where possible
- Profile with DevTools Timeline

### Don'ts ❌
- Avoid animating large images/videos simultaneously
- Don't animate every element on screen
- Avoid deep widget trees in animated sections
- Don't use high blur values (>15) unnecessarily

## 🎨 Design Tokens

```dart
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
}
```

## 🚀 Sonuç

Bu tasarım sistemi, Kozmos'u:
- 🎨 **Daha premium** görünümlü
- ✨ **Daha akıcı** hissettiren
- 🔥 **Daha몰입감** veren
- 💎 **Daha profesyonel** bir uygulamaya dönüştürür!

Tüm bu yükseltmeler, uygulamanın mevcut sıcak ve zarif estetiğini korurken, onu **bir sonraki seviyeye** taşır.

---

**Not:** Bu sistem tüm mevcut sayfalara **kademeli olarak** uygulanmalıdır. Önce core foundations (Phase 1), sonra visual enhancements, en son polish & delight.
