import Testing
@testable import FormCraft

@Test func exampleBoolTest() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let validation = FormCraftBooleanValidation()

    // true → should pass
    #expect(validation.validate(value: true), because: "По умолчанию значение true должно считаться валидным")
    // false → should fails
    #expect(!validation.validate(value: false), because: "false не равняется ожидаемому true")
}
