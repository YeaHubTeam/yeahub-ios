import Foundation

public struct QuestionsResponse: Decodable {
    public let data: [QuestionsModel]
}

public struct QuestionsModel: Decodable, Hashable, Identifiable {
    public let id: Int
    public let title: String
    public let description: String?
    public let shortAnswer: String?
    public let longAnswer: String?
}
