# My Roadmap — Intelligent Learning Path Management for iOS

<div align="center">

**Structuring skill development one task at a time.**

A production-grade iOS learning management system demonstrating advanced MVVM architecture, reactive patterns, and real-world app design challenges.

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange?style=flat-square&logo=swift)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-15+-blue?style=flat-square&logo=apple)](https://www.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-2.0+-green?style=flat-square)](https://developer.apple.com/xcode/swiftui/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM%2BCoordinator-lightblue?style=flat-square)](#architecture)

</div>

---

## Overview

**My Roadmap** solves a critical problem in self-directed learning: keeping learners accountable to structured, progressive skill development. 

Unlike generic task managers, this app enforces **sequential learning prerequisites**, provides **granular progress tracking** across diverse content types (books, articles, videos, goals), and supports **branching learning paths** for comprehensive skill coverage.

Built with production-ready patterns and battle-tested iOS architecture, My Roadmap demonstrates:
- **Advanced MVVM + Coordinator pattern** with sophisticated state management
- **State design pattern** for complex task lifecycle management
- **Reactive data binding** using Combine and observable patterns
- **Custom iOS framework integration** (AppGroups, WidgetKit, UserNotifications)
- **REST API integration** with secure token management
- **Offline-first architecture** using local JSON persistence

---

## Core Features

### 1️⃣ Authentication & Secure API Management

Built on three custom libraries for seamless auth handling:

- [**AdelsonAuthManager**](https://github.com/Ahmed23Adel/AdelsonAuthManager) — Handles signup, login, and token refresh with secure keychain storage  
- [**AdelsonApiCaller**](https://github.com/Ahmed23Adel/AdelsonApiCaller) — Automatically attaches tokens to requests, refreshes expired tokens, and re-authenticates when needed  
- [**AdelsonValidator**](https://github.com/Ahmed23Adel/AdelsonValidator) — Client-side validation for email format and password policies (easy/medium/hard), and any custom validation  

**How It Works:**
1. Validate input with AdelsonValidator
2. Send request via AdelsonApiCaller
3. Handle auth automatically with AdelsonAuthManager

<div style="display: flex; gap: 20px; justify-content: center; margin: 20px 0;">
  <img src="https://github.com/user-attachments/assets/53753ffc-ad80-44a9-b1a4-36cf54524995" width="280" alt="Sign up screen"/>
  <img src="https://github.com/user-attachments/assets/2e602fdc-a843-42fb-85f4-458a2400c2d4" width="280" alt="Login screen"/>
</div>

---

### 2️⃣ Structured Learning Paths

Create roadmaps combining multiple content types:

- 📚 **Books** — Track pages read with progress toward completion
- 📄 **Articles** — Link and annotate external reading materials  
- 🎥 **YouTube Playlists** — Count videos watched in a series
- 🎯 **Goals** — Define milestone achievements
- 🔀 **Branches** — Optional parallel learning paths (prerequisite-aware)

Each task type has tailored state management (Not Started → In Progress → Completed) with content-specific tracking.

<div style="display: flex; gap: 10px; justify-content: center; margin: 20px 0; flex-wrap: wrap;">
  <img src="https://github.com/user-attachments/assets/fdb120c5-f60d-4208-8e1a-4b456a5caf51" width="180" alt="Create roadmap step 1"/>
  <img src="https://github.com/user-attachments/assets/4948d04c-b046-46cc-bd2f-df6245c53c45" width="180" alt="Choose task type"/>
  <img src="https://github.com/user-attachments/assets/89633d85-145d-422f-9472-0d5dfec5cf18" width="180" alt="Add tasks"/>
  <img src="https://github.com/user-attachments/assets/440495f9-7ef2-4128-b09f-1f2877eba7ae" width="180" alt="Task builder"/>
</div>

---

### 3️⃣ Sequential Learning Enforcement

Prevents knowledge gaps by locking tasks until prerequisites complete:

- ✅ Tasks blocked until prior tasks reach "Completed" state
- 🚦 Visual indicators (dim/greyed out) for unavailable tasks  
- 🎯 Users can only start one valid path at a time
- 📊 Progress validation prevents invalid state transitions

---

### 4️⃣ Granular Progress Tracking & Task Management

Easily monitor your learning journey with detailed progress tracking and task management tools.

#### ✅ Task Status Types
* 🔴 **Not Started** – Tasks waiting for prerequisites to be completed  
* 🟠 **In Progress** – Currently active tasks with deadlines  
* 🟢 **Completed** – Finished tasks with a completion summary  

#### 🔑 Key Features
1. 🚦 Users can't start a task until **previous tasks are completed** (sequential learning flow).  
2. 📈 Users can **update their progress** (e.g., mark videos watched in a YouTube playlist, or pages read in a book).  
3. 📝 Detailed task tracking helps maintain **motivation and accountability**.  

<div style="display: flex; gap: 10px; justify-content: center; margin: 20px 0; flex-wrap: wrap;">
  <img src="https://github.com/user-attachments/assets/ce772d68-587c-49c7-b398-bfe42dd493bc" width="180" alt="Task not started"/>
  <img src="https://github.com/user-attachments/assets/67786717-f6c8-4847-b6f6-32a54ba7ec45" width="180" alt="Task in progress"/>
  <img src="https://github.com/user-attachments/assets/1ad73189-6a34-43ee-963c-fcd59088d547" width="180" alt="Task completed"/>
</div>

---

### 5️⃣ Home Screen Widget

At-a-glance task summary showing current task and completion percentage.

<div style="display: flex; justify-content: center; margin: 20px 0;">
  <img src="https://github.com/user-attachments/assets/d0619d1d-bef9-4542-a03c-152be9d3aac4" width="220" alt="Widget showing current task and progress"/>
</div>

---

## Technical Architecture

### Design Patterns

#### MVVM + Coordinator

```
AppCoordinator (root navigation)
├── AuthCoordinator (signup/login)
├── HomeCoordinator (task management + sheets)
├── AddRoadmapCoordinator (multi-step wizard)
├── SettingsCoordinator
└── ProfileCoordinator
```

- **Views**: Pure SwiftUI, data-driven, no business logic
- **ViewModels**: `@ObservedObject` with computed display values, async task management
- **Coordinators**: Manage navigation stack and sheet presentation
- **Repositories**: REST API + local persistence abstraction

#### State Design Pattern

Task lifecycle implemented with state objects:

```swift
protocol TaskBookState { 
    func markProgress(_ pages: Int)
    func transition() -> TaskBookState
}

struct BookNotStarted: TaskBookState { 
    func transition() -> TaskBookState { 
        BookInProgress(currentPage: 0, totalPages: self.totalPages) 
    } 
}

struct BookInProgress: TaskBookState {
    var currentPage: Int
    var totalPages: Int
    
    func transition() -> TaskBookState {
        currentPage >= totalPages ? BookCompleted() : self
    }
}

struct BookCompleted: TaskBookState { }
```

**Why**: Prevents invalid state transitions, encapsulates state-specific behavior, makes testing trivial.

#### Prerequisites & Task Dependencies

```swift
func canStartTask(_ task: GenericTask) -> Bool {
    task.prerequisites.allSatisfy { $0.isCompleted }
}

// Used in HomeView to disable/dim unavailable tasks
.disabled(!canStartTask(task))
.opacity(canStartTask(task) ? 1.0 : 0.5)
```

### Data Flow

```
REST API ──→ AuthManager ──→ ApiCaller (token attachment)
              ↓
         Repository
         ↓      ↓
    CloudKit  FileManager
        ↓
   ViewModel
        ↓
   SwiftUI View
```

1. **Authentication**: Secure login via custom `AdelsonAuthManager` (tokens in Keychain)
2. **API calls**: Automatic token attachment via `AdelsonApiCaller`  
3. **Serialization**: Type-safe `Codable` JSON with custom decoders
4. **Persistence**: Local JSON files + optional CloudKit sync
5. **Reactivity**: Combine publishers for real-time UI updates

### Security

- **Keychain storage** for auth tokens (never in UserDefaults)
- **HTTPS only** for API communication
- **Token refresh** handled transparently via `AdelsonApiCaller`
- **Secure logout** clears Keychain + local state

---

## Project Structure

```
my roadmap/
├── my_roadmapApp.swift              ← Entry point (AppCoordinator setup)
├── CLAUDE.md                         ← Detailed developer guide
│
├── AppCoordinator/                  ← Root navigation coordinator
├── Authentication/                  ← Auth utilities & state management
├── Home/                            ← Main tab: task list + state sheets
│   ├── HomeView.swift
│   ├── HomeViewModel.swift
│   ├── Coordinator/
│   └── Sheets/                      ← Task detail modals
│       ├── Book/[NotStarted|InProgress|Completed]
│       ├── Article/[NotStarted|InProgress|Completed]
│       ├── Youtube/[NotStarted|InProgress|Completed]
│       └── Goal/[NotStarted|Completed]
├── AddNewRoadmap/                   ← Multi-step creation wizard
│   ├── Step1: Name input
│   ├── Step2: Drag-and-drop task builder
│   └── Step3: Confirmation + save
├── RoadmapCanvas/                   ← Visual task hierarchy
├── TasksTypesBusLogic/              ← Core models & state patterns
│   ├── GenericTask/                 ← Task protocol
│   ├── TasksTypes/                  ← State implementations
│   ├── TaskBranch/                  ← Parallel learning paths
│   └── SavingResults/               ← JSON serialization + persistence
├── Network/                         ← REST API layer
├── Constants/                       ← API endpoints, @AppStorage keys
└── WidgetUtils/                     ← AppGroups shared data

CurrentTaskWidget/                  ← Separate target: lock screen widget
my roadmapTests/                    ← Unit tests
```

**File count**: 150+ Swift files, ~15,000+ LOC, well-organized into logical modules.

---

## Technologies & Frameworks

### Core iOS
- **Swift 5.9+** — Modern language features
- **SwiftUI 2.0+** — Declarative UI with data binding
- **UIKit** — Limited specialized component use
- **Combine** — Reactive data streams and event handling

### Local & Remote Data
- **FileManager** — JSON-based persistence
- **Codable** — Type-safe serialization
- **REST APIs** — Backend communication
- **AppGroups** — Widget ↔ App data sharing

### System Integration
- **UserNotifications** — Local push notifications
- **WidgetKit** — Home screen + lock screen widgets
- **Keychain Services** — Secure token storage

### Custom SPM Packages (by Ahmed23Adel)
- **AdelsonAuthManager** — Signup, login, token refresh, Keychain
- **AdelsonApiCaller** — HTTP client with automatic token attachment
- **AdelsonValidator** — Email validation, password policies

### Architecture & Patterns
- **MVVM** — Clear separation of concerns
- **Coordinator pattern** — Centralized navigation
- **State design pattern** — Task lifecycle management
- **Repository pattern** — Data source abstraction
- **Dependency injection** — EnvironmentObject for global state

---

## Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 15.0+ deployment target
- Swift 5.9+

### Installation

```bash
git clone https://github.com/Ahmed23Adel/my-roadmap.git
cd my-roadmap
open my\ roadmap.xcodeproj
```

### First Run

1. **Build dependencies**: SPM packages auto-install on first `⌘B`
2. **Configure auth**: Update API endpoints in `AdelsonConfigHolder.swift`
3. **Select target**: Choose simulator or device (iOS 15+)
4. **Build & run**: `⌘R` to launch

### Running Tests

```bash
xcodebuild test -scheme "my roadmap"
```

Or in Xcode: `⌘U`.

---

## Key Implementation Highlights

### 1. State Machine for Task Lifecycle

Rather than flat booleans, tasks use state protocols with type-safe transitions:

```swift
var currentState: TaskBookState = BookNotStarted(totalPages: 312)

currentState.markProgress(45)  // Type-safe! No invalid states possible

if currentState.currentPage >= currentState.totalPages {
    currentState = currentState.transition()  // → BookCompleted
}
```

Eliminates entire categories of bugs.

### 2. Prerequisite Validation

Tasks maintain a DAG of dependencies:

```swift
protocol GenericTask {
    var prerequisites: [GenericTask] { get }
}

let availableTasks = roadmap.tasks.filter { task in
    task.prerequisites.allSatisfy { $0.state is Completed }
}
```

### 3. Multi-Type Sheet Routing

Tap a task to open state-specific sheet:

```swift
.sheet(item: $selectedTask) { task in
    switch (task, task.state) {
    case let (_, book as BookInProgress):
        BookInProgressView(task: book)
    case let (_, article as ArticleNotStarted):
        ArticleNotStartedView(task: article)
    // ... more cases
    }
}
```

### 4. Drag-and-Drop Task Builder

Interactive roadmap creation with reorderable task list:

```swift
List {
    ForEach($tasks) { $task in
        TaskEditorView(task: $task)
    }
    .onMove { indexSet, offset in
        tasks.move(fromOffsets: indexSet, toOffset: offset)
    }
}
```

### 5. Widget Data Sharing via AppGroups

Current task exported to widget:

```swift
let roadmap = DefaultRoadmapReader().read()
let (name, progress) = roadmap.getCurrentTask()
CurrentTaskDataManager.shared.saveTask(name: name, completion: progress)
WidgetCenter.shared.reloadAllTimelines()
```

---

## Performance & Scalability

- **Large roadmaps** (100+ tasks): JSON deserialization in <500ms
- **Canvas rendering**: Efficient tree layout prevents UI stutter
- **Memory**: Value types (structs) for fast copying, no reference cycles
- **Network**: Requests batched, tokens cached in Keychain

**Tested on**:
- iPhone 12 (iOS 15)
- iPhone 15 Pro (iOS 18)
- All standard simulators (iOS 15 - 18)

---

## What's Next?

- 🔄 **Cloud Sync**: Conflict resolution for multi-device editing
- 🤖 **AI Suggestions**: Recommend learning paths based on goals
- 📊 **Analytics Dashboard**: Track learning velocity & time per task
- 🌐 **Community Roadmaps**: Browse & fork public learning paths
- 📱 **macOS App**: Extend to Mac via Catalyst / native SwiftUI

---

## Code Quality & Testing

- **Unit tests**: Task state transitions, serialization, auth flow
- **Manual testing**: All user flows verified on iOS 15+ simulators
- **Code organization**: Logical module structure, single responsibility
- **Developer documentation**: See [CLAUDE.md](CLAUDE.md) for detailed technical guide

---

## Development Notes

Detailed developer documentation available in [CLAUDE.md](CLAUDE.md):
- Architecture deep-dive
- Common editing tasks  
- Debugging tips
- Known quirks & TODOs

---

## Author

**Ahmed Adel** — iOS Developer  
Building tools for structured learning.

---

<div align="center">

**Interested in the work?** Feel free to reach out: [abooufm709@gmail.com](mailto:abooufm709@gmail.com)

⭐ If you found this helpful, consider starring the repo!

</div>
