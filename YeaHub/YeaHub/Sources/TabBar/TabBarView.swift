import UIKit

// MARK: - TabBarView
final class TabBarView: UIView {

    struct Configuration {
        let items: [UITabBarItem]
        let selectedIndex: Int
        let onSelect: (Int) -> Void
        let colors: TabBarColors
    }

    enum Constants {
        static let tabsHeight: CGFloat = 52
        static let safeAreaHeightLarge: CGFloat = 34
        static let safeAreaHeightSmall: CGFloat = 8
        static let maxTabs = 5
        static let horizontalMargin: CGFloat = 12
        static let badgeSize: CGFloat = 6
        static let imageSize: CGFloat = 24
        static let imageTopOffset: CGFloat = 10
        static let titleTopOffset: CGFloat = 2
    }

    private let stackView = UIStackView()
    private var items: [UITabBarItem] = []
    private var selectedIndex: Int = 0
    private var onSelect: ((Int) -> Void)?
    private var colors: TabBarColors = .default

    private lazy var moreTab = UITabBarItem(
        title: "More",
        image: UIImage(systemName: "ellipsis"),
        selectedImage: UIImage(systemName: "ellipsis")
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .systemBackground

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalMargin),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalMargin),
            stackView.heightAnchor.constraint(equalToConstant: Constants.tabsHeight + Constants.safeAreaHeightSmall)
        ])
    }

    private func resultTabItems(_ items: [UITabBarItem]) -> [UITabBarItem] {
        if items.count > Constants.maxTabs {
            return Array(items.prefix(Constants.maxTabs - 1)) + [moreTab]
        } else {
            return items
        }
    }

    func configure(with configuration: Configuration) {
        self.items = configuration.items
        self.selectedIndex = configuration.selectedIndex
        self.onSelect = configuration.onSelect
        self.colors = configuration.colors

        updateUI()
    }

    private func updateUI() {
        backgroundColor = colors.background

        let tabItems = resultTabItems(items)

        // Remove existing views
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        // Add new views
        for (index, item) in tabItems.enumerated() {
            let itemView = TabBarItemView()

            let isSelected: Bool = {
                if items.count > Constants.maxTabs,
                   selectedIndex > (Constants.maxTabs - 2),
                   index > (Constants.maxTabs - 2) {
                    return true
                }
                return index == selectedIndex
            }()

            let itemConfiguration = TabBarItemView.Configuration(
                title: item.title ?? "\(index)",
                image: isSelected ? (item.selectedImage ?? item.image) : item.image,
                isSelected: isSelected,
                renderingMode: .alwaysTemplate,
                colors: colors.items,
                onTap: { [weak self] in
                    self?.onSelect?(index)
                }
            )

            itemView.configure(with: itemConfiguration)
            stackView.addArrangedSubview(itemView)
        }
    }

    func updateColors(_ colors: TabBarColors, animated: Bool = false) {
        self.colors = colors

        if animated {
            UIView.animate(withDuration: 0.1) {
                self.updateColorsInternal()
            }
        } else {
            updateColorsInternal()
        }
    }

    private func updateColorsInternal() {
        backgroundColor = colors.background

        stackView.arrangedSubviews.forEach { subview in
            if let item = subview as? TabBarItemView {
                item.updateColors(colors.items)
            }
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)

        guard let itemView = result as? TabBarItemView,
              stackView.arrangedSubviews.firstIndex(of: itemView) != nil else {
            return result
        }

        // Highlight effect
        for subview in stackView.arrangedSubviews {
            if let view = subview as? TabBarItemView {
                view.isHighlighted = view === itemView
            }
        }

        // Remove highlight after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.stackView.arrangedSubviews.forEach { subview in
                if let view = subview as? TabBarItemView {
                    view.isHighlighted = false
                }
            }
        }

        return result
    }
}

// MARK: - TabBarItemView
private final class TabBarItemView: UIControl {

    struct Configuration {
        let title: String
        let image: UIImage?
        let isSelected: Bool
        let renderingMode: UIImage.RenderingMode
        let colors: TabBarItemColors
        let onTap: () -> Void
    }

    let imageView = UIImageView()
    private let titleLabel = UILabel()

    private var onTapAction: (() -> Void)?
    private var isItemSelected: Bool = false
    private var itemColors: TabBarItemColors = TabBarItemColors(unselected: .systemGray, selected: .systemBlue)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        // ImageView setup
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        // Title label setup
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingMiddle
        titleLabel.isUserInteractionEnabled = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            // ImageView constraints
            imageView.widthAnchor.constraint(equalToConstant: TabBarView.Constants.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: TabBarView.Constants.imageSize),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: TabBarView.Constants.imageTopOffset),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Title label constraints
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: TabBarView.Constants.titleTopOffset
            ),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])

        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    func configure(with configuration: Configuration) {
        self.isItemSelected = configuration.isSelected
        self.itemColors = configuration.colors
        self.onTapAction = configuration.onTap

        titleLabel.font = configuration.isSelected
        ? .systemFont(ofSize: 12, weight: .bold)
        : .systemFont(ofSize: 12, weight: .regular)
        titleLabel.text = configuration.title

        updateColors(configuration.colors)
        imageView.image = configuration.image?.withRenderingMode(configuration.renderingMode)
    }

    func updateColors(_ colors: TabBarItemColors) {
        self.itemColors = colors

        let color: UIColor = isItemSelected ? colors.selected : colors.unselected
        titleLabel.textColor = color
        imageView.tintColor = color

        setNeedsLayout()
        layoutIfNeeded()
    }

    @objc private func didTap() {
        onTapAction?()
    }

    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.6 : 1.0
        }
    }

    override var isEnabled: Bool {
        didSet {
            imageView.alpha = isEnabled ? 1.0 : 0.5
            titleLabel.alpha = isEnabled ? 1.0 : 0.5
        }
    }
}

// MARK: - Preview
extension TabBarView {

    static func preview() -> UIView {
        let view = TabBarView()
        let configuration = Configuration(
            items: (0..<5).map {
                UITabBarItem(title: "Item \($0)", image: UIImage(systemName: "star"), tag: $0)
            },
            selectedIndex: 0,
            onSelect: { _ in },
            colors: .light
        )
        view.configure(with: configuration)

        let container = UIView()
        container.backgroundColor = .systemRed
        container.translatesAutoresizingMaskIntoConstraints = false

        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor),
            view.heightAnchor.constraint(
                equalToConstant: TabBarView.Constants.tabsHeight + TabBarView.Constants.safeAreaHeightSmall
            )
        ])

        return container
    }
}

// MARK: - UIViewController Extension
extension UIViewController {

    public var tabBarColors: TabBarColors {
        get {
            (objc_getAssociatedObject(self, &tabBarColorsKey) as? ColorsWrapper)?.colors ?? .default
        }
        set {
            let oldValue = tabBarColors
            if let wrapper = objc_getAssociatedObject(self, &tabBarColorsKey) as? ColorsWrapper {
                wrapper.colors = newValue
            } else {
                objc_setAssociatedObject(
                    self,
                    &tabBarColorsKey,
                    ColorsWrapper(newValue),
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
            if oldValue != newValue {
                // Можно добавить обновление цветов таб бара
            }
        }
    }
}

private final class ColorsWrapper {
    var colors: TabBarColors

    init(_ colors: TabBarColors) {
        self.colors = colors
    }
}

private var tabBarColorsKey = 0

@available(iOS 17.0, *)
#Preview {
    TabBarView.preview()
}
