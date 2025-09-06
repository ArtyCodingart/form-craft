import Testing
@testable import FormCraft

struct TestCase<Value: Sendable & Equatable>: Sendable {
    let name: String
    let num: Value
    let input: Value
    let expected: FormCraftValidationResponse<Value>
}

struct FormCraftIntegerValidationTests {
    @Test
    func testGtValidation() async {
        let ERR_MSG = "ERR"
        let cases: [TestCase<Int>] = [
            TestCase(name: "27 > 9", num: 9,  input: 27, expected: .success(value: 27)),
            TestCase(name: "8 > 2",  num: 2,  input: 8,  expected: .success(value: 8)),
            TestCase(name: "5 == 5", num: 5,  input: 5,  expected: .error(message: ERR_MSG)),
            TestCase(name: "3 < 7",  num: 7,  input: 3,  expected: .error(message: ERR_MSG)),
            TestCase(name: "0 < 42", num: 42, input: 0,  expected: .error(message: ERR_MSG)),
        ]

        for test in cases {
            let validation = FormCraftIntegerValidation().gt(num: test.num, message: ERR_MSG)
            let actual = await validation.validate(value: test.input)
            #expect(
                actual == test.expected,
                "\(test.name): input=\(test.input), num=\(test.num) — got \(actual), expected \(test.expected)"
            )
        }
    }
}
