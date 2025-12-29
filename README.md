# 🚀 GitHub Pull Request Viewer (Flutter)

A Flutter application that displays open GitHub Pull Requests for the current repository, built using **Clean Architecture + BLoC**, with a simulated login system to demonstrate secure token handling.

---

## 🧪 Assignment Overview

**Title:** GitHub Pull Request Viewer with Token Simulation

This project was built as part of a Flutter hiring assignment. The goal is to fetch and display open pull requests from GitHub using the GitHub REST API, while showcasing clean code structure, state management, and best practices.

---

## 📹 Demo Video

🎥 Watch the app demo here:  
https://github.com/thisismanishrajput/github-pr-viewer/blob/main/pr_viewer_recording.mp4


## 🎯 Features

### ✅ Core Functionality
- Fetch open pull requests using GitHub REST API
- Display for each pull request:
  - Title
  - Description / body (if available)
  - Author's username
  - Created date
- Pull-to-refresh support
- Retry option on API failure
- Proper loading, empty, and error states

### 🔐 Simulated Authentication (Bonus)
- Dummy login screen
- Fake token generation on successful login
- Secure token storage using `flutter_secure_storage`
- Auto-login on app restart
- Logout functionality
- Authentication state controls app navigation

### ✨ UI & UX Enhancements
- Clean, card-based UI
- Pull request details screen
- Subtle animations using `animate_do`
- Responsive layout
- Smooth transitions
- Accessible UI components

---

## 🧠 Architecture & Tech Stack

| Category | Used |
|----------|------|
| Flutter | Latest stable |
| State Management | BLoC |
| Architecture | Clean Architecture |
| Dependency Injection | GetIt (Service Locator) |
| Networking | Dio |
| Secure Storage | flutter_secure_storage |
| Animations | animate_do |

---

## 📁 Project Structure

```
lib/
├── api_integration/
│   ├── api_constants.dart
│   ├── connectivity_service.dart
│   ├── dio_client.dart
│   ├── dio_client_x.dart
│   └── dio_exception.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── repo_impl/auth_repo_impl.dart
│   │   │   └── service/auth_local_service.dart
│   │   ├── domain/
│   │   │   └── repo/auth_repo.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       └── view/login_screen.dart
│   │
│   └── pr-viewer/
│       ├── data/
│       │   ├── model/pr_viewer_model.dart
│       │   └── repo_impl/pr_viewer_repo_impl.dart
│       ├── domain/
│       │   └── repo/pr_viewer_repo.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── pr_viewer_bloc.dart
│           │   ├── pr_viewer_event.dart
│           │   └── pr_viewer_state.dart
│           ├── view/
│           │   ├── pr_viewer_screen.dart
│           │   └── pr_details_screen.dart
│           └── widget/
│               └── pr_card.dart
│
├── services/
│   └── service_locator.dart
│
├── utility/
│   ├── constants/string_constants.dart
│   └── result.dart
│
├── app_entry_point.dart
└── main.dart
```

---

## 🔌 API Used

**GitHub REST API – Pull Requests**

```
GET https://api.github.com/repos/{owner}/{repo}/pulls
```

🔹 By default, this API returns only **open** pull requests.  
🔹 For demo purposes, sample pull requests (`test-pr-1`, `test-pr-2`) are intentionally kept open in this repository.

---

## 🔐 Token Handling (Simulated)

- On successful login, a fake token is generated:
  ```
  abc123_github_<timestamp>
  ```
- Token is stored securely using `flutter_secure_storage`
- On app launch:
  - Token is checked
  - User is auto-logged in if token exists
- Logout clears the stored token

This simulates real-world authentication flows without requiring actual GitHub OAuth.

---


## 📱 App Flow

```
1. Launch App
   ↓
2. Check if token exists
   ↓
   ├─ YES → Navigate to PR Viewer
   └─ NO  → Show Login Screen
              ↓
           Enter credentials (any non-empty)
              ↓
           Generate & save token
              ↓
           Navigate to PR Viewer
              ↓
           Display pull requests + token
              ↓
           Logout → Clear token → Back to Login
```

---

## 🧪 Testing the App

### Login Credentials
- **Username:** Any non-empty string (e.g., `testuser`)
- **Password:** Any non-empty string (e.g., `password123`)

### Expected Behavior
1. ✅ Enter any credentials → Login successful
2. ✅ Token is generated and displayed
3. ✅ Pull requests are fetched and displayed
4. ✅ Pull-to-refresh updates the list
5. ✅ Tap on a PR to see details
6. ✅ Logout clears token and returns to login

---


## 🔧 Key Implementation Details

### Clean Architecture Layers

**1. Presentation Layer (UI + BLoC)**
- Handles UI rendering and user interactions
- BLoC manages state and business logic
- Widgets are stateless and reactive

**2. Domain Layer (Repository Interface)**
- Abstract repository contracts
- Defines use cases
- Independent of frameworks

**3. Data Layer (Repository Implementation + Models)**
- Implements repository contracts
- Handles API calls via Dio
- Model classes for JSON parsing

### State Management with BLoC

**Events:**
- `FetchPullRequestsEvent` - Fetch PRs from API
- `RefreshPullRequestsEvent` - Pull-to-refresh
- `LoginEvent` - User login
- `LogoutEvent` - User logout

**States:**
- `PrViewerLoading` - Loading indicator
- `PrViewerLoaded` - Display data
- `PrViewerError` - Show error message
- `AuthAuthenticated` - User logged in
- `AuthUnauthenticated` - User logged out

### Error Handling

- Network errors (no internet)
- Timeout errors
- API errors (4xx, 5xx)
- Parsing errors
- User-friendly error messages

---


## 📝 Assignment Checklist

### Core Requirements
- [x] Fetch open pull requests from GitHub API
- [x] Display title, description, author, and date
- [x] Handle loading, error, and empty states
- [x] Pull-to-refresh functionality
- [x] Clean Architecture structure
- [x] BLoC state management

### Bonus Requirements
- [x] Simulated login screen
- [x] Token generation and storage
- [x] Secure storage implementation
- [x] Auto-login on app restart
- [x] Token display in UI
- [x] Logout functionality

### Additional Features
- [x] PR details screen
- [x] Smooth animations
- [x] Card-based UI design
- [x] Responsive layout
- [x] Proper error handling
- [x] Code documentation

---
