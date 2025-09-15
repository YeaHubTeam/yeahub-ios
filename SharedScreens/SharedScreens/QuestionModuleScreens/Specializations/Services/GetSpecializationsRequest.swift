import Foundation
import Networking

struct GetSpecializationsRequest: HttpRequest {
    var method: HttpMethod {
        HttpMethod.get
    }

    var url: HttpUrl {
        return HttpUrl(string: "https://api.yeatwork.ru/specializations")!
    }

    var headers: [HttpHeaderKey : String] {
        [:]
    }

    var body: Data? {
        nil
    }
}
