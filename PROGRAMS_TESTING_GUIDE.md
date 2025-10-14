# 🚀 Quick Start Guide - Testing the Programs Feature

## Prerequisites
- Flutter installed and configured
- iOS Simulator or Android Emulator running
- Kozmos project open in VS Code

## Step-by-Step Testing Guide

### 1️⃣ Launch the App
```bash
cd /Users/sozge/Desktop/kozmos
flutter run
```

Wait for the app to compile and launch on your simulator/emulator.

### 2️⃣ Navigate to Programs
1. You'll see the Kozmos homepage with the cosmic background
2. Look at the bottom navigation bar
3. Tap the **"Programlar"** tab (calendar icon, third from left)

### 3️⃣ Explore Programs Listing Page

**What to Look For:**
- [ ] Clean header: "Programlar" / "Adım Adım Yolculuklar"
- [ ] 5 large, beautiful program cards (340px height)
- [ ] Each card shows:
  - [ ] Unique gradient background with custom pattern
  - [ ] Duration badge (e.g., "7 Gün • 10 Dakika/gün")
  - [ ] Program title
  - [ ] Inspiring tagline
  - [ ] Action button (varies by state)

**Test Different States:**

**Not Started Program** (Odaklanma, Uyku, Enerji):
- [ ] Gold "Başla" button
- [ ] No progress indicator
- [ ] Clean, inviting design

**In Progress Program** (Stres Yönetimi):
- [ ] Dark plum "Devam Et" button
- [ ] Shows "43%" completion
- [ ] Progress bar visible inside button

**Completed Program** (Şükran):
- [ ] Gold outline "Tekrar Başla" button
- [ ] Gold checkmark badge in top right
- [ ] Replay icon visible

### 4️⃣ Open a Program Detail

**Tap any program card** to open its detail page.

**What to Look For:**
- [ ] Large hero section (350px) with gradient
- [ ] Back button (circular, top left)
- [ ] Progress badge: "X / Y Tamamlandı"
- [ ] Program title overlay
- [ ] Comprehensive description below
- [ ] Progress bar with percentage
- [ ] "Seanslar" header
- [ ] Numbered session list

### 5️⃣ Examine Session States

