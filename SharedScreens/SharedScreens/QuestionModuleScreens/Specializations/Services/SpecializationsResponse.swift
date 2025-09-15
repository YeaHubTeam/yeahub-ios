struct SpecializationsResponse: Decodable {
    let data: [Specialization]
    let page: Int
    let limit: Int
    let total: Int
}
