# MyApp

> Flutter MVVM Example Application

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
  - [Build](#build)
  - [Releases](#releases)
- [Project Structure](#project-structure)

## Features

- List and detail view for devices and sensors
- Real-time sensor charts
- Notifications page
- MVVM architecture with separation of concerns
- Mock device and sensor services

## Architecture

This project uses the MVVM (Model-View-ViewModel) pattern:
- **Models**: data classes in `lib/models`
- **Views**: UI pages in `lib/views`
- **ViewModels**: business logic and state in `lib/viewmodels`
- **Services**: data fetching in `lib/services`

## Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart >= 2.17.0
- Android Studio, Xcode, or VS Code

### Installation

1. Clone the repository:
   ```powershell
   git clone https://github.com/yourusername/example_flutter_mvvm.git
   cd example_flutter_mvvm
   ```
2. Install dependencies:
   ```powershell
   flutter pub get
   ```

### Running the App

- On Android:
  ```powershell
  flutter run
  ```
- On iOS:
  ```powershell
  flutter run -d iphone
  ```
- On Web:
  ```powershell
  flutter run -d chrome
  ```

## Build

Para compilar los artefactos de producción:

```powershell
flutter build apk --release
flutter build ios --release
flutter build web --release
```

## Releases

Descarga la última versión desde [GitHub Releases](https://github.com/Frank-C0/example_flutter_mvvm/releases).

## Project Structure

```text
lib/
├── main.dart       # App entry point
├── models/         # Data models
├── services/       # API or mock data services
├── viewmodels/     # ViewModel classes
└── views/          # UI pages/widgets
```
