//
//  Question.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    
    var isAnsweredCorrectly: Bool?
}

struct QuestionBank {
    static let sampleQuestions = [


        Question(
            text: "Who led the Israelites out of Egypt?",
            options: ["Aaron", "Joshua", "Moses", "Joseph"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What river was Moses placed into as a baby?",
            options: ["Jordan", "Tigris", "Nile", "Euphrates"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What was Moses' brother's name?",
            options: ["Joshua", "Caleb", "Aaron", "Samuel"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "Which plague was the last one God sent upon Egypt?",
            options: ["Darkness", "Locusts", "Death of the firstborn", "Frogs"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What did Moses encounter on Mount Horeb?",
            options: ["An angel", "A burning bush", "A well", "An earthquake"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "Who found Moses in the river Nile?",
            options: ["Pharaoh's daughter", "Pharaoh", "A slave", "A priest"],
            correctAnswerIndex: 0
        ),
        Question(
            text: "What did the Israelites cross to escape Pharaoh's army?",
            options: ["Jordan River", "Dead Sea", "Red Sea", "Mediterranean Sea"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "How many commandments were given to Moses by God on Mount Sinai?",
            options: ["7", "10", "12", "15"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What did the Israelites make while Moses was on Mount Sinai?",
            options: ["A bronze serpent", "A golden calf", "A silver altar", "A wooden ark"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "Who helped Moses hold up his hands during the battle against Amalek?",
            options: ["Joshua and Caleb", "Aaron and Hur", "Gershom and Eleazar", "Nadab and Abihu"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What food did God provide for the Israelites in the wilderness?",
            options: ["Bread", "Fish", "Manna", "Fruit"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What was Moses' occupation while in Midian?",
            options: ["Carpenter", "Shepherd", "Fisherman", "Soldier"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What did Moses throw into the water to make it sweet at Marah?",
            options: ["Salt", "A stick", "Sand", "A stone"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What bird did God send the Israelites to eat in the wilderness?",
            options: ["Doves", "Eagles", "Quail", "Ravens"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What relation was Aaron to Moses?",
            options: ["Cousin", "Father", "Brother", "Uncle"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What was Moses' wife's name?",
            options: ["Miriam", "Zipporah", "Rachel", "Leah"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What was Moses' father-in-law's name?",
            options: ["Jethro", "Laban", "Reuel", "Hobab"],
            correctAnswerIndex: 0
        ),
        Question(
            text: "How old was Moses when he spoke to Pharaoh?",
            options: ["60", "70", "80", "90"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What happened to the water in Egypt during one of the plagues?",
            options: ["It boiled", "It turned to blood", "It froze", "It disappeared"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What did the Israelites put on their doorposts during Passover?",
            options: ["Olive oil", "Water", "Blood", "Mud"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What was Aaron's role in the Exodus?",
            options: ["General", "Doctor", "Spokesman", "Judge"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What mountain did Moses receive the Ten Commandments on?",
            options: ["Mount Carmel", "Mount Nebo", "Mount Sinai", "Mount Zion"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What did God provide to guide the Israelites during the day?",
            options: ["A star", "A pillar of cloud", "An eagle", "An angel"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What did God provide to guide the Israelites at night?",
            options: ["A pillar of fire", "The moon", "Stars", "A glowing stone"],
            correctAnswerIndex: 0
        ),
        Question(
            text: "How many days did Moses stay on Mount Sinai receiving the law?",
            options: ["10", "30", "40", "50"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What was Moses' sister's name?",
            options: ["Rachel", "Leah", "Hannah", "Miriam"],
            correctAnswerIndex: 3
        ),
        Question(
            text: "What did Moses' staff turn into before Pharaoh?",
            options: ["A sword", "A snake", "A lion", "A fish"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "Who was Moses' mother?",
            options: ["Jochebed", "Puah", "Shiphrah", "Zipporah"],
            correctAnswerIndex: 0
        ),
        Question(
            text: "What was the first plague God sent on Egypt?",
            options: ["Frogs", "Locusts", "Blood", "Flies"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "What was inside the Ark of the Covenant?",
            options: ["Gold and silver", "Food", "The Ten Commandments", "Sacred oil"],
            correctAnswerIndex: 2
        ),
    ]
}
