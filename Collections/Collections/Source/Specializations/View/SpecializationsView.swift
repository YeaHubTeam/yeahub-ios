import CommonUI
import SwiftUI

struct SpecializationsView: View {
    @ObservedObject var viewModel: SpecializationsViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Загрузка…")
            } else if let error = viewModel.errorMessage {
                Text("Ошибка: \(error)")
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    Text("IT-специальность")
                        .font(.manrope(.semibold, size: 20))
                        .foregroundStyle(Color.black900)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)

                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.specializations) { specialization in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color.white)
                                        .frame(height: 64)
                                        .padding(.horizontal, 16)
                                        .defaultShadow()

                                    Text(specialization.title)
                                        .font(.manrope(.medium, size: 16))
                                        .foregroundStyle(Color.black900)
                                }
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
                .background(Color.black10)
            }
        }
        .task {
            await viewModel.load()
        }
    }
}
