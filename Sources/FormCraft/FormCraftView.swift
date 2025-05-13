import SwiftUI

public struct FormCraftView<
    FormConfig: FormCraftConfig,
    Content: View
>: View {
    @ObservedObject var formConfig: FormConfig
    @ViewBuilder var content: Content

    public init(
        formConfig: FormConfig,
        @ViewBuilder content: () -> Content
    ) {
        self.formConfig = formConfig
        self.content = content()
    }

    private var isFocused: Bool {
        return !formConfig.focusedFields.isEmpty
    }
    private var isFirst: Bool {
        guard let first = formConfig.registeredFields.first else { return false }

        return formConfig.focusedFields.contains(first)
    }
    private var isLast: Bool {
        guard let last = formConfig.registeredFields.last else { return false }

        return formConfig.focusedFields.contains(last)
    }

    private func DownFocus() {
        if isLast {
            return
        }
        let currentIndex = formConfig.registeredFields.firstIndex(where: { formConfig.focusedFields.contains($0) })

        guard let currentIndex = currentIndex else { return }

        let downIndex = formConfig.registeredFields.index(after: currentIndex)

        formConfig.focusedFields.append(formConfig.registeredFields[downIndex])
    }
    private func upFocus() {
        if isFirst {
            return
        }
        let currentIndex = formConfig.registeredFields.firstIndex(where: { formConfig.focusedFields.contains($0) })

        guard let currentIndex = currentIndex else { return }

        let upIndex = formConfig.registeredFields.index(before: currentIndex)

        formConfig.focusedFields.append(formConfig.registeredFields[upIndex])
    }

    public var body: some View {
        content

//        EmptyView()
//            .toolbar {
//                if isFocused {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        HStack(spacing: 2) {
//                            Button(action: upFocus) {
//                                Image(systemName: "chevron.up")
//                            }
//                            .disabled(isFirst)
//                            Button(action: DownFocus) {
//                                Image(systemName: "chevron.down")
//                            }
//                            .disabled(isLast)
//                        }
//                        Spacer()
//                    }
//                }
//            }
    }
}
