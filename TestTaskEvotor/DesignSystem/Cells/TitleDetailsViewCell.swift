//
//  TitleDetailsViewCell.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import UIKit

final class TitleDetailsViewCell: UITableViewCell {
    
    static let identifier = "TitleDetailsViewCell"
    
    private var mainView: TitleDetailsView = {
        let view = TitleDetailsView(style: .secondary)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setMainViewConstraints()
        super.updateConstraints()
    }
    
    
    func setValue(_ value: TitleDetailsView.Value) {
        mainView.setValue(value: value)
    }
    
    
    private func configureCell() {
        selectionStyle = .none
        contentView.addSubview(mainView)
        setNeedsUpdateConstraints()
    }
    
}

// MARK: - Constraints
extension TitleDetailsViewCell {
    private func setMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
