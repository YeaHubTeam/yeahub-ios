import CommonUI
import SwiftUI

struct SpecializationsView: View {
    @ObservedObject var viewModel: SpecializationsViewModel

    var body: some View {
        YHLoader(state: viewModel.viewState, refresh: {
            Task {
                await viewModel.loadSpecializations()
            }
        }, successView: {
            getCurrentView()
        })
        .task {
            await viewModel.loadSpecializations()
        }
        .animation(.easeInOut, value: viewModel.viewState)
    }

    private func getCurrentView() -> some View {
        VStack(alignment: .leading, spacing: Constants.headerSpacing) {
            Text(Constants.header)
                .font(Constants.headerFont)
                .foregroundStyle(Constants.headerColor)
                .padding(.horizontal, Constants.headerHorizontalPadding)
                .padding(.top, Constants.headerTopPadding)
            
            YHSearchBar(
                text: $viewModel.searchText,
                placeholder: Constants.searchPlaceholder
            )
            .padding(.horizontal, Constants.searchHorizontalPadding)
            
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.bubbleSpacing) {
                    YHBubbleCollection(
                        collection: .textOnly(categories: viewModel.filterTaggedItems.map { $0.tag }),
                        selected: $viewModel.selectedSpecialization,
                        selectionMode: .single
                    )
                }
                .padding(.vertical, Constants.bubbleVerticalPadding)
            }
                        
            YHButton(
                title: Constants.findButtonTitle,
                state: viewModel.hasSelectedSpecialization ? .primaryEnabled : .primaryDisabled
            ) {
                let selected = viewModel.taggedItems
                    .filter { viewModel.selectedSpecialization.contains($0.tag.id) }
                    .map { $0.specialization }
                viewModel.passSpecializations(selected)
            }
            .padding(.horizontal, Constants.buttonHorizontalPadding)
            .padding(.bottom, Constants.buttonBottomPadding)
        }
        .background(Constants.background)
    }
}

private extension SpecializationsView {
    enum Constants {
        static let header = "Какое направление изучаете?"
        static let searchPlaceholder = "Профессия, инструмент"
        static let findButtonTitle = "Найти"
        
        static let headerSpacing: CGFloat = 10
        static let headerFont: Font = .manrope(.regular, size: 16)
        static let headerColor: Color = .black700
        static let headerHorizontalPadding: CGFloat = 16
        static let headerTopPadding: CGFloat = 24
        
        static let searchHorizontalPadding: CGFloat = 16
        
        static let bubbleSpacing: CGFloat = 8
        static let bubbleVerticalPadding: CGFloat = 16
        
        static let buttonHorizontalPadding: CGFloat = 16
        static let buttonBottomPadding: CGFloat = 36
        
        static let background: Color = .black10
    }
}
