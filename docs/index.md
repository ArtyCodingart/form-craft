---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Form Craft"
  tagline: "Build better forms with a simple and flexible validation library for Swift and SwiftUI"
  actions:
    - theme: brand
      text: Getting Started
      link: /guide/getting-started
    - theme: alt
      text: GitHub
      link: https://github.com/ArtyCodingart/form-craft
  image:
    src: /form-craft-start-logo.png
    alt: FormCraft

features:
  - icon: 🧱
    title: Build smart forms. Faster.
    details: Stop fighting with @State, @Binding, and manual checks. Declare your fields once — get validation, debounced updates, async support, and type-safe output instantly. → No boilerplate. Just clean SwiftUI.
  - icon: ⚡️
    title: Validate everything. Instantly.
    details: Async checks? No problem. Everything runs off the main thread — powered by Task, MainActor, and Sendable safety. → Your UI stays smooth. Always.
  - icon: 🔍
    title: Chain validation rules with compiler protection.
    details: .string().required().min(2) — fully type-safe with output you can trust. → If it compiles, it’s safe.
  - icon: 🏗️
    title: From login screens to enterprise-grade forms.
    details: FormCraft scales with you — with full support for deeply nested fields, conditional logic, and async cross-validation. → Perfect for apps that grow fast. Or already are.
---
