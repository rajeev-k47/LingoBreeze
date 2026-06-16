# LingoBreeze

A language learning vocabulary app built with Flutter and Node.js.

## Project Structure

```
lingobreeze/
├── flutter-app/          # Flutter mobile app
│   └── lib/
│       ├── core/         # Constants, theme, network, errors
│       ├── data/         # Data sources, models, repository implementations
│       ├── domain/       # Entities, repository interfaces
│       └── presentation/ # Providers, screens, widgets
└── backend/              # Node.js API server
    └── src/
        ├── config/       # Firebase configuration
        ├── controllers/  # Request handlers
        ├── data/         # In-memory store (dev fallback)
        └── routes/       # Express route definitions
```

## Features

- **My Vocabulary** – View saved words with animated list, pull-to-refresh, swipe to delete
- **Browse Words** – Discover available words from the API and add them with one tap
- **Add Word** – Modal bottom sheet with form validation for custom entries
- **States** – Loading, empty, error, and filled states across all screens
- **Animations** – Staggered list entrance, animated bottom sheet, snackbar feedback

## Tech Stack

| Layer       | Technology                      |
| ----------- | ------------------------------- |
| Frontend    | Flutter, Provider (state mgmt)  |
| Backend     | Node.js, Express                |
| Database    | Firebase Firestore (dev fallback)|

## Architecture

Clean Architecture with three layers:

- **Domain** – Entities and repository interfaces (pure Dart)
- **Data** – Remote data sources, JSON models, repository implementations
- **Presentation** – Screens, reusable widgets, ChangeNotifier providers

## Getting Started

### Prerequisites

- Flutter 3.x
- Node.js 18+
- Firebase project (optional – works with in-memory store)

### Backend Setup

```bash
cd backend
cp .env.example .env
npm install
npm start          # Runs on http://0.0.0.0:3000
```

For Firebase (optional, it can also run with localdb for temp. purpose):
1. Create a Firebase project and enable Firestore and setup service account.
2. Run `npm run seed` to populate words

### Flutter Setup

```bash
cd flutter-app
flutter pub get
flutter run
```

> Update `lib/core/constants/api_constants.dart` with your computer's IP if running on a physical device, currently it is coded for android emulator.

### API Endpoints

| Method | Endpoint              | Description            |
| ------ | --------------------- | ---------------------- |
| GET    | `/api/words`          | List all available words |
| GET    | `/api/vocabulary`     | List saved vocabulary  |
| POST   | `/api/vocabulary`     | Save a word            |
| DELETE | `/api/vocabulary/:id` | Remove a saved word    |

 ## Demo
<img src="assets/demo.gif" width="320" alt="App Demo">
