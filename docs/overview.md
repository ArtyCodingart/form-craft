# Overview

FormCraft is a powerful form validation toolkit built for SwiftUI — inspired by Zod and React Hook Form, but tailored for the Swift ecosystem.

Whether you're building a simple login screen or a complex enterprise-grade form with async rules, FormCraft provides the structure, type safety, and control you've been missing in native SwiftUI.

## 🚀 Why FormCraft?

SwiftUI is modern — but writing forms in it is still a mess:

- Too much `@State` and `@Binding` juggling
- Manual validation logic scattered everywhere
- No built-in support for async validation
- Error-prone and hard to test

FormCraft solves that — cleanly, declaratively, and with **zero boilerplate**.

## 🧠 Key Features

- **🧱 Minimal API, maximal control**  
  Define your fields and rules — FormCraft takes care of registration, state, and validation.

- **⚡️ Parallel async validation**  
  Each field validates concurrently using `Task`, without blocking the main thread.

- **🔒 Type-safe validation rules**  
  Chain `.string().required().min(2)` and let the compiler ensure correctness.

- **🧠 Modular logic**  
  Use field-level rules or `refine()` to validate across multiple fields.

- **🔁 Built-in debounced validation**  
  No need to manage timers — FormCraft prevents over-validation out of the box.

- **🌍 Multi-platform**  
  Works great on iOS, macOS, and visionOS.

## 💡 How it works

FormCraft uses an internal form controller under the hood that automatically tracks field registration, validation tasks, and current error states.

Each field connects to the form through context (`EnvironmentObject`) and can trigger or listen to validations without manual wiring.

On submit, FormCraft provides you with already validated and transformed data — ready to be used or sent to a server.

---
