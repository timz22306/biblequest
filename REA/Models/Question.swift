//
//  Question.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//
import Foundation

enum BibleBook: String, CaseIterable {
    case genesis = "Genesis"
    case exodus = "Exodus"
    case leviticus = "Leviticus"
    case numbers = "Numbers"
    case deuteronomy = "Deuteronomy"
    case joshua = "Joshua"
    case judges = "Judges"
    case ruth = "Ruth"
    case firstSamuel = "1 Samuel"
    case secondSamuel = "2 Samuel"
    case firstKings = "1 Kings"
    case secondKings = "2 Kings"
    case firstChronicles = "1 Chronicles"
    case secondChronicles = "2 Chronicles"
    case ezra = "Ezra"
    case nehemiah = "Nehemiah"
    case esther = "Esther"
    case job = "Job"
    case psalms = "Psalms"
    case proverbs = "Proverbs"  
    case ecclesiastes = "Ecclesiastes"
    case songOfSolomon = "Song of Solomon"
    case isaiah = "Isaiah"
    case jeremiah = "Jeremiah"
    case lamentations = "Lamentations"
    case ezekiel = "Ezekiel"
    case daniel = "Daniel"
    case hosea = "Hosea"
    case joel = "Joel"  
    case amos = "Amos"
    case obadiah = "Obadiah"
    case jonah = "Jonah"
    case micah = "Micah"
    case nahum = "Nahum"
    case habakkuk = "Habakkuk"
    case zephaniah = "Zephaniah"
    case haggai = "Haggai"
    case zechariah = "Zechariah"
    case malachi = "Malachi"
    case matthew = "Matthew"
    case mark = "Mark"
    case luke = "Luke"
    case john = "John"
    case acts = "Acts"
    case romans = "Romans"
    case firstCorinthians = "1 Corinthians"
    case secondCorinthians = "2 Corinthians"
    case galatians = "Galatians"        
    case ephesians = "Ephesians"
    case philippians = "Philippians"
    case colossians = "Colossians"
    case firstThessalonians = "1 Thessalonians"
    case secondThessalonians = "2 Thessalonians"
    case firstTimothy = "1 Timothy"
    case secondTimothy = "2 Timothy"    
    case titus = "Titus"
    case philemon = "Philemon"
    case hebrews = "Hebrews"
    case james = "James"
    case firstPeter = "1 Peter"
    case secondPeter = "2 Peter"
    case firstJohn = "1 John"
    case secondJohn = "2 John"
    case thirdJohn = "3 John"
    case jude = "Jude"
    case revelation = "Revelation"
    
    var abbreviation: String {
        switch self {
        case .genesis: return "Gen"
        case .exodus: return "Exo"
        case .leviticus: return "Lev"
        case .numbers: return "Num"
        case .deuteronomy: return "Deut"
        case .joshua: return "Josh"
        case .judges: return "Judg"
        case .ruth: return "Ruth"
        case .firstSamuel: return "1Sam"
        case .secondSamuel: return "2Sam"
        case .firstKings: return "1Kings"
        case .secondKings: return "2Kings"
        case .firstChronicles: return "1Chr"
        case .secondChronicles: return "2Chr"
        case .ezra: return "Ezra"
        case .nehemiah: return "Neh"
        case .esther: return "Esth"
        case .job: return "Job"
        case .psalms: return "Ps"
        case .proverbs: return "Prov"
        case .ecclesiastes: return "Ecc"
        case .songOfSolomon: return "Song"
        case .isaiah: return "Isa"
        case .jeremiah: return "Jer"
        case .lamentations: return "Lam"
        case .ezekiel: return "Ezek"
        case .daniel: return "Dan"
        case .hosea: return "Hos"
        case .joel: return "Joel"
        case .amos: return "Amos"
        case .obadiah: return "Obad"
        case .jonah: return "Jonah"
        case .micah: return "Mic"
        case .nahum: return "Nah"
        case .habakkuk: return "Hab"
        case .zephaniah: return "Zeph"
        case .haggai: return "Hag"
        case .zechariah: return "Zech"
        case .malachi: return "Mal"
        case .matthew: return "Matt"
        case .mark: return "Mark"
        case .luke: return "Luke"
        case .john: return "John"
        case .acts: return "Acts"
        case .romans: return "Rom"
        case .firstCorinthians: return "1Cor"
        case .secondCorinthians: return "2Cor"
        case .galatians: return "Gal"
        case .ephesians: return "Eph"
        case .philippians: return "Phil"
        case .colossians: return "Col"
        case .firstThessalonians: return "1Thess"
        case .secondThessalonians: return "2Thess"
        case .firstTimothy: return "1Tim"
        case .secondTimothy: return "2Tim"
        case .titus: return "Titus"
        case .philemon: return "Philem"
        case .hebrews: return "Heb"
        case .james: return "James"
        case .firstPeter: return "1Pet"
        case .secondPeter: return "2Pet"
        case .firstJohn: return "1John"
        case .secondJohn: return "2John"
        case .thirdJohn: return "3John"
        case .jude: return "Jude"
        case .revelation: return "Rev"
        }
    }
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium" 
    case hard = "Hard"
}

struct Question: Identifiable {
    let id = UUID()
    let text: String
    var options: [String]
    var correctAnswerIndex: Int
    let book: BibleBook
    let difficulty: Difficulty
    let verseReference: String // Reference like "Exodus 3:10"
    let verseText: String      // The actual ESV Bible verse text
    
    var isAnsweredCorrectly: Bool?
    
    // New method to create a shuffled copy of this question
    func withShuffledOptions() -> Question {
        // Get the correct answer text before shuffling
        let correctAnswer = options[correctAnswerIndex]
        
        // Create a shuffled copy of options
        var shuffledOptions = options
        shuffledOptions.shuffle()
        
        // Find the new index of the correct answer
        let newCorrectIndex = shuffledOptions.firstIndex(of: correctAnswer) ?? correctAnswerIndex
        
        // Create a new question with shuffled options
        var newQuestion = self
        newQuestion.options = shuffledOptions
        newQuestion.correctAnswerIndex = newCorrectIndex
        return newQuestion
    }
}