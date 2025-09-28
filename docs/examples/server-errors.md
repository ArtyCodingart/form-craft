# Server Errors

```swift
import SwiftUI
import FormCraft

private struct ServerError: LocalizedError {
    let code: Int
    let errors: [String: String]

    var errorDescription: String? { "Server error \(code)" }
}

private struct PlayerRepository {
    struct PlayerDTO {
        let firstName: String
        let lastName: String
    }

    func fetchPlayer() async -> PlayerDTO {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return .init(firstName: "First name", lastName: "Last name")
    }

    func updatePlayer(player: PlayerDTO) async -> Result<PlayerDTO, ServerError> {
        try? await Task.sleep(nanoseconds: 3_000_000_000)

        if player.firstName.count > 4 {
            return .failure(
                .init(
                    code: 400,
                    errors: ["firstName": "First name must be 4 characters or fewer."]
                )
            )
        }

        return .success(player)
    }
}

private struct FormFields: FormCraftFields {
    var firstName = FormCraftField(name: "firstName", value: "") { value in
        await FormCraftValidationRules()
            .string()
            .notEmpty()
            .validate(value: value)
    }

    var lastName = FormCraftField(name: "lastName", value: "") { value in
        await FormCraftValidationRules()
            .string()
            .notEmpty()
            .validate(value: value)
    }
}

struct ServerErrorsFormView: View {
    @StateObject private var form = FormCraft(fields: FormFields())
    private let playerService = PlayerRepository()

    private func handleSubmit(fields: FormCraftValidatedFields<FormFields>) async {
        let response = await playerService.updatePlayer(player: .init(
            firstName: fields.firstName,
            lastName: fields.lastName
        ))

        switch response {
        case .success:
            print("Profile updated.")
        case .failure(let serverError):
            form.setErrors(errors: serverError.errors)
        }
    }

    func onTask() async {
        let data = await playerService.fetchPlayer()
        form.setValues(values: [
            \.firstName: data.firstName,
            \.lastName: data.lastName
        ])
    }

    var body: some View {
        VStack {
            FormCraftView(formConfig: form) {
                FormCraftControllerView(
                    formConfig: form,
                    key: \.firstName
                ) { field in
                    TextField("First name", text: field.$value)
                        .textFieldStyle(.roundedBorder)
                    Text(field.error)
                        .foregroundStyle(.red)
                }

                FormCraftControllerView(
                    formConfig: form,
                    key: \.lastName
                ) { field in
                    TextField("Last name", text: field.$value)
                        .textFieldStyle(.roundedBorder)
                    Text(field.error)
                        .foregroundStyle(.red)
                }
            }

            Button("Save", action: form.handleSubmit(onSuccess: handleSubmit))
                .disabled(form.formState.isSubmitting)
        }
        .task { await onTask() }
    }
}
```