# Kozmos Programs Feature - Design Documentation

## Overview
The Programs feature transforms Kozmos from a collection of individual meditations into a professional platform that guides users step-by-step toward their wellness goals. Inspired by Meditopia's structured approach, this feature groups existing meditations into goal-oriented series.

## Design Philosophy
The Programs feature maintains Kozmos's established warm, modern, and gentle aesthetic while introducing a premium, professional touch. The design creates a sense of journey and progress, encouraging users to commit to structured meditation practices.

## Color Palette (Consistent with existing design)
- **Background:** Warm Cream (#FFFDD0)
- **Primary Elements/Cards:** Soft Dusty Rose or light Peach (#FADCD9)
- **Text:** Deep, sophisticated Dark Plum (#4A2C4B)
- **Accent & Progress:** Soft, elegant Gold (#D4AF37)
- **Supporting Colors:** Light Peach (#FFF5E6), Lighter Plum (#6B4C6D)

## User Flow

### Screen 1: Programs Listing Page (`programs_listing_page.dart`)

#### Access
- Available from the main navigation bar
- Replaces "Favoriler" with "Programlar" tab
- Icon: Calendar (calendar_today_outlined)

#### Layout Structure

**Header Section:**
- Large, elegant title: "Programlar"
- Subtitle: "Adım Adım Yolculuklar"
- Minimal spacing, clean typography
- Font: 36px (title), 16px (subtitle)

**Program Cards:**
- **Height:** 340px per card
- **Spacing:** 24px between cards
- **Design Elements:**
  - Beautiful abstract gradient backgrounds with custom painted patterns
  - Glassmorphism overlay for depth and sophistication
  - Program duration badge (e.g., "7 Gün • 10 Dakika/gün")
  - Program title (24px, bold)
  - Tagline/benefit statement (14px, light)
  - Smart action button (changes based on state)

**Action Button States:**
1. **Not Started:** Gold "Başla" button with shadow
2. **In Progress:** Dark plum "Devam Et" button with progress bar fill (shows percentage)
3. **Completed:** Gold outlined "Tekrar Başla" button with replay icon

**Visual Enhancements:**
- Completion badge (gold circle with checkmark) on completed programs
- Subtle shadows for depth (8px blur, 8px offset)
- Rounded corners (24px radius)
- Custom painted backgrounds specific to each program type

#### Available Programs

1. **7 Günlük Stres Yönetimi Programı**
   - Tagline: "Her gün 10 dakika ile zihinsel yüklerinizden arının"
   - 7 sessions × 10 minutes
   - Gradient: Purple tones
   - Pattern: Ripple circles

2. **10 Günlük Odaklanma Programı**
   - Tagline: "Dikkatinizi güçlendirin, verimliliğinizi artırın"
   - 10 sessions × 12 minutes
   - Gradient: Blue tones
   - Pattern: Concentric circles

3. **14 Günlük Uyku İyileştirme Programı**
   - Tagline: "Kaliteli uykuya giden yolculuğunuz başlıyor"
   - 14 sessions × 15 minutes
   - Gradient: Deep purple/indigo
   - Pattern: Stars

4. **21 Günlük Şükran Yolculuğu**
   - Tagline: "Yaşama yeni bir bakış açısı kazanın"
   - 21 sessions × 8 minutes
   - Gradient: Pink tones
   - Pattern: Heart shape

5. **7 Günlük Enerji Artırma Programı**
   - Tagline: "Her gün enerjinizi yenileyin ve canlanın"
   - 7 sessions × 10 minutes
   - Gradient: Orange/coral tones
   - Pattern: Sun rays

### Screen 2: Program Detail Page (`program_detail_page.dart`)

#### Access
- Opens when user taps any program card from listing page
- Full-screen immersive experience

#### Layout Structure

**Custom App Bar (SliverAppBar):**
- Expandable height: 350px
- Pinned header for scroll persistence
- Back button in circular container with shadow
- Hero image with gradient overlay
- Progress badge: "X / Y Tamamlandı" in gold
- Program title overlay at bottom

**Description Section:**
- Comprehensive program description
- Font: 15px, 1.6 line height for readability
- Warm, encouraging tone

**Progress Bar:**
- Label: "İlerleme"
- Percentage display in gold
- Rounded progress bar (10px radius)
- Gold gradient fill
- Light background showing total

**Sessions List:**
- Header: "Seanslar" (20px, bold)
- Vertical list of numbered sessions

#### Session Card Design

**States:**
1. **Completed** (green checkmark)
   - White background
   - Gold border (2px)
   - Gold checkmark icon
   - Full opacity text

2. **Unlocked/Current** (play icon)
   - White background
   - Light border
   - Play icon in dark plum
   - Full opacity text
   - Arrow indicator on right

3. **Locked** (lock icon)
   - Muted background
   - No border
   - Lock icon at 30% opacity
   - Text at 40% opacity
   - Non-interactive

**Card Structure:**
```
┌─────────────────────────────────────┐
│ [Icon]  Gün 1                       │
│         Temeller ve İlk Nefes    → │
│         10 Dakika                   │
└─────────────────────────────────────┘
```

**Elements:**
- Status icon (48×48px circle)
- "Gün X" label (12px, gold or muted)
- Session title (16px, bold)
- Duration (13px, light)
- Arrow icon (only for unlocked)

#### Session Titles & Descriptions

**Stress Management (7 Days):**
1. Temeller ve İlk Nefes
2. Bedensel Farkındalık
3. Düşünceleri Gözlemlemek
4. Rahatlamaya İzin Vermek
5. Stresle Barış
6. Güçlü Kalmak
7. Yeni Bir Başlangıç

**Focus Program (10 Days):**
1. Dikkat Nedir?
2. Tek Noktaya Odaklanma
3. Dikkati Güçlendirmek
4. Zihinsel Netlik
5. Derinleşen Konsantrasyon
6. Sakin ve Odaklı
7. Akış Halinde Olmak
8. Sürdürülebilir Odak
9. Gelişmiş Farkındalık
10. Ustalaşmak

**Sleep Improvement (14 Days):**
1. Uyku ve Dinlenme
2. Gevşeme Temelleri
3. Bedeni Rahatlatmak
4. Zihinsel Sakinlik
5. Gece Rutini Oluşturmak
6. Derin Gevşeme
7. Uykuya Hazırlanmak
8. Düşünceleri Bırakmak
9. Huzurlu Bir Gece
10. Kaliteli Uyku
11. Sabah Enerjisi
12. Uyku Döngüsü
13. Uyum ve Denge
14. Mükemmel Bir Gece

#### Navigation
- Tapping unlocked session → Opens existing `MeditationDetailPage`
- Passes session data as Meditation object
- Gradient colors safely cast from List
- Full integration with existing player

## Technical Implementation

### Files Created
1. `programs_listing_page.dart` (683 lines)
2. `program_detail_page.dart` (568 lines)

### Integration Points
- `main.dart`: Updated bottom navigation (Favoriler → Programlar)
- Navigation handler added for Programs tab (index 2)
- Import of `programs_listing_page.dart`

### Key Features
- **Progress Tracking:** Each program tracks completedSessions and calculates percentage
- **Smart Unlocking:** Sessions unlock sequentially (current + 1)
- **State Management:** StatefulWidget with proper state handling
- **Custom Painting:** ProgramBackgroundPainter and ProgramHeroPainter for unique visuals
- **Type Safety:** Proper gradient casting when navigating to MeditationDetailPage
- **Responsive Layout:** Uses CustomScrollView with Slivers for smooth scrolling

### Design Patterns
- **Glassmorphism:** Overlays with blur effects for premium feel
- **Gradient Backgrounds:** Unique colors per program type
- **Shadow Depth:** Consistent 8-10px blur for elevation
- **Rounded Corners:** 16-24px radius throughout
- **Icon States:** Clear visual feedback for all session states

## User Experience Highlights

### Visual Hierarchy
1. **Primary:** Program cards demand attention with size and beauty
2. **Secondary:** Progress indicators and badges provide context
3. **Tertiary:** Supporting text and metadata

### Interaction Design
- **Cards:** Full card tap area for easy interaction
- **Buttons:** Clear CTAs with appropriate sizing (50px height)
- **Feedback:** Visual state changes on tap
- **Navigation:** Intuitive back buttons and flow

### Progressive Disclosure
- Listing shows overview → Detail reveals structure → Session opens content
- Information revealed at appropriate stages
- No overwhelming the user

### Emotional Design
- **Hope:** "Adım Adım Yolculuklar" suggests achievable progress
- **Achievement:** Gold accents celebrate completion
- **Guidance:** Numbered days provide clear structure
- **Encouragement:** Warm colors and smooth animations

## Comparison with Meditopia

### Inspired Elements
✅ Structured program approach
✅ Day-by-day progression
✅ Clear session titles and goals
✅ Progress tracking
✅ Sequential unlocking

### Kozmos Differentiation
🌟 Warmer, more organic color palette
🌟 Glassmorphism vs flat design
🌟 Custom painted backgrounds vs photos
🌟 More spacious, breathable layout
🌟 Seamless integration with existing player

## Future Enhancement Opportunities

1. **Analytics:**
   - Track completion rates
   - Identify popular programs
   - Suggest programs based on user behavior

2. **Personalization:**
   - Custom program creation
   - Adaptive difficulty
   - Reminders and notifications

3. **Social Features:**
   - Share progress
   - Program challenges
   - Community support

4. **Content Expansion:**
   - More program types
   - Longer programs (30, 60, 90 days)
   - Expert-led series

5. **Gamification:**
   - Badges and achievements
   - Streak tracking
   - Milestone celebrations

## Conclusion

The Programs feature represents a significant evolution for Kozmos, transforming it from a meditation library into a guided wellness platform. The design maintains the app's gentle, warm aesthetic while introducing professional structure that encourages commitment and celebrates progress. This feature positions Kozmos to compete with top-tier meditation apps while maintaining its unique identity.
