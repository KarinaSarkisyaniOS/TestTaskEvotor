//
//  TitleDetailsView.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import UIKit

final class TitleDetailsView: UIView {
    
    struct Value {
        var title: String
        var subtitle: String? = nil
        var detail: String
    }
    
    enum Style {
        case main
        case secondary
    }
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private let style: Style
    
    // MARK: - Life Cycle
    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setHorizontalStackConstraints()
        super.updateConstraints()
    }
    
    
    func setValue(value: Value) {
        titleLabel.text = value.title
        if let subtitle = value.subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        }
        detailLabel.text = value.detail
    }
    
    
    private func configureView() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.addArrangedSubview(detailLabel)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(subtitleLabel)
        
        switch style {
        case .main:
            backgroundColor = .systemGroupedBackground
            detailLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        case .secondary:
            backgroundColor = .white
        }
        setNeedsUpdateConstraints()
    }
    
}

// MARK: - Constraints
extension TitleDetailsView {
    private func setHorizontalStackConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: style == .main ? -16 : -24)
        ])
    }
}
