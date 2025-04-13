//
//  BibleQuestionBank.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import Foundation

struct BibleQuestionBank {
    // All questions in one array
    static let allQuestions: [Question] = exodusQuestions // + other books as you add them
    
    // MARK: - Helper Methods
    
    static func getQuestions(for book: BibleBook? = nil, difficulty: Difficulty? = nil) -> [Question] {
        var filteredQuestions = allQuestions
        
        // Filter by book if specified
        if let book = book {
            filteredQuestions = filteredQuestions.filter { $0.book == book }
        }
        
        // Filter by difficulty if specified
        if let difficulty = difficulty {
            filteredQuestions = filteredQuestions.filter { $0.difficulty == difficulty }
        }
        
        return filteredQuestions
    }
    
    static func getBookList() -> [BibleBook] {
        // Return unique books that have questions
        let books = Set(allQuestions.map { $0.book })
        return Array(books).sorted { $0.rawValue < $1.rawValue }
    }
    
    // MARK: - Exodus Questions
    
    static let exodusQuestions: [Question] = [
        // EASY QUESTIONS
        Question(
            text: "Who led the Israelites out of Egypt?",
            options: ["Aaron", "Joshua", "Moses", "Joseph"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 3:10",
            verseText: "Come, I will send you to Pharaoh that you may bring my people, the children of Israel, out of Egypt. (ESV)"
        ),
        Question(
            text: "What river was Moses placed into as a baby?",
            options: ["Jordan", "Tigris", "Nile", "Euphrates"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 2:3",
            verseText: "When she could hide him no longer, she took for him a basket made of bulrushes and daubed it with bitumen and pitch. She put the child in it and placed it among the reeds by the river bank. (ESV)"
        ),
        Question(
            text: "What was Moses' brother's name?",
            options: ["Joshua", "Caleb", "Aaron", "Samuel"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 4:14",
            verseText: "Then the anger of the LORD was kindled against Moses and he said, \"Is there not Aaron, your brother, the Levite? I know that he can speak well.\" (ESV)"
        ),
        Question(
            text: "How many plagues did God send upon Egypt?",
            options: ["7", "10", "12", "3"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 7-12",
            verseText: "The LORD sent ten plagues upon Egypt: blood, frogs, gnats, flies, livestock, boils, hail, locusts, darkness, and death of the firstborn. (ESV)"
        ),
        Question(
            text: "What was the first plague God sent on Egypt?",
            options: ["Frogs", "Darkness", "Blood", "Locusts"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 7:20",
            verseText: "Moses and Aaron did as the LORD commanded. In the sight of Pharaoh and in the sight of his servants he lifted up the staff and struck the water in the Nile, and all the water in the Nile turned into blood. (ESV)"
        ),
        Question(
            text: "How many commandments did God give to Moses?",
            options: ["5", "7", "10", "12"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 20:1-17",
            verseText: "And God spoke all these words... [The Ten Commandments were given in this passage] (ESV)"
        ),
        Question(
            text: "What did Moses' staff turn into before Pharaoh?",
            options: ["Snake", "Bird", "Fire", "Water"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 7:10",
            verseText: "So Moses and Aaron went to Pharaoh and did just as the LORD commanded. Aaron cast down his staff before Pharaoh and his servants, and it became a serpent. (ESV)"
        ),
        Question(
            text: "What body of water did the Israelites cross when leaving Egypt?",
            options: ["Jordan River", "Mediterranean Sea", "Red Sea", "Dead Sea"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 14:21-22",
            verseText: "Then Moses stretched out his hand over the sea, and the LORD drove the sea back by a strong east wind all night and made the sea dry land, and the waters were divided. And the people of Israel went into the midst of the sea on dry ground, the waters being a wall to them on their right hand and on their left. (ESV)"
        ),
        Question(
            text: "What did God provide for the Israelites to eat in the wilderness?",
            options: ["Manna", "Fish", "Vegetables", "Bread"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 16:14-15",
            verseText: "And when the dew had gone up, there was on the face of the wilderness a fine, flake-like thing, fine as frost on the ground. When the people of Israel saw it, they said to one another, \"What is it?\" For they did not know what it was. And Moses said to them, \"It is the bread that the LORD has given you to eat.\" (ESV)"
        ),
        Question(
            text: "What mountain did Moses receive the Ten Commandments on?",
            options: ["Mount Carmel", "Mount Sinai", "Mount Nebo", "Mount Hermon"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 19:20",
            verseText: "The LORD came down on Mount Sinai, to the top of the mountain. And the LORD called Moses to the top of the mountain, and Moses went up. (ESV)"
        ),
        Question(
            text: "Who was Moses' sister?",
            options: ["Ruth", "Miriam", "Leah", "Rachel"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 15:20",
            verseText: "Then Miriam the prophetess, the sister of Aaron, took a tambourine in her hand, and all the women went out after her with tambourines and dancing. (ESV)"
        ),
        Question(
            text: "What did the Israelites make while Moses was on the mountain?",
            options: ["Golden Serpent", "Golden Calf", "Golden Chariot", "Golden Throne"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 32:4",
            verseText: "And he received the gold from their hand and fashioned it with a graving tool and made a golden calf. And they said, \"These are your gods, O Israel, who brought you up out of the land of Egypt!\" (ESV)"
        ),
        Question(
            text: "What was Moses doing when God called him from the burning bush?",
            options: ["Sleeping", "Tending sheep", "Fishing", "Building a house"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 3:1-2",
            verseText: "Now Moses was keeping the flock of his father-in-law, Jethro, the priest of Midian, and he led his flock to the west side of the wilderness and came to Horeb, the mountain of God. And the angel of the LORD appeared to him in a flame of fire out of the midst of a bush. (ESV)"
        ),
        Question(
            text: "What happened to the firstborn of Egypt during the last plague?",
            options: ["They became ill", "They died", "They left Egypt", "They joined Israel"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 12:29-30",
            verseText: "At midnight the LORD struck down all the firstborn in the land of Egypt, from the firstborn of Pharaoh who sat on his throne to the firstborn of the captive who was in the dungeon, and all the firstborn of the livestock. And Pharaoh rose up in the night, he and all his servants and all the Egyptians. And there was a great cry in Egypt, for there was not a house where someone was not dead. (ESV)"
        ),
        Question(
            text: "What sign protected the Israelites during the plague on the firstborn?",
            options: ["Blood on doorposts", "Lights in windows", "Cross on rooftops", "Fire in courtyards"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 12:13",
            verseText: "The blood shall be a sign for you, on the houses where you are. And when I see the blood, I will pass over you, and no plague will befall you to destroy you, when I strike the land of Egypt. (ESV)"
        ),
        Question(
            text: "What did God provide for the Israelites to drink when they were thirsty?",
            options: ["Wine", "Milk", "Water from a rock", "Juice"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 17:6",
            verseText: "Behold, I will stand before you there on the rock at Horeb, and you shall strike the rock, and water shall come out of it, and the people will drink. And Moses did so, in the sight of the elders of Israel. (ESV)"
        ),
        Question(
            text: "What appeared as a pillar of cloud by day and pillar of fire by night?",
            options: ["God's presence", "Moses' staff", "The Ark", "Tabernacle"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 13:21-22",
            verseText: "And the LORD went before them by day in a pillar of cloud to lead them along the way, and by night in a pillar of fire to give them light, that they might travel by day and by night. The pillar of cloud by day and the pillar of fire by night did not depart from before the people. (ESV)"
        ),
        Question(
            text: "What bird did God send for the Israelites to eat?",
            options: ["Eagles", "Doves", "Quail", "Sparrows"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 16:13",
            verseText: "In the evening quail came up and covered the camp, and in the morning dew lay around the camp. (ESV)"
        ),
        Question(
            text: "Who was Pharaoh's daughter that found Moses in the river?",
            options: ["Nefertiti", "Cleopatra", "Not named in the Bible", "Hatshepsut"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 2:5-10",
            verseText: "Now the daughter of Pharaoh came down to bathe at the river, while her young women walked beside the river. She saw the basket among the reeds and sent her servant woman, and she took it. When she opened it, she saw the child, and behold, the baby was crying. She took pity on him and said, \"This is one of the Hebrews' children.\" (ESV)"
        ),
        Question(
            text: "How did Moses' mother try to save him as a baby?",
            options: ["Gave him to another family", "Placed him in a basket in the river", "Hid him in a cave", "Sent him to another country"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 2:3",
            verseText: "When she could hide him no longer, she took for him a basket made of bulrushes and daubed it with bitumen and pitch. She put the child in it and placed it among the reeds by the river bank. (ESV)"
        ),
        Question(
            text: "What was the second plague God sent on Egypt?",
            options: ["Frogs", "Lice", "Flies", "Locusts"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 8:1-15",
            verseText: "Then the LORD said to Moses, \"Go in to Pharaoh and say to him, 'Thus says the LORD, \"Let my people go, that they may serve me. But if you refuse to let them go, behold, I will plague all your country with frogs.\"' (ESV)"
        ),
        Question(
            text: "Why did Moses flee from Egypt the first time?",
            options: ["He was banished by Pharaoh", "He killed an Egyptian", "He stole from the palace", "He freed slaves"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 2:11-15",
            verseText: "One day, when Moses had grown up, he went out to his people and looked on their burdens, and he saw an Egyptian beating a Hebrew, one of his people. He looked this way and that, and seeing no one, he struck down the Egyptian and hid him in the sand. (ESV)"
        ),
        Question(
            text: "What was Moses' wife's name?",
            options: ["Zipporah", "Rachel", "Leah", "Sarah"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 2:21",
            verseText: "And Moses was content to dwell with the man, and he gave Moses his daughter Zipporah. (ESV)"
        ),
        Question(
            text: "What was the last of the Ten Commandments?",
            options: ["Do not commit adultery", "Do not steal", "Do not murder", "Do not covet"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 20:17",
            verseText: "You shall not covet your neighbor's house; you shall not covet your neighbor's wife, or his male servant, or his female servant, or his ox, or his donkey, or anything that is your neighbor's. (ESV)"
        ),
        Question(
            text: "Who was Moses' father-in-law?",
            options: ["Jethro", "Laban", "Potiphar", "Eli"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 3:1",
            verseText: "Now Moses was keeping the flock of his father-in-law, Jethro, the priest of Midian, and he led his flock to the west side of the wilderness and came to Horeb, the mountain of God. (ESV)"
        ),
        Question(
            text: "What animal spoke to Balaam?",
            options: ["Donkey", "Lion", "Serpent", "This event is not in Exodus"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Numbers 22:28-30",
            verseText: "Then the LORD opened the mouth of the donkey, and she said to Balaam, \"What have I done to you, that you have struck me these three times?\" (ESV)"
        ),
        Question(
            text: "What did God tell Moses to do to bring water from the rock?",
            options: ["Strike it", "Pray over it", "Sing to it", "Place his staff on it"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 17:6",
            verseText: "Behold, I will stand before you there on the rock at Horeb, and you shall strike the rock, and water shall come out of it, and the people will drink. And Moses did so, in the sight of the elders of Israel. (ESV)"
        ),
        Question(
            text: "What tribe was Moses from?",
            options: ["Judah", "Levi", "Benjamin", "Dan"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 2:1",
            verseText: "Now a man from the house of Levi went and took as his wife a Levite woman. (ESV)"
        ),
        Question(
            text: "How many days was Moses on Mount Sinai receiving the law?",
            options: ["20", "30", "40", "50"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 24:18",
            verseText: "Moses entered the cloud and went up on the mountain. And Moses was on the mountain forty days and forty nights. (ESV)"
        ),
        Question(
            text: "What did the Israelites call the bread God provided in the wilderness?",
            options: ["Bread of life", "Angel food", "Manna", "Showbread"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .easy,
            verseReference: "Exodus 16:31",
            verseText: "Now the house of Israel called its name manna. It was like coriander seed, white, and the taste of it was like wafers made with honey. (ESV)"
        ),
        
        // MEDIUM QUESTIONS
        Question(
            text: "What did the Israelites ask from the Egyptians before leaving?",
            options: ["Livestock", "Articles of gold and silver", "Food", "Weapons"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 12:35-36",
            verseText: "The people of Israel had also done as Moses told them, for they had asked the Egyptians for silver and gold jewelry and for clothing. And the LORD had given the people favor in the sight of the Egyptians, so that they let them have what they asked. Thus they plundered the Egyptians. (ESV)"
        ),
        Question(
            text: "What did Moses do to the golden calf made by the Israelites?",
            options: ["Burned it and ground it to powder", "Buried it", "Threw it into the sea", "Kept it as a reminder"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 32:20",
            verseText: "He took the calf that they had made and burned it with fire and ground it to powder and scattered it on the water and made the people of Israel drink it. (ESV)"
        ),
        Question(
            text: "Who helped Aaron make the golden calf?",
            options: ["Moses", "The people", "The Levites", "The Egyptian slaves"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 32:1-4",
            verseText: "When the people saw that Moses delayed to come down from the mountain, the people gathered themselves together to Aaron and said to him, \"Up, make us gods who shall go before us. As for this Moses, the man who brought us up out of the land of Egypt, we do not know what has become of him.\" So Aaron said to them, \"Take off the rings of gold that are in the ears of your wives, your sons, and your daughters, and bring them to me.\" So all the people took off the rings of gold that were in their ears and brought them to Aaron. And he received the gold from their hand and fashioned it with a graving tool and made a golden calf. And they said, \"These are your gods, O Israel, who brought you up out of the land of Egypt!\" (ESV)"
        ),
        Question(
            text: "What was the sign that the Sabbath day should be kept?",
            options: ["Star in the sky", "Rainbow", "Covenant between God and Israel", "Cloud over the Tabernacle"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 31:13-17",
            verseText: "You are to speak to the people of Israel and say, \"Above all you shall keep my Sabbaths, for this is a sign between me and you throughout your generations, that you may know that I, the LORD, sanctify you.\" (ESV)"
        ),
        Question(
            text: "What did God tell Moses to put in a jar as a reminder for generations to come?",
            options: ["Blood", "Water", "Manna", "Oil"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 16:33-34",
            verseText: "And Moses said to Aaron, \"Take a jar, and put an omer of manna in it, and place it before the LORD to be kept throughout your generations.\" As the LORD commanded Moses, so Aaron placed it before the testimony to be kept. (ESV)"
        ),
        Question(
            text: "What was the name of the place where the Israelites found bitter water?",
            options: ["Elim", "Marah", "Rephidim", "Shur"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 15:23",
            verseText: "When they came to Marah, they could not drink the water of Marah because it was bitter; therefore it was named Marah. (ESV)"
        ),
        Question(
            text: "Who held up Moses' hands during the battle with the Amalekites?",
            options: ["Joshua and Caleb", "Aaron and Hur", "Miriam and Aaron", "The elders of Israel"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 17:12",
            verseText: "But Moses' hands grew weary, so they took a stone and put it under him, and he sat on it, while Aaron and Hur held up his hands, one on one side, and the other on the other side. So his hands were steady until the going down of the sun. (ESV)"
        ),
        Question(
            text: "What did Moses throw into the water at Marah to make it sweet?",
            options: ["Salt", "A branch", "His staff", "Stone"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 15:25",
            verseText: "And he cried to the LORD, and the LORD showed him a log, and he threw it into the water, and the water became sweet. (ESV)"
        ),
        Question(
            text: "What material was used to make the ark of the covenant?",
            options: ["Cedar wood", "Acacia wood", "Pine wood", "Olive wood"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 25:10",
            verseText: "They shall make an ark of acacia wood. Two cubits and a half shall be its length, a cubit and a half its breadth, and a cubit and a half its height. (ESV)"
        ),
        Question(
            text: "What did Moses break when he saw the Israelites worshipping the golden calf?",
            options: ["The altar", "The tablets of the covenant", "His staff", "The golden calf"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 32:19",
            verseText: "And as soon as he came near the camp and saw the calf and the dancing, Moses' anger burned hot, and he threw the tablets out of his hands and broke them at the foot of the mountain. (ESV)"
        ),
        Question(
            text: "What excuse did Aaron give for making the golden calf?",
            options: ["The people forced him", "He threw gold in the fire and out came the calf", "He wanted to test their loyalty", "He didn't make it"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 32:24",
            verseText: "So I said to them, 'Let any who have gold take it off.' So they gave it to me, and I threw it into the fire, and out came this calf. (ESV)"
        ),
        Question(
            text: "What was the name of the place where Moses received water from the rock?",
            options: ["Meribah", "Horeb", "Sinai", "Marah"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 17:7",
            verseText: "And he called the name of the place Massah and Meribah, because of the quarreling of the people of Israel, and because they tested the LORD by saying, \"Is the LORD among us or not?\" (ESV)"
        ),
        Question(
            text: "What did Moses see that made him afraid to look at God?",
            options: ["Earthquake", "Burning bush", "Lightning", "Pillar of fire"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 3:2-6",
            verseText: "And the angel of the LORD appeared to him in a flame of fire out of the midst of a bush. He looked, and behold, the bush was burning, yet it was not consumed. And Moses said, \"I will turn aside to see this great sight, why the bush is not burned.\" When the LORD saw that he turned aside to see, God called to him out of the bush, \"Moses, Moses!\" And he said, \"Here I am.\" Then he said, \"Do not come near; take your sandals off your feet, for the place on which you are standing is holy ground.\" And he said, \"I am the God of your father, the God of Abraham, the God of Isaac, and the God of Jacob.\" And Moses hid his face, for he was afraid to look at God. (ESV)"
        ),
        Question(
            text: "Which tribe stood with Moses after the golden calf incident?",
            options: ["Judah", "Benjamin", "Levi", "Reuben"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 32:26",
            verseText: "Then Moses stood in the gate of the camp and said, \"Who is on the LORD's side? Come to me.\" And all the sons of Levi gathered around him. (ESV)"
        ),
        Question(
            text: "What was the fifth plague on Egypt?",
            options: ["Livestock died", "Boils", "Hail", "Locusts"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 9:1-7",
            verseText: "Then the LORD said to Moses, \"Go in to Pharaoh and say to him, 'Thus says the LORD, the God of the Hebrews, \"Let my people go, that they may serve me. For if you refuse to let them go and still hold them, behold, the hand of the LORD will fall with a very severe plague upon your livestock that are in the field, the horses, the donkeys, the camels, the herds, and the flocks.\"' (ESV)"
        ),
        Question(
            text: "What was the sixth plague on Egypt?",
            options: ["Livestock died", "Boils", "Hail", "Locusts"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 9:8-12",
            verseText: "And the LORD said to Moses and Aaron, \"Take handfuls of soot from the kiln, and let Moses throw them in the air in the sight of Pharaoh. It shall become fine dust over all the land of Egypt, and become boils breaking out in sores on man and beast throughout all the land of Egypt.\" (ESV)"
        ),
        Question(
            text: "How many days did the darkness plague last in Egypt?",
            options: ["1", "3", "7", "10"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 10:21-23",
            verseText: "Then the LORD said to Moses, \"Stretch out your hand toward heaven, that there may be darkness over the land of Egypt, a darkness to be felt.\" So Moses stretched out his hand toward heaven, and there was pitch darkness in all the land of Egypt three days. They did not see one another, nor did anyone rise from his place for three days, but all the people of Israel had light where they lived. (ESV)"
        ),
        Question(
            text: "What month of the year did God designate as the first month for Israel?",
            options: ["Tishri", "Abib (Nisan)", "Sivan", "Adar"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 12:2",
            verseText: "This month shall be for you the beginning of months. It shall be the first month of the year for you. (ESV)"
        ),
        Question(
            text: "What was the name of the feast instituted to commemorate Israel's deliverance from Egypt?",
            options: ["Feast of Tabernacles", "Passover", "Pentecost", "Purim"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 12:11-14",
            verseText: "In this manner you shall eat it: with your belt fastened, your sandals on your feet, and your staff in your hand. And you shall eat it in haste. It is the LORD's Passover. For I will pass through the land of Egypt that night, and I will strike all the firstborn in the land of Egypt, both man and beast; and on all the gods of Egypt I will execute judgments: I am the LORD. The blood shall be a sign for you, on the houses where you are. And when I see the blood, I will pass over you, and no plague will befall you to destroy you, when I strike the land of Egypt. (ESV)"
        ),
        Question(
            text: "Who was Moses' successor?",
            options: ["Aaron", "Joshua", "Caleb", "Not mentioned in Exodus"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Joshua 1:1-2",
            verseText: "After the death of Moses the servant of the LORD, the LORD said to Joshua the son of Nun, Moses' assistant, \"Moses my servant is dead. Now therefore arise, go over this Jordan, you and all this people, into the land that I am giving to them, to the people of Israel. (ESV)"
        ),
        Question(
            text: "What stones were on the breastplate of the high priest?",
            options: ["10 stones representing the commandments", "12 stones representing the tribes of Israel", "7 stones representing the days of creation", "3 stones representing the patriarchs"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 28:17-21",
            verseText: "You shall set in it four rows of stones. A row of sardius, topaz, and carbuncle shall be the first row; and the second row an emerald, a sapphire, and a diamond; and the third row a jacinth, an agate, and an amethyst; and the fourth row a beryl, an onyx, and a jasper. They shall be set in gold filigree. There shall be twelve stones with their names according to the names of the sons of Israel. They shall be like signets, each engraved with its name, for the twelve tribes. (ESV)"
        ),
        Question(
            text: "What did the Israelites use to mark their doors during Passover?",
            options: ["Lamb's blood", "Olive oil", "Red paint", "A special symbol"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 12:7",
            verseText: "Then they shall take some of the blood and put it on the two doorposts and the lintel of the houses in which they eat it. (ESV)"
        ),
        Question(
            text: "What did God say His name was to Moses at the burning bush?",
            options: ["Elohim", "Adonai", "Yahweh", "I AM WHO I AM"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 3:14",
            verseText: "God said to Moses, \"I AM WHO I AM.\" And he said, \"Say this to the people of Israel: 'I AM has sent me to you.'\" (ESV)"
        ),
        Question(
            text: "What were the two artisans chosen to craft items for the tabernacle?",
            options: ["Aaron and Hur", "Moses and Aaron", "Bezalel and Oholiab", "Joshua and Caleb"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 31:1-6",
            verseText: "The LORD said to Moses, \"See, I have called by name Bezalel the son of Uri, son of Hur, of the tribe of Judah, and I have filled him with the Spirit of God, with ability and intelligence, with knowledge and all craftsmanship, to devise artistic designs, to work in gold, silver, and bronze, in cutting stones for setting, and in carving wood, to work in every craft. And behold, I have appointed with him Oholiab, the son of Ahisamach, of the tribe of Dan. And I have given to all able men ability, that they may make all that I have commanded you: (ESV)"
        ),
        Question(
            text: "Where did God first speak to Moses from a burning bush?",
            options: ["Mount Sinai", "Mount Horeb", "Mount Nebo", "Mount Carmel"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 3:1-2",
            verseText: "Now Moses was keeping the flock of his father-in-law, Jethro, the priest of Midian, and he led his flock to the west side of the wilderness and came to Horeb, the mountain of God. And the angel of the LORD appeared to him in a flame of fire out of the midst of a bush. He looked, and behold, the bush was burning, yet it was not consumed. (ESV)"
        ),
        Question(
            text: "What creatures were on top of the Ark of the Covenant?",
            options: ["Lions", "Eagles", "Cherubim", "Seraphim"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 25:18-20",
            verseText: "And you shall make two cherubim of gold; of hammered work shall you make them, on the two ends of the mercy seat. Make one cherub on the one end, and one cherub on the other end. Of one piece with the mercy seat shall you make the cherubim on its two ends. The cherubim shall spread out their wings above, overshadowing the mercy seat with their wings, their faces one to another; toward the mercy seat shall the faces of the cherubim be. (ESV)"
        ),
        Question(
            text: "How many chapters are in the book of Exodus?",
            options: ["30", "40", "50", "60"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 1-40",
            verseText: "The book of Exodus contains 40 chapters detailing the story of Israel's deliverance from Egypt, the giving of the law, and the construction of the tabernacle. (ESV)"
        ),
        Question(
            text: "What object did Moses place in the tabernacle that budded?",
            options: ["His staff", "Aaron's staff", "A branch from a tree", "This event is not in Exodus"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Numbers 17:8",
            verseText: "On the next day Moses went into the tent of the testimony, and behold, the staff of Aaron for the house of Levi had sprouted and put forth buds and produced blossoms, and it bore ripe almonds. (ESV)"
        ),
        Question(
            text: "What part of the burnt offering was given to the priests?",
            options: ["The hide", "The meat", "The fat", "The organs"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Leviticus 7:8",
            verseText: "And the priest who offers any man's burnt offering shall have for himself the skin of the burnt offering that he has offered. (ESV)"
        ),
        Question(
            text: "What did God instruct the Israelites to do on the Sabbath day?",
            options: ["Worship at the tabernacle", "Rest from work", "Fast", "Travel to Jerusalem"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 20:8-11",
            verseText: "Remember the Sabbath day, to keep it holy. Six days you shall labor, and do all your work, but the seventh day is a Sabbath to the LORD your God. On it you shall not do any work, you, or your son, or your daughter, your male servant, or your female servant, or your livestock, or the sojourner who is within your gates. For in six days the LORD made heaven and earth, the sea, and all that is in them, and rested on the seventh day. Therefore the LORD blessed the Sabbath day and made it holy. (ESV)"
        ),
        Question(
            text: "How many branches did the golden lampstand have?",
            options: ["5", "6", "7", "12"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 25:31-37",
            verseText: "You shall make a lampstand of pure gold. The lampstand shall be made of hammered work: its base, its stem, its cups, its calyxes, and its flowers shall be of one piece with it. And there shall be six branches going out of its sides, three branches of the lampstand out of one side of it, and three branches of the lampstand out of the other side of it. (ESV)"
        ),
        Question(
            text: "How many times was the Passover celebrated in the book of Exodus?",
            options: ["Once", "Twice", "Three times", "Never"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 12",
            verseText: "The Passover was celebrated once in the book of Exodus, marking the deliverance of Israel from Egypt. (ESV)"
        ),
        Question(
            text: "What were the two tablets of the covenant made of?",
            options: ["Gold", "Wood", "Clay", "Stone"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 31:18",
            verseText: "And he gave to Moses, when he had finished speaking with him on Mount Sinai, the two tablets of the testimony, tablets of stone, written with the finger of God. (ESV)"
        ),
        Question(
            text: "Who went up Mount Sinai with Moses the second time?",
            options: ["Aaron", "Joshua", "No one", "The elders"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 34:3",
            verseText: "No one shall come up with you, and let no one be seen throughout all the mountain. Let no flocks or herds graze opposite that mountain. (ESV)"
        ),
        Question(
            text: "What land did God promise to the Israelites in Exodus?",
            options: ["Land of Nod", "Land flowing with milk and honey", "Fertile Crescent", "Mediterranean Coast"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 3:8",
            verseText: "And I have come down to deliver them out of the hand of the Egyptians and to bring them up out of that land to a good and broad land, a land flowing with milk and honey, to the place of the Canaanites, the Hittites, the Amorites, the Perizzites, the Hivites, and the Jebusites. (ESV)"
        ),
        Question(
            text: "What did the Israelites use to build bricks in Egypt?",
            options: ["Clay and water", "Mud and stone", "Straw and clay", "Sand and limestone"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 5:7",
            verseText: "You shall no longer give the people straw to make bricks, as in the past; let them go and gather straw for themselves. (ESV)"
        ),
        Question(
            text: "After which plague did Pharaoh first say he would let the people go?",
            options: ["Hail", "Frogs", "Locusts", "Darkness"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 8:8",
            verseText: "Then Pharaoh called Moses and Aaron and said, \"Plead with the LORD to take away the frogs from me and from my people, and I will let the people go to sacrifice to the LORD.\" (ESV)"
        ),
        Question(
            text: "What metal was used to overlay the ark of the covenant?",
            options: ["Silver", "Bronze", "Gold", "Copper"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 25:11",
            verseText: "You shall overlay it with pure gold, inside and outside shall you overlay it, and you shall make on it a molding of gold around it. (ESV)"
        ),
        Question(
            text: "Who came to visit Moses in the wilderness and brought his wife and sons?",
            options: ["Aaron", "Jethro", "Pharaoh", "A messenger from Egypt"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .medium,
            verseReference: "Exodus 18:1-6",
            verseText: "Jethro, the priest of Midian, Moses' father-in-law, heard of all that God had done for Moses and for Israel his people, how the LORD had brought Israel out of Egypt. Now Jethro, Moses' father-in-law, had taken Zipporah, Moses' wife, after he had sent her home, along with her two sons. The name of the one was Gershom (for he said, \"I have been a sojourner in a foreign land\"), and the name of the other, Eliezer (for he said, \"The God of my father was my help, and delivered me from the sword of Pharaoh\"). Jethro, Moses' father-in-law, came with his sons and his wife to Moses in the wilderness where he was encamped at the mountain of God. (ESV)"
        ),
        
        // HARD QUESTIONS
        Question(
            text: "What was Moses' father's name?",
            options: ["Kohath", "Amram", "Izhar", "Levi"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 6:20",
            verseText: "Amram took as his wife Jochebed his father's sister, and she bore him Aaron and Moses, the years of the life of Amram being 137 years. (ESV)"
        ),
        Question(
            text: "In what year of the exodus did the Israelites begin building the tabernacle?",
            options: ["First year", "Second year", "Third year", "Fourth year"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 40:17",
            verseText: "In the first month in the second year, on the first day of the month, the tabernacle was erected. (ESV)"
        ),
        Question(
            text: "What was Moses' mother's name?",
            options: ["Jochebed", "Miriam", "Puah", "Shiphrah"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 6:20",
            verseText: "Amram took as his wife Jochebed his father's sister, and she bore him Aaron and Moses, the years of the life of Amram being 137 years. (ESV)"
        ),
        Question(
            text: "On what day of what month did the Israelites arrive at Mount Sinai?",
            options: ["15th day of the 2nd month", "1st day of the 3rd month", "10th day of the 1st month", "14th day of the 1st month"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 19:1",
            verseText: "On the third new moon after the people of Israel had gone out of the land of Egypt, on that day they came into the wilderness of Sinai. (ESV)"
        ),
        Question(
            text: "What was written on the golden plate of the high priest's turban?",
            options: ["Holiness to the Lord", "Chosen of God", "Priest of the Most High", "Servant of Israel"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 28:36",
            verseText: "You shall make a plate of pure gold and engrave on it, like the engraving of a signet, 'Holy to the LORD.' (ESV)"
        ),
        Question(
            text: "How many days did the cloud cover Mount Sinai before God called to Moses?",
            options: ["3", "6", "7", "10"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 24:16",
            verseText: "The glory of the LORD dwelt on Mount Sinai, and the cloud covered it six days. And on the seventh day he called to Moses out of the midst of the cloud. (ESV)"
        ),
        Question(
            text: "What was the name of the place where the Israelites traveled three days without finding water?",
            options: ["Wilderness of Shur", "Wilderness of Zin", "Wilderness of Sin", "Wilderness of Paran"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 15:22",
            verseText: "Then Moses made Israel set out from the Red Sea, and they went into the wilderness of Shur. They went three days in the wilderness and found no water. (ESV)"
        ),
        Question(
            text: "What spice was included in the holy anointing oil?",
            options: ["Saffron", "Cumin", "Cinnamon", "Mint"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 30:23",
            verseText: "Take the finest spices: of liquid myrrh 500 shekels, and of sweet-smelling cinnamon half as much, that is, 250, and 250 of aromatic cane, (ESV)"
        ),
        Question(
            text: "How many pillars surrounded the courtyard of the tabernacle?",
            options: ["40", "50", "60", "70"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 27:10",
            verseText: "Its twenty pillars and their twenty bases shall be of bronze, but the hooks of the pillars and their fillets shall be of silver. (ESV)"
        ),
        Question(
            text: "What was the width of the tabernacle in cubits?",
            options: ["8", "10", "12", "20"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 26:16",
            verseText: "Each frame shall be ten cubits long and a cubit and a half wide. (ESV)"
        ),
        Question(
            text: "How many loops were on each curtain of the tabernacle?",
            options: ["40", "50", "60", "70"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 26:5",
            verseText: "Fifty loops you shall make on the one curtain, and fifty loops you shall make on the edge of the curtain that is in the second set. The loops shall be opposite one another. (ESV)"
        ),
        Question(
            text: "How many boards were on the north side of the tabernacle?",
            options: ["10", "15", "20", "25"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 26:20",
            verseText: "And for the second side of the tabernacle, on the north side, twenty frames, (ESV)"
        ),
        Question(
            text: "Which item in the tabernacle had to be made from a single piece of gold?",
            options: ["The lampstand", "The altar of incense", "The table of showbread", "The ark's cover"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 25:31",
            verseText: "You shall make a lampstand of pure gold. The lampstand shall be made of hammered work: its base, its stem, its cups, its calyxes, and its flowers shall be of one piece with it. (ESV)"
        ),
        Question(
            text: "What were the names of the two Hebrew midwives who defied Pharaoh?",
            options: ["Zilpah and Bilhah", "Shiphrah and Puah", "Hoglah and Milcah", "Mahlah and Tirzah"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 1:15",
            verseText: "Then the king of Egypt said to the Hebrew midwives, one of whom was named Shiphrah and the other Puah, (ESV)"
        ),
        Question(
            text: "What was Moses' objection to God when called to lead Israel?",
            options: ["He was too young", "He wasn't eloquent in speech", "He was afraid of Pharaoh", "He didn't know God's name"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 4:10",
            verseText: "But Moses said to the LORD, \"Oh, my Lord, I am not eloquent, either in the past or since you have spoken to your servant, but I am slow of speech and of tongue.\" (ESV)"
        ),
        Question(
            text: "What was the name of Moses' first son?",
            options: ["Eliezer", "Gershom", "Kohath", "Amram"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 2:22",
            verseText: "She gave birth to a son, and he called his name Gershom, for he said, \"I have been a sojourner in a foreign land.\" (ESV)"
        ),
        Question(
            text: "What specific area was not affected by the plague of flies?",
            options: ["Pharaoh's palace", "Land of Goshen", "Egyptian temples", "Nile River"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 8:22",
            verseText: "But on that day I will set apart the land of Goshen, where my people dwell, so that no swarms of flies shall be there, that you may know that I am the LORD in the midst of the earth. (ESV)"
        ),
        Question(
            text: "What metal were the sockets for the tabernacle boards made of?",
            options: ["Bronze", "Gold", "Silver", "Copper"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 26:19",
            verseText: "You shall make forty bases of silver under the twenty frames: two bases under one frame for its two tenons, and two bases under the next frame for its two tenons. (ESV)"
        ),
        Question(
            text: "How many men of Israel died after worshipping the golden calf?",
            options: ["About 1,000", "About 2,000", "About 3,000", "About 4,000"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 32:28",
            verseText: "And the sons of Levi did according to the word of Moses. And that day about three thousand men of the people fell. (ESV)"
        ),
        Question(
            text: "What was the name of the Amalekite king that Israel fought against?",
            options: ["Balak", "Sihon", "Og", "Not mentioned in Exodus"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Numbers 24:7",
            verseText: "Water shall flow from his buckets, and his seed shall be in many waters; his king shall be higher than Agag, and his kingdom shall be exalted. (ESV)"
        ),
        Question(
            text: "What specific color was required for some of the tabernacle coverings?",
            options: ["Blue", "Scarlet", "Purple", "All of these"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 26:1",
            verseText: "Moreover, you shall make the tabernacle with ten curtains of fine twined linen and blue and purple and scarlet yarns; you shall make them with cherubim skillfully worked into them. (ESV)"
        ),
        Question(
            text: "How much did Moses collect in the offering for the tabernacle?",
            options: ["29 talents and 730 shekels of gold", "100 talents and 1,775 shekels of silver", "70 talents and 2,400 shekels of bronze", "All of these"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 38:24-31",
            verseText: "All the gold that was used for the work, in all the construction of the sanctuary, the gold from the offering, was 29 talents and 730 shekels, by the shekel of the sanctuary. The silver from those of the congregation who were recorded was 100 talents and 1,775 shekels, by the shekel of the sanctuary. The bronze that was offered was 70 talents and 2,400 shekels. (ESV)"
        ),
        Question(
            text: "What day were the Israelites to select the Passover lamb?",
            options: ["1st day of the month", "7th day of the month", "10th day of the month", "14th day of the month"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 12:3",
            verseText: "Tell all the congregation of Israel that on the tenth day of this month every man shall take a lamb according to their fathers' houses, a lamb for a household. (ESV)"
        ),
        Question(
            text: "What precisely was forbidden during the week of Unleavened Bread?",
            options: ["Having yeast in your house", "Eating meat", "Working", "Traveling"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 12:15",
            verseText: "Seven days you shall eat unleavened bread. On the first day you shall remove leaven out of your houses, for if anyone eats what is leavened, from the first day until the seventh day, that person shall be cut off from Israel. (ESV)"
        ),
        Question(
            text: "How many years did the Israelites live in Egypt?",
            options: ["215 years", "400 years", "430 years", "450 years"],
            correctAnswerIndex: 2,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 12:40",
            verseText: "The time that the people of Israel lived in Egypt was 430 years. (ESV)"
        ),
        Question(
            text: "What did Moses call the altar he built after defeating the Amalekites?",
            options: ["Jehovah-Jireh", "The LORD is my Banner", "Bethel", "Ebenezer"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 17:15",
            verseText: "And Moses built an altar and called the name of it, The LORD Is My Banner, (ESV)"
        ),
        Question(
            text: "Which of Jacob's sons is specifically mentioned in Exodus chapter 1?",
            options: ["Judah", "Joseph", "Benjamin", "Levi"],
            correctAnswerIndex: 1,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 1:5",
            verseText: "All the descendants of Jacob were seventy persons; Joseph was already in Egypt. (ESV)"
        ),
        Question(
            text: "What specific sacrifice was offered on the eighth day of the priest's ordination?",
            options: ["Sin offering", "Burnt offering", "Peace offering", "This event is not in Exodus"],
            correctAnswerIndex: 3,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Leviticus 9:1-4",
            verseText: "On the eighth day Moses called Aaron and his sons and the elders of Israel, and he said to Aaron, \"Take for yourself a bull calf for a sin offering and a ram for a burnt offering, both without blemish, and offer them before the LORD. And say to the people of Israel, 'Take a male goat for a sin offering, and a calf and a lamb, both a year old, without blemish, for a burnt offering, and an ox and a ram for peace offerings, to sacrifice before the LORD, and a grain offering mixed with oil, for today the LORD will appear to you.'\" (ESV)"
        ),
        Question(
            text: "What was the exact weight of gold used in the tabernacle?",
            options: ["29 talents and 730 shekels", "39 talents and 730 shekels", "49 talents and 730 shekels", "59 talents and 730 shekels"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 38:24",
            verseText: "All the gold that was used for the work, in all the construction of the sanctuary, the gold from the offering, was 29 talents and 730 shekels, by the shekel of the sanctuary. (ESV)"
        ),
        Question(
            text: "How long did it take to set up the tabernacle?",
            options: ["1 day", "7 days", "30 days", "Not specified in Exodus"],
            correctAnswerIndex: 0,
            book: .exodus,
            difficulty: .hard,
            verseReference: "Exodus 40:2",
            verseText: "On the first day of the first month you shall erect the tabernacle of the tent of meeting. (ESV)"
        )
    ]
    
    // You can add more books as you develop them, for example:
    /*
    static let genesisQuestions: [Question] = [
        // Genesis questions will go here
    ]
    */
}
