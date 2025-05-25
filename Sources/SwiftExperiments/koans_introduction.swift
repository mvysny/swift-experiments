// https://play.kotlinlang.org/koans/Introduction/Hello,%20world!/Task.kt

// koan1
func start() -> String {
    "OK"
}

// koan2
func joinOptions(options: any Collection<String>) -> String {
    "[" + options.joined(separator: ", ") + "]"
}

// koan3
func foo(_ name: String, number: Int = 42, toUpperCase: Bool = false) -> String {
    (toUpperCase ? name.uppercased() : name) + String(number)
}
func useFoo() -> [String] {
    [foo("a"), foo("b", number: 1), foo("c", toUpperCase: true), foo("d", number: 2, toUpperCase: true)]
}

// koan4
let question = "life, the universe and everything"
let answer = 42
let tripleQuotedString = """
question = "\(question)"
answer = \(answer)
"""

// koan5
let month = "(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)"
func getPattern() -> Regex<(Substring, Substring)> {
    try! Regex("\\d{2} \(month) \\d{4}")
}

// koan6

func sendMessageToClient(client: Client?, message: String?, mailer: Mailer) {
    guard let email = client?.personalInfo?.email else { return }
    guard let message else { return }
    mailer.sendMessage(email: email, message: message)
}

struct PersonalInfo {
    let email: String?
}
struct Client {
    let personalInfo: PersonalInfo?
}
protocol Mailer {
    func sendMessage(email: String, message: String)
}
class DummyMailer : Mailer {
    var messages: [String] = []
    func sendMessage(email: String, message: String) {
        messages.append("From \(email): \(message)")
    }
}

// koan7
func failWithWrongAge(_ age: Int?) -> Never {
    fatalError("Wrong age: \(age ?? 0)")
}
func checkAge(_ age: Int?) {
    guard let age else { failWithWrongAge(age) }
    if (!(0...150).contains(age)) {
        failWithWrongAge(age)
    }
    print("Congrats! Next year you'll be \(age + 1) years old!")
}

// Koan: Lambdas
func containsEven(_ collection: any Collection<Int>) -> Bool {
    collection.contains(where: { $0 % 2 == 0})
}
