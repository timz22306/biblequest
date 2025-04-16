import Foundation

struct QuestionsDataLoader {
    static func loadQuestions(for book: BibleBook) -> [Question] {
        let filename = book.rawValue.lowercased() + ".json"
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Could not find file: \(filename)")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let questions = try decoder.decode([QuestionJSON].self, from: data)
            return questions.compactMap { $0.toQuestion() }
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
