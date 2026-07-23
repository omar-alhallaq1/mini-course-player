<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" width="90" alt="Flutter"/>
  &nbsp;&nbsp;&nbsp;
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg" width="90" alt="Dart"/>
</p>

<h1 align="center">Mini Course Player</h1>

<p align="center">
  A Flutter application designed for seamless video playback and mini-course tracking.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter">
  <img src="https://img.shields.io/badge/Dart-3.x-blue?logo=dart">
  <img src="https://img.shields.io/badge/BLoC-State%20Management-blue">
  <img src="https://img.shields.io/badge/SharedPreferences-Local%20Storage-success">
  <img src="https://img.shields.io/badge/Video_Player-Chewie-orange">
</p>

---

# Table of Contents

* [Features](#features)
* [Architecture](#architecture)
* [Packages Used](#packages-used)
* [UI Design](#ui-design)
* [Resume Playback & Progress Flow](#resume-playback--progress-flow)
* [Project Structure](#project-structure)
* [Architectural Rationale & Trade-offs](#architectural-rationale--trade-offs)
* [What I Would Improve](#what-i-would-improve)
* [AI Tools Disclosure](#ai-tools-disclosure)
* [Getting Started](#getting-started)
* [Running Tests](#running-tests)

---

# Features

* Browse available courses.
* View course details.
* Play videos using **Chewie**.
* Resume playback from the last watched position.
* Save playback position locally using **SharedPreferences**.
* Display per-course progress based on the saved playback position.
* Automatically update course progress after returning from the Course Details screen.
* Loading state.
* Error state.
* Video loading failure handling.
* Dependency Injection using **GetIt**.
* State Management using **Cubit** with `flutter_bloc`.
* Unit Tests.
* Widget Tests.

---

# Architecture

The project follows a simple layered architecture using Cubit for state management and Repository classes for data access.

```text
                    ┌─────────────────────┐
                    │   Presentation UI   │
                    │                     │
                    │ Course List Screen  │
                    │ Course Details      │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │       Cubit         │
                    │                     │
                    │ CourseListCubit     │
                    │ CourseDetailsCubit  │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    Repositories     │
                    │                     │
                    │ CourseRepo          │
                    │ CourseDetailsRepo   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │ SharedPreferences   │
                    │                     │
                    │ Playback Position   │
                    └─────────────────────┘
```

### Responsibilities

* **Presentation** → Displays courses, video playback, progress, loading, and error states.
* **Cubit** → Handles business logic and manages reactive UI state.
* **CourseRepo** → Loads course data from the local JSON asset.
* **CourseDetailsRepo** → Saves and retrieves video playback positions.
* **SharedPreferences** → Provides local persistence for playback positions.
* **GetIt** → Provides dependency injection and manages dependencies.

---

# Packages Used

| Package                | Purpose               |
| ---------------------- | --------------------- |
| `flutter_bloc`         | State Management      |
| `get_it`               | Dependency Injection  |
| `go_router`            | Navigation            |
| `shared_preferences`   | Store Resume Position |
| `video_player`         | Video Playback        |
| `chewie`               | Video Controls        |
| `cached_network_image` | Network Images        |
| `flutter_svg`          | SVG Support           |
| `flutter_screenutil`   | Responsive UI         |
| `animated_snack_bar`   | Error Messages        |
| `lottie`               | Loading Animation     |
| `bloc_test`            | Cubit Testing         |
| `mocktail`             | Mocking               |
| `flutter_test`         | Widget Testing        |

---

# UI Design

The user interface was built following the design specifications:

* **Figma Design File**: [Mini Course Player UI Design](https://www.figma.com/design/rV4Q5FN6iZiD7oG5TdaAVW/Mini-Course-Player-Ui?node-id=0-1&p=f&t=xhnsbFC9BramR2tI-0)

---

# Resume Playback & Progress Flow

The application saves the user's current video playback position locally using `SharedPreferences`.

The saved playback position is accessed through `CourseDetailsRepo`, keeping the persistence logic separate from the Cubits.

### Playback Flow

```text
Course Details Screen
        │
        ▼
CourseDetailsCubit
        │
        ▼
CourseDetailsRepo
        │
        ▼
SharedPreferences
        │
        ▼
Save Playback Position
```

When the user opens the same course again:

1. `CourseDetailsCubit` requests the saved position from `CourseDetailsRepo`.
2. `CourseDetailsRepo` retrieves the position from `SharedPreferences` using the `courseId`.
3. The video player is initialized.
4. Playback resumes from the previously saved position.

### Course Progress Flow

The Course List screen calculates the progress for every course using the saved playback position:

```text
CourseListScreen
        │
        ▼
CourseListCubit
        │
        ├──────────────► CourseRepo
        │                  │
        │                  ▼
        │             Load Courses
        │
        └──────────────► CourseDetailsRepo
                           │
                           ▼
                    Get Last Position
                           │
                           ▼
              savedPosition / durationSeconds
                           │
                           ▼
                     Progress Map
                           │
                           ▼
                    CourseListSuccess
                           │
                           ▼
                  Display Course Progress
```

For example:

```text
Saved Position = 50 seconds
Course Duration = 100 seconds

Progress = 50 / 100 = 0.5

Displayed Progress = 50%
```

The `CourseListCubit` does not access `SharedPreferences` directly. Instead, it depends on `CourseDetailsRepo` to retrieve the saved playback position, keeping storage details encapsulated inside the Repository layer.

When the user returns from the Course Details screen, the Course List screen fetches the latest saved positions and refreshes the progress indicators.

---

# Project Structure

```text
lib/

│
├── core/
│   ├── features/
│   │   ├── course_list_screen/
│   │   │   ├── cubit/
│   │   │   ├── model/
│   │   │   ├── repo/
│   │   │   └── widgets/
│   │   │
│   │   └── course_details_screen/
│   │       ├── cubit/
│   │       ├── repo/
│   │       └── widgets/
│   │
│   ├── routing/
│   ├── utils/
│   ├── widgets/
│   └── styling/
│
├── main.dart
│
test/
│
├── cubit/
│   ├── course_list_cubit_test.dart
│   └── course_details_cubit_test.dart
│
└── widget/
    └── course_card_widget_test.dart
```

---

# Architectural Rationale & Trade-offs

### State Management

`Cubit` was selected over standard BLoC to minimize boilerplate while maintaining a clean, reactive, state-driven architecture.

The application has separate Cubits for the main features:

* `CourseListCubit` handles course loading and progress calculation.
* `CourseDetailsCubit` handles playback position loading and saving.

This keeps the business logic of each feature isolated and easier to test.

### Persistence

`SharedPreferences` was used as a lightweight local key-value store for saving playback positions.

Each position is stored using the course ID:

```text
course_position_<courseId>
```

For example:

```text
course_position_c001
```

The `CourseDetailsRepo` encapsulates all persistence operations, while the Cubits interact with the Repository abstraction instead of accessing `SharedPreferences` directly.

### Progress Calculation

Course progress is calculated using:

```text
savedPlaybackPosition / courseDuration
```

The calculated value is clamped between `0.0` and `1.0` to ensure the progress indicator always receives a valid value.

---

# What I Would Improve

Given more time, I would focus on the following enhancements:

### Database Architecture

Replace `SharedPreferences` with `SQLite` or another structured local database for more scalable persistence of course progress and additional offline metadata.

### Backend Syncing

Synchronize video watch timestamps with a remote backend service to enable seamless cross-device progress synchronization.

### E2E & Integration Testing

Add end-to-end integration tests using `integration_test` to cover the complete flow from course browsing to video playback and progress recovery.

---

# AI Tools Disclosure

In accordance with the guidelines, AI tools, including **Stitch AI**, were utilized during development to assist with:

* Generating Markdown structure for technical documentation.
* Formulating edge-case assertions in `mocktail` for unit test coverage.
* Assisting in UI component layout and prototyping.

All AI suggestions were manually code-reviewed, refactored to fit the project's architecture and coding standards, and verified locally using:

```bash
flutter test
```

---

# Getting Started

## Clone the Repository

```bash
git clone https://github.com/omar-alhallaq1/mini-course-player.git
```

## Install Dependencies

```bash
flutter pub get
```

## Run the Project

```bash
flutter run
```

---

# Running Tests

## Run All Tests

```bash
flutter test
```

## Run Cubit Tests

```bash
flutter test test/cubit
```

## Run Widget Tests

```bash
flutter test test/widget
```
