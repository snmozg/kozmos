# 🔥 Firebase Setup Guide for Kozmos - Complete Instructions

**Last Updated**: 14 Ekim 2025  
**Difficulty**: Beginner-Friendly  
**Time Required**: 15-20 minutes

---

## 📋 Table of Contents
1. [Prerequisites Check](#prerequisites-check)
2. [Firebase CLI Installation](#firebase-cli-installation)
3. [Firebase Login](#firebase-login)
4. [FlutterFire CLI Installation](#flutterfire-cli-installation)
5. [Project Configuration](#project-configuration)
6. [Add Dependencies](#add-dependencies)
7. [Code Already Updated](#code-already-updated)
8. [Test Your Setup](#test-your-setup)
9. [Troubleshooting](#troubleshooting)

---

## 📋 Prerequisites Check

Open your terminal and run these commands to verify prerequisites:

### 1. Check Flutter
```bash
flutter --version
```
✅ **Expected**: Shows Flutter version (e.g., Flutter 3.16.0)  
❌ **If missing**: Install from https://flutter.dev/docs/get-started/install

### 2. Check Node.js
```bash
node --version
```
✅ **Expected**: Shows Node.js version (e.g., v18.17.0 or higher)  
❌ **If missing**: Download from https://nodejs.org/ (LTS version)

### 3. Check npm
```bash
npm --version
```
✅ **Expected**: Shows npm version (e.g., 9.6.7)  
❌ **If missing**: npm is included with Node.js

---

## 🚀 Firebase CLI Installation

### Step 1: Install Firebase CLI

**For macOS (using curl)**:
```bash
curl -sL https://firebase.tools | bash
```

**Alternative (using npm)**:
```bash
npm install -g firebase-tools
```

**What this does**: Installs Firebase command-line tools globally on your computer so you can manage Firebase projects from the terminal.

### Step 2: Verify Installation
```bash
firebase --version
```
✅ **Expected output**: `13.x.x` (or any version number)

---

## 🔑 Firebase Login

### Step 1: Login to Your Firebase Account
```bash
firebase login
```

**What happens**:
1. 🌐 Browser window opens automatically
2. 🔐 Select your Google account (the one with Firebase access)
3. ✅ Click "Allow" to grant permissions
4. ✔️ Terminal shows: **"Success! Logged in as [your-email@gmail.com]"**

### Troubleshooting Login Issues

**If browser doesn't open**:
```bash
firebase login --no-localhost
```
Then copy-paste the URL manually into your browser.

**If already logged in**:
```bash
firebase logout
firebase login
```

**Verify login status**:
```bash
firebase projects:list
```
✅ You should see your Firebase projects listed.

---

## 🎯 FlutterFire CLI Installation

### Step 1: Install FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

**What this does**: Installs the FlutterFire CLI tool that auto-generates Firebase configuration for Flutter apps.

### Step 2: Add to PATH (if needed)

**Check if it works**:
```bash
flutterfire --version
```

**If command not found**, add Dart's bin to your PATH:

1. Open your shell configuration:
```bash
nano ~/.zshrc
```

2. Add this line at the end:
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

3. Save and exit (press `Ctrl+X`, then `Y`, then `Enter`)

4. Reload your shell:
```bash
source ~/.zshrc
```

5. Try again:
```bash
flutterfire --version
```
✅ **Expected**: Shows version number (e.g., 0.3.7)

---

## ⚙️ Project Configuration (MOST IMPORTANT STEP!)

### Step 1: Navigate to Your Project
```bash
cd /Users/sozge/Desktop/kozmos
```

**What this does**: Changes your terminal's working directory to the Kozmos project folder.

### Step 2: Run FlutterFire Configure
```bash
flutterfire configure
```

**What happens next** (Interactive prompts):

#### 📋 Prompt 1: Select a Firebase project
```
? Select a Firebase project to configure your Flutter application with ›
❯ kozmos-app (kozmos-app)
  [Create a new project]
```
- Use **arrow keys** (↑↓) to navigate
- Press **Enter** to select your existing "kozmos" project
- *OR* select "[Create a new project]" if you haven't created one yet

#### 📋 Prompt 2: Select platforms
```
? Which platforms should your configuration support (use arrow keys & space to select)? ›
✔ android
✔ ios
✔ web
  linux (desktop)
  macos (desktop)
  windows (desktop)
```
- Use **space bar** to check/uncheck platforms
- Recommended: Select **android**, **ios**, and **web**
- Press **Enter** when done

#### ✅ Success Message
```
i Found 3 Firebase projects.
✔ Select a Firebase project to configure your Flutter application with · kozmos-app (kozmos-app)
✔ Which platforms should your configuration support (use arrow keys & space to select)? · android, ios, web

Firebase configuration file lib/firebase_options.dart generated successfully with the following Firebase apps:

Platform  Firebase App Id
android   1:123456789:android:abc123def456
ios       1:123456789:ios:abc123def456  
web       1:123456789:web:abc123def456

Learn more about using this file in the FlutterFire documentation:
 > https://firebase.flutter.dev/docs/overview#initialization
```

### Step 3: Verify Generated Files

**Check that these files were created**:

1. **lib/firebase_options.dart** (auto-generated config)
```bash
ls -la lib/firebase_options.dart
```
✅ Should show: `-rw-r--r--  1 sozge  staff  5432 Oct 14 10:30 lib/firebase_options.dart`

2. **Android config** (if you selected Android)
```bash
ls -la android/app/google-services.json
```
✅ Should exist

3. **iOS config** (if you selected iOS)
```bash
ls -la ios/Runner/GoogleService-Info.plist
```
✅ Should exist

4. **Firebase project config**
```bash
ls -la .firebaserc
```
✅ Should exist

⚠️ **IMPORTANT**: 
- **NEVER** manually edit `firebase_options.dart`
- If you need to update config, run `flutterfire configure` again
- These files contain your Firebase API keys (safe for client-side apps)

---

## 📦 Add Dependencies

### Step 1: Open pubspec.yaml
```bash
open pubspec.yaml
```

### Step 2: Add Firebase Dependencies

Find the `dependencies:` section and add these lines:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Existing dependencies (keep these)
  # ...

  # ===== FIREBASE DEPENDENCIES (ADD THESE) =====
  
  # Firebase Core - Required for all Firebase features
  firebase_core: ^2.24.2
  
  # Firebase Authentication - For user login/signup
  firebase_auth: ^4.16.0
  
  # Google Sign-In - For Google authentication
  google_sign_in: ^6.1.6
  
  # Apple Sign-In - For Apple authentication
  sign_in_with_apple: ^5.0.0
  
  # Cloud Firestore - For storing user data (optional but recommended)
  cloud_firestore: ^4.14.0
```

### Step 3: Install Dependencies
```bash
flutter pub get
```

**What this does**: Downloads all Firebase packages and their dependencies.

**Expected output**:
```
Running "flutter pub get" in kozmos...
Resolving dependencies...
+ firebase_core 2.24.2
+ firebase_core_platform_interface 5.0.0
+ firebase_core_web 2.10.0
+ firebase_auth 4.16.0
+ firebase_auth_platform_interface 7.0.9
+ firebase_auth_web 5.8.13
+ google_sign_in 6.1.6
+ sign_in_with_apple 5.0.0
+ cloud_firestore 4.14.0
Changed 47 dependencies!
```

### Step 4: Verify Dependencies
```bash
flutter pub deps | grep firebase
```
✅ Should show all Firebase packages listed.

---

## 💻 Code Already Updated!

**Good news**: Your `lib/main.dart` has already been updated with Firebase initialization code!

### Current main.dart (Lines 1-28):
```dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'meditation_detail_page.dart';
import 'category_listing_page.dart';
import 'breathwork_therapy_page.dart';
import 'programs_listing_page.dart';
import 'explore_page.dart';
import 'design_system.dart';
import 'journey_profile_page.dart';

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// STEP 1: Make main() async and add Firebase initialization
void main() async {
  // STEP 2: Ensures Flutter is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // STEP 3: Initialize Firebase with auto-generated config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // STEP 4: Run the app
  runApp(const KozmosApp());
}
```

### What Each Line Does:

| Line | Code | Explanation |
|------|------|-------------|
| 13-14 | `import 'package:firebase_core/firebase_core.dart';`<br>`import 'firebase_options.dart';` | Imports Firebase initialization code |
| 17 | `void main() async {` | Makes main() async so we can use `await` |
| 19 | `WidgetsFlutterBinding.ensureInitialized();` | Ensures Flutter framework is ready before Firebase |
| 22-24 | `await Firebase.initializeApp(...);` | Initializes Firebase with your project config |
| 27 | `runApp(const KozmosApp());` | Starts your app after Firebase is ready |

---

## 🧪 Test Your Setup

### Step 1: Clean Build
```bash
flutter clean
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

**What to expect**:
1. App compiles successfully (no errors)
2. App launches on your device/simulator
3. Firebase initializes silently in the background
4. App functions normally

### Step 3: Check for Errors

**✅ Success indicators**:
- No compilation errors
- App launches normally
- Console shows no Firebase errors

**❌ Common errors** (see Troubleshooting section):
- `Target of URI doesn't exist: 'firebase_options.dart'`
  → You forgot to run `flutterfire configure`
- `MissingPluginException`
  → Run `flutter clean` and rebuild
- `[FIREBASE] Unable to fetch the default Firebase app`
  → Check `firebase_options.dart` exists

---

## 🔧 Troubleshooting

### Error: "firebase_options.dart doesn't exist"

**Cause**: You haven't run `flutterfire configure` yet.

**Solution**:
```bash
cd /Users/sozge/Desktop/kozmos
flutterfire configure
```

---

### Error: "Command not found: flutterfire"

**Cause**: FlutterFire CLI not in PATH.

**Solution**:
```bash
# Add to PATH
echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc

# Try again
flutterfire --version
```

---

### Error: "MissingPluginException"

**Cause**: Flutter's plugin registry is out of sync.

**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

---

### Error: "No Firebase project found"

**Cause**: Not logged in or no projects exist.

**Solution**:
```bash
# Check login status
firebase login

# List projects
firebase projects:list

# If no projects, create one at https://console.firebase.google.com
```

---

### Error: Compilation errors after adding dependencies

**Solution**:
```bash
# 1. Clean everything
flutter clean
rm -rf ios/Pods ios/Podfile.lock
rm -rf android/.gradle

# 2. Reinstall dependencies
flutter pub get

# 3. For iOS specifically
cd ios && pod install && cd ..

# 4. Rebuild
flutter run
```

---

### iOS Specific Issues

**Error**: "GoogleService-Info.plist not found"

**Solution**:
1. Run `flutterfire configure` and select iOS
2. Or manually download from Firebase Console → Project Settings → iOS app → Download config file
3. Place in `ios/Runner/` directory

---

### Android Specific Issues

**Error**: "google-services.json not found"

**Solution**:
1. Run `flutterfire configure` and select Android
2. Or manually download from Firebase Console → Project Settings → Android app
3. Place in `android/app/` directory

---

## ✅ Verification Checklist

Before moving to authentication implementation, verify:

- [ ] `firebase --version` shows version number
- [ ] `firebase login` successful
- [ ] `flutterfire --version` shows version number
- [ ] `flutterfire configure` completed successfully
- [ ] `lib/firebase_options.dart` exists
- [ ] `pubspec.yaml` has all Firebase dependencies
- [ ] `flutter pub get` runs without errors
- [ ] `flutter run` compiles successfully
- [ ] App launches without Firebase errors

---

## 🎯 Next Steps

Now that Firebase is connected, you can:

### 1. Enable Authentication Methods

Go to Firebase Console (https://console.firebase.google.com):
1. Select your "kozmos" project
2. Go to **Authentication** → **Sign-in method**
3. Enable:
   - ✅ Email/Password
   - ✅ Google
   - ✅ Apple

### 2. Implement Authentication

Your authentication pages are already created:
- `authentication_gate.dart` - Main entry
- `email_login_page.dart` - Login form
- `email_signup_page.dart` - Sign-up form
- `forgot_password_page.dart` - Password reset

### 3. Implement Firebase Auth Methods

Replace the `TODO` comments in your auth pages with actual Firebase calls:

**Example - Email Sign-Up**:
```dart
// In email_signup_page.dart -> _handleSignUp()
try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passwordController.text,
  );
  
  await credential.user?.updateDisplayName(_nameController.text.trim());
  
  // Navigate to home
} catch (e) {
  // Handle errors
}
```

**Example - Email Login**:
```dart
// In email_login_page.dart -> _handleLogin()
try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passwordController.text,
  );
  
  // Navigate to home
} catch (e) {
  // Handle errors
}
```

**Example - Password Reset**:
```dart
// In forgot_password_page.dart -> _handleSendResetLink()
try {
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: _emailController.text.trim(),
  );
  
  // Show success message
} catch (e) {
  // Handle errors
}
```

### 4. Test Authentication Flow

```bash
flutter run
```

Test sequence:
1. Launch app → Should show AuthenticationGate
2. Try Google sign-in → Should authenticate
3. Try Apple sign-in → Should authenticate
4. Try email sign-up → Should create account
5. Try email login → Should authenticate
6. Try password reset → Should send email

---

## 📚 Additional Resources

### Official Documentation
- [FlutterFire Documentation](https://firebase.flutter.dev)
- [Firebase Console](https://console.firebase.google.com)
- [Firebase CLI Reference](https://firebase.google.com/docs/cli)

### Video Tutorials
- [FlutterFire Setup (Official)](https://www.youtube.com/watch?v=sz4slPFwEvs)
- [Firebase Auth in Flutter](https://www.youtube.com/watch?v=rWamixHIKmQ)

### Useful Commands Cheat Sheet
```bash
# Check versions
firebase --version
flutterfire --version
flutter --version

# Login/Logout
firebase login
firebase logout

# List projects
firebase projects:list

# Reconfigure Firebase
flutterfire configure

# Clean build
flutter clean
flutter pub get

# Run app
flutter run

# Build for release
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
```

---

## 🎉 Success!

If you've completed all steps without errors, congratulations! 🎊

Your Kozmos app is now connected to Firebase and ready for:
- ✅ User authentication (Email, Google, Apple)
- ✅ Cloud data storage (Firestore)
- ✅ Real-time updates
- ✅ Push notifications (future)
- ✅ Analytics (future)

---

**Need Help?**
- Check the [Troubleshooting](#troubleshooting) section
- Review [Firebase Console](https://console.firebase.google.com)
- Check your terminal output for specific error messages

**Document Version**: 1.0  
**Last Updated**: 14 Ekim 2025  
**Status**: ✅ Production Ready
