import Foundation

struct QuestionsDataLoader {
    static func loadQuestions(for book: BibleBook) -> [Question] {
        let filenameBase = book.rawValue.replacingOccurrences(of: " ", with: "_").lowercased()
        print("Filename base: \(filenameBase)")
        let filename = filenameBase + ".json"
        print("Loading questions from file: \(filename)")
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Could not again find file: \(filename)")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            // Debug: Print a sample of the JSON data
            print("JSON sample: \(String(data: data.prefix(200), encoding: .utf8) ?? "Unable to show sample")")

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let questions = try decoder.decode([QuestionJSON].self, from: data)
            print("Number of questions loaded for \(book.rawValue): \(questions.count)")

            // Debug: Print first question details
            if let firstQuestion = questions.first {
                print("First question - text: \(firstQuestion.text)")
                print("First question - book: \(firstQuestion.book)")
                print("First question - difficulty: \(firstQuestion.difficulty)")
            }
            // Debug: Count successful conversions
            var converted = 0
            var failed = 0
            let result = questions.compactMap { question -> Question? in
                if let q = question.toQuestion() {
                    converted += 1
                    return q
                } else {
                    failed += 1
                    print("❌ Failed to convert question: book=\(question.book), difficulty=\(question.difficulty)")
                    return nil
                }
            }

            print("Conversion results: \(converted) succeeded, \(failed) failed")
            return result
        } catch {
            print("Error loading questions for \(book): \(error)")
            return []
        }
    }
}

// Helper struct for decoding JSON (since Question has non-JSON fields like UUID and enums)
private struct QuestionJSON: Decodable {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let book: String
    let difficulty: String
    let verseReference: String
    let verseText: String
    
    func toQuestion() -> Question? {
        guard let bookEnum = BibleBook(rawValue: book),
              let difficultyEnum = Difficulty(rawValue: difficulty) else { return nil }
        return Question(
            text: text,
            options: options,
            correctAnswerIndex: correctAnswerIndex,
            book: bookEnum,
            difficulty: difficultyEnum,
            verseReference: verseReference,
            verseText: verseText,
            isAnsweredCorrectly: nil
        )
    }
}
