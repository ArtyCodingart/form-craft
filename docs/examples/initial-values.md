# Initial values

```swift
import SwiftUI
import FormCraft

private struct PlayerService {
    struct PlayerDTO {
        let firstName: String
        let lastName: String
    }

    func fetchPlayer() async -> PlayerDTO {
        try? await Task.sleep(nanoseconds: 3_000_000_000)

        return .init(firstName: "First name", lastName: "Last name")
    }

    func updatePlayer(player: PlayerDTO) async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
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

struct InitialValuesFormView: View {
    @StateObject private var form = FormCraft(fields: FormFields())
    private let playerService = PlayerService()

    private func updatePlayer(fields: FormCraftValidatedFields<FormFields>) async {
        await playerService.updatePlayer(player: .init(
            firstName: fields.firstName,
            lastName: fields.lastName
        ))
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
                ) { value, field in
                    TextField("First name", text: value)
                        .textFieldStyle(.roundedBorder)
                    Text(field.errors.first ?? "")
                        .foregroundStyle(.red)
                }

                FormCraftControllerView(
                    formConfig: form,
                    key: \.lastName
                ) { value, field in
                    TextField("Last name", text: value)
                        .textFieldStyle(.roundedBorder)
                    Text(field.errors.first ?? "")
                        .foregroundStyle(.red)
                }
            }

            Button("Update", action: form.handleSubmit(onSuccess: updatePlayer))
                .disabled(form.formState.isSubmitting)
        }
        .task(onTask)
    }
}
```
