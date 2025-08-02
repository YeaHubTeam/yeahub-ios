import SwiftUI
import CommonUI

struct HomeView: View {

    private enum ImagesType {
        case frameworks
        case companies
    }

    var body: some View {
        ZStack {
            Color.black10
                .ignoresSafeArea()
            VStack(spacing: Constants.defaultInset) {
                textsHeader
                
                button(
                    type: .frameworks,
                    title: "База вопросов",
                    description: "Большая база вопросов по 50+ востребованных технологий: JavaScript, React, Python, SQL и другие"
                )
                .defaultShadow()

                button(
                    type: .companies,
                    title: "Коллекции",
                    description: "Актуальные и востребованные вопросы с реальных технических собеседований"
                )
                .defaultShadow()

                Spacer()
            }
            .padding(.top, Constants.topInset)
            .padding(.horizontal, Constants.defaultInset)
        }
        .navigationBarHidden(true)
    }

    private var textsHeader: some View {
        VStack(alignment: .leading, spacing: Constants.textsHeaderInset) {
            Text("Сервис подготовки к собеседованиям")
                .foregroundStyle(Color.black900)
                .font(.manrope(.semibold, size: 20))
            
            Text("Готовьтесь к собеседованию с подборками вопросов из крупных IT-компаний. Узнайте, какие вопросы задают в Сбере, Т-Банке, Яндексе, Авито, Ozon, VK и других компаниях.")
                .foregroundStyle(Color.black900)
                .font(.manrope(.medium, size: 16))
                .foregroundColor(.secondary)
        }
        .padding(.bottom, Constants.textsHeaderInset)
    }

    private func imagesGrid(type: ImagesType) -> some View {
        let firstImage: Image
        let secondImage: Image
        let thirdImage: Image
        let fourthImage: Image

        switch type {
        case .frameworks:
            firstImage = CommonUIAssets.image("pythonIcon")
            secondImage = CommonUIAssets.image("reactIcon")
            thirdImage = CommonUIAssets.image("javaIcon")
            fourthImage = CommonUIAssets.image("jsIcon")
        case .companies:
            firstImage = CommonUIAssets.image("tbankIcon")
            secondImage = CommonUIAssets.image("avitoIcon")
            thirdImage = CommonUIAssets.image("sberIcon")
            fourthImage = CommonUIAssets.image("ozonIcon")
        }

        return VStack(spacing: Constants.gridSpacing) {
            HStack(spacing: Constants.gridSpacing) {
                icon(image: firstImage)
                    .background(Color.pureWhite)
                    .cornerRadius(Constants.Icon.cornerRadius)
                    .aspectRatio(contentMode: .fill)
                    .defaultShadow()
                icon(image: secondImage)
                    .background(Color.pureWhite)
                    .cornerRadius(Constants.Icon.cornerRadius)
                    .aspectRatio(contentMode: .fill)
                    .defaultShadow()
            }
            HStack(spacing: Constants.gridSpacing) {
                icon(image: thirdImage)
                    .background(Color.pureWhite)
                    .cornerRadius(Constants.Icon.cornerRadius)
                    .aspectRatio(contentMode: .fill)
                    .defaultShadow()
                icon(image: fourthImage)
                    .background(Color.pureWhite)
                    .cornerRadius(Constants.Icon.cornerRadius)
                    .aspectRatio(contentMode: .fill)
                    .defaultShadow()
            }
        }
    }

    private func icon(image: Image) -> some View {
        return ZStack {
            image
                .frame(width: Constants.Icon.imageSize, height: Constants.Icon.imageSize)
                .padding(Constants.Icon.imagePadding)
        }
        .frame(width: Constants.Icon.size, height: Constants.Icon.size)
        
    }

    private func button(
        type: ImagesType,
        title: String,
        description: String
    ) -> some View {
        return HStack(alignment: .top, spacing: Constants.Button.horizontalInset) {
            imagesGrid(type: type)

            VStack(alignment: .leading, spacing: Constants.Button.verticalinset) {
                Text(title)
                    .foregroundStyle(Color.black900)
                    .font(.manrope(.medium, size: 20))
                Text(description)
                    .foregroundStyle(Color.black900)
                    .font(.manrope(.medium, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, Constants.Button.horizontalInset)
        .padding(.vertical, Constants.defaultInset)
        .background(Color.white)
        .cornerRadius(Constants.Button.cornerRadius)
    }
}

extension HomeView {

    enum Constants {

        enum Button {
            static let horizontalInset: CGFloat = 12
            static let verticalinset: CGFloat = 4
            static let cornerRadius: CGFloat = 8
        }

        enum Icon {
            static let imageSize: CGFloat = 36
            static let imagePadding: CGFloat = 8
            static let size: CGFloat = 48
            static let cornerRadius: CGFloat = 10
        }

        static let gridSpacing: CGFloat = 4
        static let defaultInset: CGFloat = 16
        static let topInset: CGFloat = 24
        static let textsHeaderInset: CGFloat = 8
    }
}

#Preview {
    HomeView()
}
