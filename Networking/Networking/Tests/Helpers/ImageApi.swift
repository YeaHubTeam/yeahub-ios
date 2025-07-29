import Foundation

struct ImageApi {

    let client: HttpClient = UrlSessionHttpClient(logLevel: .trace)
    let apiBaseUrl = HttpUrl(host: "via.placeholder.com")

    func download() async throws -> Data {
        let pipeline = HttpRawPipeline(
            url: apiBaseUrl.path("150"),
            method: .get
        )
        let res = try await pipeline.execute(client.downloadTask)
        return res.data
    }
}
