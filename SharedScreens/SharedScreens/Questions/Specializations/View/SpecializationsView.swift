import CommonUI
import SwiftUI

struct SpecializationsView: View {
    @ObservedObject var viewModel: SpecializationsViewModel

    var body: some View {
        YHLoader(state: viewModel.viewState, refresh: {
            viewModel.loadSpecializations()
        }, successView: {
            getCurrentView()
        })
        .task {
            viewModel.loadSpecializations()
        }
        .animation(.easeInOut, value: viewModel.viewState)
        .onDisappear {
            viewModel.cancelLoading()
        }
    }

    private func getCurrentView() -> some View {
        return VStack(alignment: .leading, spacing: Constants.headerSpacing) {
            Text(Constants.header)
                .font(Constants.headerFont)
                .foregroundStyle(Constants.headerColor)
                .padding(.horizontal, Constants.headerHorizontalPadding)
                .padding(.top, Constants.headerTopPadding)

            ScrollView {
                LazyVStack(spacing: Constants.defaultSpacing) {
                    ForEach(viewModel.specializations) { specialization in
                        Button {
                            viewModel.passQuestionID(specialization.id)
                            print(specialization.id)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                    .foregroundStyle(Constants.roundedRectangleColor)
                                    .frame(height: Constants.roundedRectangleHeight)
                                    .padding(.horizontal, Constants.roundedRectangleHorizontalPadding)
                                    .defaultShadow()

                                Text(specialization.title)
                                    .font(Constants.specializationFont)
                                    .foregroundStyle(Constants.specializationColor)
                            }
                        }
                    }
                }
                .padding(.vertical, Constants.defaultPadding)
            }
        }
        .background(Constants.background)
    }
}

private extension SpecializationsView {
    enum Constants {
        static let header = "IT-специальность"

        static let headerSpacing: CGFloat = 10
        static let headerFont: Font = .manrope(.semibold, size: 20)
        static let headerColor: Color = .black900
        static let headerHorizontalPadding: CGFloat = 16
        static let headerTopPadding: CGFloat = 24

        static let defaultSpacing: CGFloat = 8
        static let defaultPadding: CGFloat = 16
        static let background: Color = .black10

        static let cornerRadius: CGFloat = 8
        static let roundedRectangleColor: Color = .white
        static let roundedRectangleHeight: CGFloat = 64
        static let roundedRectangleHorizontalPadding: CGFloat = 16

        static let specializationFont: Font = .manrope(.medium, size: 16)
        static let specializationColor: Color = .black900
    }
}
