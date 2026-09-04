# LifeTap Mobile App (Flutter) — Stage 5A

UI + navigation only, backed entirely by mock data in
`lib/utils/mock_data.dart`. No network calls yet — that's Stage 5B+.

## Structure

```
lib/
├── main.dart              <- routes table
├── models/                <- Dart classes matching the Django API JSON shapes
├── screens/                <- one file per screen
├── services/
│   └── api_service.dart   <- EMPTY stub; filled in during 5B-5D
├── utils/
│   ├── constants.dart     <- colors, spacing, API base URL placeholder
│   └── mock_data.dart     <- Stage 5A dummy data (delete once real API lands)
└── widgets/
    └── emergency_button.dart
```

Screen flow implemented in this stage:

```
Splash -> Login -> Home -> Emergency -> Result
                     |
                     +-> My Profile
                     +-> Experts
                     +-> Emergency Guides
                     +-> My Emergency Cases
```

The `MockData.classify()` function deliberately mirrors the SAME
keyword rules as the backend's `emergencies/triage.py`, so the demo
"feels" correct even before it's wired to the real API — e.g. typing
"severe chest pain and difficulty breathing" gives HIGH + an expert;
typing "unconscious, not breathing" gives CRITICAL; "minor cut, mild
pain" gives LOW.

## Setup (Ubuntu)

```bash
# Install Flutter (if you haven't already)
sudo snap install flutter --classic
flutter doctor        # follow any remaining setup instructions it prints

cd lifetap_app
flutter pub get
flutter run            # pick a connected device / emulator when prompted
```

If you don't have a physical device connected, an Android emulator or
`flutter run -d chrome` (web) both work fine for this stage since there's
no real GPS/voice/network yet.

## What to check in this demo

1. Splash screen shows briefly, then goes to Login.
2. Login/Register screens validate input but don't call any API (any
   username/password "succeeds").
3. Home screen shows the big red emergency button + the 4 menu tiles.
4. Tapping "Report Emergency" → type symptoms → tap "Get My Location"
   (uses a fixed dummy lat/long) → Submit → Result screen shows the
   right urgency color and either an expert or the fallback guide.
5. Profile / Experts / Guides / My Cases all show mock data matching
   what the real backend fixtures contain.

## Next: Stage 5B

Add `http` and `shared_preferences` to `pubspec.yaml`, implement
`ApiService.login()` / `register()` against
`AppConstants.apiBaseUrl`, and store the JWT. Every screen already
has a `// TODO (Stage 5B/5C/5D/5E/5F)` comment marking exactly what
to change and where.
