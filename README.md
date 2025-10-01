# Summary
A personalized learning management system that enables users to create structured roadmaps with diverse content types and enforces sequential progress tracking to maintain motivation and accountability.

* Diverse Learning Paths: Create roadmaps combining books, articles, YouTube playlists, goals, and branching paths for comprehensive skill development
* Sequential Learning Flow: Enforces prerequisite completion before advancing, ensuring solid foundation building and preventing knowledge gaps
* Granular Progress Tracking: Monitor detailed progress (pages read, videos watched) with status indicators that maintain motivation and accountability


# Authentication & API Management
Built on three custom libraries for seamless auth handling:

* [AdelsonAuthManager](https://github.com/Ahmed23Adel/AdelsonAuthManager) - Handles signup, login, and token refresh with secure keychain storage  
* [AdelsonApiCaller](https://github.com/Ahmed23Adel/AdelsonApiCaller) - Automatically attaches tokens to requests, refreshes expired tokens, and re-authenticates when needed  
* [AdelsonValidator](https://github.com/Ahmed23Adel/AdelsonValidator) - Client-side validation for email format and password policies (easy/medium/hard), and any custom validation  

How It Works

1. Validate input with AdelsonValidator
2. Send request via AdelsonApiCaller
3. Handle auth automatically with AdelsonAuthManager

Screenshots: 

<div style="display: flex; gap: 20px;">
  <img src="https://github.com/user-attachments/assets/53753ffc-ad80-44a9-b1a4-36cf54524995" width="300" />
  <img src="https://github.com/user-attachments/assets/2e602fdc-a843-42fb-85f4-458a2400c2d4" width="300" />
</div>


# Create a new Roadmap

Create personalized learning paths with diverse content types:
Learning Elements

* 📚 Books - Add book references to your roadmap
* 📄 Articles - Include relevant articles and tutorials
* 🎥 YouTube Playlists - Embed video content for visual learning
* 🎯 Goals - Set milestones and objectives
* 🔀 Branches - Create parallel learning paths for comprehensive understanding


<img src="https://github.com/user-attachments/assets/fdb120c5-f60d-4208-8e1a-4b456a5caf51" width="250" />
<img src="https://github.com/user-attachments/assets/4948d04c-b046-46cc-bd2f-df6245c53c45" width="250" />
<img src="https://github.com/user-attachments/assets/89633d85-145d-422f-9472-0d5dfec5cf18" width="250" />
<img src="https://github.com/user-attachments/assets/440495f9-7ef2-4128-b09f-1f2877eba7ae" width="250" />
<img src="https://github.com/user-attachments/assets/93a0e1a7-bdb4-4c02-9dc6-5cdf708506a9" width="250" />


# 📊 Progress Tracking & Task Management

Easily monitor your learning journey with **detailed progress tracking** and **task management tools**.  

### ✅ Task Status Types
* 🔴 **Not Started** – Tasks waiting for prerequisites to be completed  
* 🟠 **In Progress** – Currently active tasks with deadlines  
* 🟢 **Completed** – Finished tasks with a completion summary  

### 🔑 Key Features
1. 🚦 Users can’t start a task until **previous tasks are completed** (sequential learning flow).  
2. 📈 Users can **update their progress** (e.g., mark videos watched in a YouTube playlist, or pages read in a book).  
3. 📝 Detailed task tracking helps maintain **motivation and accountability**.  

---

### 📸 Screenshots

<img src="https://github.com/user-attachments/assets/ce772d68-587c-49c7-b398-bfe42dd493bc" width="250" />
<img src="https://github.com/user-attachments/assets/67786717-f6c8-4847-b6f6-32a54ba7ec45" width="250" />
<img src="https://github.com/user-attachments/assets/1ad73195-6a34-43ee-963c-fcd59088d547" width="250" />
<img src="https://github.com/user-attachments/assets/7e6b54bb-7e76-454b-b971-cb8b369bea22" width="250" />


# Widgets
Created a widget to show the current task that is being worked on, in addition to the percentage of completion

<img width="225" height="228" alt="Screenshot 2025-10-01 at 4 46 52 PM" src="https://github.com/user-attachments/assets/d0619d1d-bef9-4542-a03c-152be9d3aac4" />


# ⚙️ Technologies Used

This project is built with a modern stack that ensures **scalability, security, and a smooth user experience**:

- **Swift (iOS)** – Core language for building the app, leveraging UIKit and SwiftUI where appropriate  
- **Xcode** – Primary IDE for development, debugging, and testing  
- **Combine** – Reactive framework for handling asynchronous events and data streams  
- **FileManager** – Local file storage for roadmap files
- **Keychain Services** – Secure storage of authentication tokens and sensitive user data  

### 🔒 Custom Libraries
- [AdelsonAuthManager](https://github.com/Ahmed23Adel/AdelsonAuthManager) – Authentication and token management  
- [AdelsonApiCaller](https://github.com/Ahmed23Adel/AdelsonApiCaller) – API communication with auto token refresh  
- [AdelsonValidator](https://github.com/Ahmed23Adel/AdelsonValidator) – Input validation for forms and credentials  

### 🌐 Networking & Data
- **RESTful APIs** – Communication with backend services for authentication, progress updates, and roadmap data  
- **JSON** – Data serialization between client and server  

### 🧪 Testing & Collaboration
- **Unit Testing** – Core libraries (AuthManager, ApiCaller, Validator) tested for reliability and correctness  
- **Git & GitHub** – Version control



  
