import Foundation
import Networking

struct GetQuestionsRequest: HttpRequest {
    var method: HttpMethod { .get }

    var url: HttpUrl {
        HttpUrl(string: "https://api.yeatwork.ru/questions")!
    }

    var headers: [HttpHeaderKey : String] { [:] }

    var body: Data? { nil }
}
