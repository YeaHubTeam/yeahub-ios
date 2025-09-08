protocol SpecializationsRepositoryProtocol {
    func fetchSpecializations() async throws -> [Specialization]
}
