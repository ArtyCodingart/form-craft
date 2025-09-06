import Testing
@testable import FormCraft

struct FormCraftIntegerValidationTests {
    @Test
    func testGtValidation() async {
        let validation = FormCraftIntegerValidation().gt(num: 5, message: "ERR")

        let cases: [(Int, FormCraftValidationResponse<Int>)] = [
            (10, .success(value: 10)),
            (6,  .success(value: 6)),
            (5,  .error(message: "ERR")),
            (2,  .error(message: "ERR")),
        ]

        for (input, expected) in cases {
            let response = await validation.validate(value: input)
            #expect(response == expected)
        }
    }
}
