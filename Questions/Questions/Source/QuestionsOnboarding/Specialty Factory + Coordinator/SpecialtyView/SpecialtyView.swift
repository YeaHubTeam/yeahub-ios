import SwiftUI

public struct SpecialtyListView: View {
    public let specialties: [String]

    public init(
        specialties: [String] = [
            "Frontend",
            "Backend",
            "QA",
            "DevOps",
            "Data Analytics",
            "Mobile",
            "Design"
        ]
    ) {
        self.specialties = specialties
    }

    public var body: some View {
        VStack(spacing: 0) {
            Text("Выберите специальность")
                .font(.manrope(.semibold, size: 20))
                .padding(.top, 16)
                .padding(.bottom, 8)

            List(specialties, id: \.self) { specialty in
                HStack {
                    Text(specialty)
                        .font(.manrope(.regular, size: 16))
                    Spacer()
                }
                .padding(.vertical, 12)
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    SpecialtyListView(specialties: [
        "Frontend",
        "Backend",
        "QA",
        "DevOps",
        "Data Analytics",
        "Mobile",
        "Design"
    ])
}
