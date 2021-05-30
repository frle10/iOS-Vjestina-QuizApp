struct Question: Codable {

    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
    init(fromModel model: CDQuestion) {
        self.id = Int(model.id)
        self.question = model.question ?? ""
        self.answers = model.answers!
        self.correctAnswer = Int(model.correctAnswer)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answers
        case correctAnswer = "correct_answer"
    }
    
}
