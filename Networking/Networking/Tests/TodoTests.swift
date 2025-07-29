import XCTest

final class TodoTests: XCTestCase {

    let api = TodoApi()

    func testList() async throws {
        let todos = try await api.list()
        XCTAssertEqual(todos.count, 200)
    }
}