**In the Stress Management program (if it's in progress):**

**Completed Sessions (1-3):**
- [ ] Gold checkmark icon (✓)
- [ ] White background
- [ ] Gold border
- [ ] "Gün X" label in gold
- [ ] Full opacity text
- [ ] Right arrow indicator

**Current Session (4):**
- [ ] Play icon (▶)
- [ ] White background
- [ ] Standard border
- [ ] Dark plum play icon
- [ ] Full opacity text
- [ ] Right arrow indicator
- [ ] **Tappable!**

**Locked Sessions (5-7):**
- [ ] Lock icon (🔒)
- [ ] Muted background
- [ ] Faded text (40% opacity)
- [ ] No arrow indicator
- [ ] **Not tappable**

### 6️⃣ Test Session Navigation

**Tap an unlocked session** (one with ✓ or ▶ icon):
- [ ] Navigates to meditation detail page
- [ ] Title shows: "Program Name - Gün X"
- [ ] Session description displayed
- [ ] Meditation player loads correctly
- [ ] All existing player features work

### 7️⃣ Test Back Navigation

**From Session Player:**
- [ ] Tap back → Returns to program detail
- [ ] Progress preserved
- [ ] Session list still visible

**From Program Detail:**
- [ ] Tap back → Returns to programs listing
- [ ] All cards still visible
- [ ] State preserved

**From Programs Listing:**
- [ ] Tap "Ana Sayfa" in nav → Returns to homepage
- [ ] Or swipe back
- [ ] Homepage loads correctly

### 8️⃣ Visual Quality Checklist

**Colors:**
- [ ] Warm Cream background (#FFFDD0)
- [ ] Dark Plum text (#4A2C4B)
- [ ] Soft Gold accents (#D4AF37)
- [ ] Gradient backgrounds unique per program

**Spacing:**
- [ ] 24px between cards
- [ ] 12px between sessions
- [ ] Comfortable padding throughout
- [ ] No overlapping elements

**Shadows:**
- [ ] Cards have subtle depth
- [ ] Buttons have elegant shadows
- [ ] No harsh edges

**Patterns:**
- [ ] Stress: Ripple circles visible
- [ ] Focus: Concentric circles visible
- [ ] Sleep: Stars pattern visible
- [ ] Gratitude: Heart shape visible
- [ ] Energy: Sun rays visible

### 9️⃣ Interaction Testing

**Tap Targets:**
- [ ] All buttons easy to tap
- [ ] Cards respond to full area tap
- [ ] Session cards respond correctly

**Visual Feedback:**
- [ ] Buttons show press state (if implemented)
- [ ] Navigation feels smooth
- [ ] No lag or stutter

**Edge Cases:**
- [ ] Scroll to bottom of programs list
- [ ] Scroll to bottom of sessions list
- [ ] Rapidly tap between screens
- [ ] Back button works from all states

### 🔟 Test Each Program Type

**Program 1: Stres Yönetimi (7 days)**
- [ ] Opens correctly
- [ ] Shows 7 sessions
- [ ] Session titles match design doc

**Program 2: Odaklanma (10 days)**
- [ ] Opens correctly
- [ ] Shows 10 sessions
- [ ] Blue gradient visible

**Program 3: Uyku (14 days)**
- [ ] Opens correctly
- [ ] Shows 14 sessions
- [ ] Stars pattern visible

**Program 4: Şükran (21 days)**
- [ ] Opens correctly
- [ ] Shows 21 sessions
- [ ] Pink gradient visible
- [ ] If completed, shows restart button

**Program 5: Enerji (7 days)**
- [ ] Opens correctly
- [ ] Shows 7 sessions
- [ ] Orange gradient visible

## 🐛 Known Issues to Check

### Should NOT See:
- ❌ Type casting errors
- ❌ Gradient rendering issues
- ❌ Null pointer exceptions
- ❌ Navigation crashes
- ❌ Text overflow
- ❌ Image loading errors
- ❌ Inconsistent colors

### Should See:
- ✅ Smooth scrolling
- ✅ Clean typography
- ✅ Beautiful gradients
- ✅ Proper spacing
- ✅ Logical navigation
- ✅ Consistent design

## 📱 Test on Different Devices

If possible, test on:
- [ ] iPhone 16 Pro (or latest)
- [ ] iPhone SE (smaller screen)
- [ ] iPad (tablet layout)
- [ ] Android phone
- [ ] Android tablet

## 🎨 Design Verification

Compare with design docs:
- [ ] `PROGRAMS_FEATURE_DESIGN.md` - Matches description
- [ ] `PROGRAMS_VISUAL_GUIDE.md` - Matches mockups
- [ ] Colors match Kozmos palette
- [ ] Typography consistent with app
- [ ] Spacing feels professional

## ✅ Acceptance Criteria

The feature is ready when:
1. ✅ All 5 programs display correctly
2. ✅ All 3 button states work (Start/Continue/Restart)
3. ✅ All 3 session states work (✓/▶/🔒)
4. ✅ Navigation flows smoothly
5. ✅ Progress tracking displays accurately
6. ✅ Sessions open meditation player
7. ✅ Design matches Kozmos aesthetic
8. ✅ No crashes or errors
9. ✅ All text readable and appropriate
10. ✅ Touch targets easy to use

## 🎬 Demo Flow (For Presentation)

**Perfect Demo Path:**
1. Start at homepage → "Look at our new Programs feature"
2. Tap "Programlar" → "5 structured meditation journeys"
3. Scroll through cards → "Each program has unique visuals"
4. Tap "Stres Yönetimi" → "7 days of stress management"
5. Show progress bar → "Track your progress"
6. Explain session states → "✓ Completed, ▶ Current, 🔒 Locked"
7. Tap day 4 → "Seamlessly opens meditation player"
8. Back to program → "Pick up where you left off"
9. Back to listing → "Choose your next journey"
10. Tap "Şükran" → "Or restart a completed program"

## 📊 Success Metrics

After testing, the feature should demonstrate:
- **Usability:** Intuitive navigation, clear states
- **Visual Appeal:** Premium design, consistent aesthetic
- **Functionality:** All features work without errors
- **Performance:** Smooth scrolling, no lag
- **Integration:** Seamless with existing app

## 🎉 Next Steps After Testing

Once everything works:
1. ✅ Take screenshots for documentation
2. ✅ Record a demo video
3. ✅ Update README.md with Programs feature
4. ✅ Commit changes to Git
5. ✅ Push to GitHub
6. ✅ Share with team/stakeholders
7. ✅ Gather user feedback
8. ✅ Plan next iteration

---

**Happy Testing!** 🚀 

The Programs feature represents a major evolution for Kozmos. Enjoy exploring the structured meditation journeys! 🧘‍♀️✨
