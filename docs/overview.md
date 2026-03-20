# Overview

FormCraft helps you build SwiftUI forms with reliable validation, clear submit handling, and predictable behavior.

It provides one unified model for:
- field-level validation
- cross-field validation via `refine(form:)`
- async validation flows
- typed validated data on submit and more

## Why FormCraft

As forms grow, validation logic often gets scattered across views, and submit handlers start receiving raw input.
FormCraft keeps validation and submit flow in one place.

## Core Building Blocks

- `@FormCraft + FormCraftFields`
You define a fields container and automatically get field mapping/order used by the form engine.
- `FormCraftField<Value, ValidatedValue>`
Stores a raw value, field state, and an async validation rule.
- `FormCraft<Fields>`
Runs validation, tracks focus/submitting state, and handles submit.
- `FormCraftControllerView`
Binds SwiftUI controls to a field value and triggers field-level validation.
- `FormCraftValidationRules`
Provides chainable validators for `string`, `integer`, `decimal`, `boolean`, and custom types.

## Key Capabilities

- Type-safe validated output through `FormCraftValidatedFields`.
- Field-level and form-level (`refine`) validation in a single pipeline.
- Async validation by default.
- Configurable field validation delay via `FormCraftDelayValidation`.
- Localization-friendly errors via `LocalizedStringResource` and `FormCraftLocalizations`.

## How Data Flows

1. Define fields and rules in a `@FormCraft` `FormCraftFields` struct.
2. Create `FormCraft(fields:)`.
3. Bind inputs via `FormCraftControllerView`.
4. Field validation runs when values change.
5. On submit, `handleSubmit` validates all fields and, if data is valid, calls `onSuccess` with the typed validated values defined by your validation rules.

---
