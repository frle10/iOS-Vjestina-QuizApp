struct Quiz: Codable {
    
    let id: Int
    let title: String
    let description: String
    let category: QuizCategory
    let level: Int
    let imageUrl: String
    let questions: [Question]
    
    init(fromModel model: CDQuiz) {
        self.id = Int(model.id)
        self.title = model.title ?? ""
        self.description = model.desc ?? ""
        self.category = QuizCategory.init(rawValue: model.category!) ?? QuizCategory.sport
        self.level = Int(model.level)
        self.imageUrl = model.imageUrl ?? ""
        
        var questions: [Question] = []
        for cdQuestion in model.questions! {
            let question = Question(fromModel: cdQuestion as! CDQuestion)
            questions.append(question)
        }
        
        self.questions = questions
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case category
        case level
        case imageUrl = "image"
        case questions
    }
    
}
