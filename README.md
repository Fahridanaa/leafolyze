# Leafolyze

Leafolyze is a mobile application for tomato leaf disease detection and management, developed as a Final Project Problem Based Learning (PBL) by Group 4 in the 5th semester. It helps users identify tomato leaf diseases through image analysis and provides treatment recommendations.

## Team Members

| Name | NIM | Role |
|------|-----|------|
| Fahridana Ahmad Rayyansyah | 2241720158 | Mobile Engineering |
| Muhammad Ridlo Febrio Putra | 2241720098 | Backend Engineering |
| Lilla Nur Wahidiyah | 2241720144 | System Analyst & QA |

## Features

- 🌿 Tomato Leaf disease detection through image analysis
- 📱 User profile management
- 📖 Disease history tracking
- 🔍 Detailed disease information
- 💊 Treatment recommendations
- 🏪 Shop integration for plant care products

## Tech Stack

- Flutter 3.x
- Dart
- BLoC Pattern for state management
- GoRouter for navigation
- REST API integration
- Image processing capabilities


## Installation

1. Clone the repository
```bash
git clone https://github.com/Fahridanaa/leafolyze.git
```

2. Install Dependencies
```bash
cd leafolyze
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Project Structure
```plaintext
lib/
├── blocs/              # Business Logic Components
├── config/             # App-wide configuration, and routes
├── core/               # Core application components
│   ├── screens/        # Main application screens and pages
│   ├── widgets/        # Reusable UI components and widgets
├── models/             # Data models
├── repositories/       # Data layer
└── utils/              # Utilities and helpers
```
