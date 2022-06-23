# my_fit_logger
Mobile application for logging progress of your healthy lifestyle

## Localization
App supports multiple languages, currently:
- english
- spanish
- german

### Prerequisites for localization:
- add translation files
- add dependencies
- run flutter gen-l10n

## Icons and splash screens
- create folder assets and put in files
- set pubspec.yaml:
  - flutter_icons:
    - android: true
    - ios: true
    - image_path: "assets/icons/places.png"
    - adaptive_icon_background: "#191919"
    - adaptive_icon_foreground: "assets/icons/adaptive-places.png"
- run: flutter pub run flutter_launcher_icons:main

## Firebase push notification
- messaging page in side and bottom navigation bar
- on flutter messaging panel send notification to app users
- when user clicks on received message it gets saved to firebase db
  - in background
  - in foreground
  - and in terminated/non-terminated state 
