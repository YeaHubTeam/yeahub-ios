import UIKit

struct TabBarItem: Hashable, Identifiable {

    struct Page: ExpressibleByStringLiteral, Hashable {

        var value: String

        init(_ value: String) {
            self.value = value
        }

        init(stringLiteral value: String) {
            self.value = value
        }
    }

    struct Slug: ExpressibleByStringLiteral, Hashable {

        var value: String

        init(_ value: String) {
            self.value = value
        }

        init(stringLiteral value: String) {
            self.value = value
        }
    }

    var id: Int { hashValue }

    // Using to identify the tab
    let slug: Slug

    // Using to identify the screen
    let page: Page

    let name: String

    let image: UIImage?

    let selectedImage: UIImage?

    func tabBarItem() -> UITabBarItem {
        let tabBarItem = UITabBarItem(
            title: name,
            image: image,
            selectedImage: selectedImage
        )
        tabBarItem.accessibilityIdentifier = slug.value
        return tabBarItem
    }

    static func == (lhs: TabBarItem, rhs: TabBarItem) -> Bool {
        lhs.slug == rhs.slug &&
            lhs.page == rhs.page &&
            lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(slug)
        hasher.combine(page)
    }
}

extension TabBarItem: CustomDebugStringConvertible {

    var debugDescription: String {
        "TabBarItem(slug: \(slug), page: \(page), name: \(name)"
    }
}
