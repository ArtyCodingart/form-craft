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

@FormCraft
private struct FormFields: FormCraftFields {
    var firstName = FormCraftField(value: "") { value in
        await FormCraftValidationRules()
            .string()
            .notEmpty()
            .validate(value: value)
    }

    var lastName = FormCraftField(value: "") { value in
        await FormCraftValidationRules()
            .string()
            .notEmpty()
            .validate(value: value)
    }
}

struct InitialValuesFormView: View {
    @State private var form = FormCraft(fields: FormFields())
    private let playerService = PlayerService()

    private func updatePlayer(data: FormCraftValidatedFields<FormFields>) async {
        await playerService.updatePlayer(
            player: .init(
                firstName: data.firstName,
                lastName: data.lastName
            )
        )
    }

    func onTask() async {
        let data = await playerService.fetchPlayer()

        form.setDefaultValues(
            (\.firstName, data.firstName),
            (\.lastName, data.lastName)
        )
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

                    if let firstError = field.errors?.messages.first {
                        Text(firstError)
                            .foregroundStyle(.red)
                    }
                }

                FormCraftControllerView(
                    formConfig: form,
                    key: \.lastName
                ) { value, field in
                    TextField("Last name", text: value)
                        .textFieldStyle(.roundedBorder)

                    if let firstError = field.errors?.messages.first {
                        Text(firstError)
                            .foregroundStyle(.red)
                    }
                }
            }

            Button("Update", action: form.handleSubmit(onSuccess: updatePlayer))
                .disabled(form.formState.isSubmitting)
        }
        .task { await onTask() }
    }
}
```
