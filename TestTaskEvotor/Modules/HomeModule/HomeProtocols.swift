//
//  HomeProtocols.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import UIKit

protocol HomeViewing: UIView {
    func configureView()
    func setItems(items: [(BrandItem, [CarModelItem])])
    func setLoading(isActive: Bool)
}

protocol HomeControlling: UIViewController {
    func refreshData()
}
