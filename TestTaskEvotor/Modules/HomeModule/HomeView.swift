//
//  HomeView.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import UIKit

final class HomeView: UIView, HomeViewing {
    
    private let controller: HomeControlling
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.register(TitleDetailsViewCell.self, forCellReuseIdentifier: TitleDetailsViewCell.identifier)
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        return activity
    }()
    private let refreshControl = UIRefreshControl()
    
    private var items: [(BrandItem, [CarModelItem])] = []
    
    // MARK: - Life Cycle
    init(controller: HomeControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setTableViewConstraints()
        setActivityIndicatorConstraints()
        super.updateConstraints()
    }
    
    
    func configureView() {
        backgroundColor = .white
        configureTableView()
        addSubview(activityIndicator)
        configureRefreshControl()
        setNeedsUpdateConstraints()
    }
    
    func setItems(items: [(BrandItem, [CarModelItem])]) {
        self.items = items
        tableView.reloadData()
    }
    
    func setLoading(isActive: Bool) {
        if isActive {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            refreshControl.endRefreshing()
        }
    }
    
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.tableHeaderView = UIView()
    }
    
    
    @objc private func refresh() {
        controller.refreshData()
    }
    
}

// MARK: - Constraints
extension HomeView {
    private func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: - TableView
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = items[indexPath.section].1[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailsViewCell.identifier) as! TitleDetailsViewCell
        cell.setValue(TitleDetailsView.Value(title: currentItem.name, detail: currentItem.releaseDate))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentBrandItem = items[section].0
        let foundersString = currentBrandItem.founders.joined(separator: ", ")
        let view = TitleDetailsView(style: .main)
        view.setValue(value: TitleDetailsView.Value(title: currentBrandItem.name, subtitle: foundersString, detail: currentBrandItem.foundationDate))
        return view
    }
}

