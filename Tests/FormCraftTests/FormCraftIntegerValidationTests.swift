import Testing
@testable import FormCraft

struct FormCraftIntegerValidationTests {
    @Test
    func testGtSucceedsForTrue() async {
        let VAL = 10
        let validation = FormCraftIntegerValidation().gt(num: 5)
        let response = await validation.validate(value: VAL)
        // Should be .success(true)
        #expect({ if case .success(let v) = response { return v == VAL } else { return false } }())
    }

    @Test
    func testGtFailsForFalse() async {
        let ERR_MSG = "Should be greater than 5"
        let validation = FormCraftIntegerValidation().gt(num: 5, message: ERR_MSG)
        let response = await validation.validate(value: 2)
        // Should be .error("Required")
        #expect({ if case .error(let msg) = response { return msg == ERR_MSG } else { return false } }())
    }
}
