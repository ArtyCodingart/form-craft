# String

- `min(num: Int, message: String = "Must be %@ or more characters long")`
- `max(num: Int, message: String = "Must be %@ or fewer characters long")`
- `length(num: Int, message: String = "Must be exactly %@ characters long")`
- `notEmpty(message: String = "Must not be empty")`
- `emoji(message: String = "Contains non-emoji characters")`
- `url(message: String = "Value must be a valid URL")`
- `nanoid(message: String = "Value must be a valid NanoID")`
- `cuid(message: String = "Value must be a valid CUID")`
- `cuid2(message: String = "Value must be a valid CUID2")`
- `ulid(message: String = "Value must be a valid ULID")`
- `regex(pattern: Regex, message: String = "Invalid format")`
- `includes(string: String, message: String = "Value must include %@")`
- `startsWith(string: String, message: String = "Value must start with %@")`
- `endsWith(string: String, message: String = "Value must end with %@")`
- `cidr(message: String = "Invalid CIDR format")`
- `equalTo(to: String, message: String = "Values do not match")`

## IP Address
- `ipv4(message: String = "Invalid IP address")`
- `ipv6(message: String = "Invalid IP address")`

## Email
- `email(message: String = "Invalid email address")`

## Transformations
- `trim()` — removes leading and trailing whitespaces
- `toLowerCase()` — transforms string to lowercase
- `toUpperCase()` — transforms string to uppercase

## Datetimes (ISO)
- `datetime(message: String = "Invalid datetime format")`
```swift
let datetime = FormCraftValidationRules()
  .string()
  .datetime() // ISO 8601

datetime.validate(value: "2025-01-01T00:00:00Z") // ✅ is valid
datetime.validate(value: "2025_01_01T00:00:00Z") // ❌ is not valid
```
- `date(message: String = "Invalid date format")`
```swift
let date = FormCraftValidationRules()
  .string()
  .date() // ISO 8601 YYYY-MM-DD

date.validate(value: "2025-01-01") // ✅ is valid
date.validate(value: "2025_01_01") // ❌ is not valid
```
- `time(message: String = "Invalid time format")`
```swift
let time = FormCraftValidationRules()
  .string()
  .time() // ISO 8601 HH:MM:SS[.s+]

time.validate(value: "00:00:00") // ✅ is valid
time.validate(value: "00_00_00") // ❌ is not valid
```
- `duration(message: String = "Invalid duration format")`
```swift
let duration = FormCraftValidationRules()
  .string()
  .duration() // ISO 8601 P(n)Y(n)M(n)DT(n)H(n)M(n)S

datetime.validate(value: "P3Y6M4DT12H30M5S") // ✅ is valid
datetime.validate(value: "H_10_M_2") // ❌ is not valid
```

## UUID
- `uuid(message: String = "Value must be a valid UUID")`
