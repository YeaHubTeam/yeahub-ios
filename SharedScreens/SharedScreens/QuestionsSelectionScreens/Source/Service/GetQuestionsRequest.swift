import Foundation
import Networking

struct GetQuestionsRequest: HttpRequest {
    let specializationId: Int
    
    var method: HttpMethod { .get }

    var url: HttpUrl {
        HttpUrl(string: "https://api.yeatwork.ru/questions/public-questions?specialization=\(specializationId)")!
    }

    var headers: [HttpHeaderKey : String] { [:] }

    var body: Data? { nil }
}
