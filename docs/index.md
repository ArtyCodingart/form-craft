---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Form Craft"
  tagline: "Build better forms with a simple and flexible validation library for SwiftUI"
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
    details: Stop fighting with manual checks. Declare your fields once — get validation, debounced updates, async support, and type-safe output instantly. No boilerplate. Just clean SwiftUI.
  - icon: ⚡️
    title: Validate everything. Instantly.
    details: Async checks? No problem. Everything runs off the main thread and Sendable safety. Your UI stays smooth. Always.
  - icon: 📦
    title: A rich set of built-in rules.
    details: FormCraft comes with a wide selection of ready-to-use validation rules — all chainable, clear, and type-safe. Define logic like .string().required().min(2) and get back a fully validated, correctly typed value.
  - icon: 🏗️
    title: Flexible by design.
    details: Create anything from simple forms to complex validation flows. FormCraft supports custom validation rules, full i18n for multilingual apps, and works seamlessly with any custom SwiftUI components.
---
