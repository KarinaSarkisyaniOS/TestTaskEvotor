//
//  HomeController.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import UIKit

final class HomeController: UIViewController, HomeControlling {
    
    private var homeView: HomeViewing!
    private let apiService = ApiService()
    
    private let requestsGroup = DispatchGroup()
    
    private var brands: [Brand] = []
    private var carModels: [CarModel] = []
    
    // MARK: - API Handlers
    private lazy var getBrandsHandler: (DataResponse<Brand>?, String?) -> () = { [weak self] response, errorString in
        defer { self?.requestsGroup.leave() }
        guard let brands = response?.data else {
            print(errorString ?? "Неизвестная ошибка")
            return
        }
        self?.brands = brands
    }
    private lazy var getCarModelsHandler: (DataResponse<CarModel>?, String?) -> () = { [weak self] response, errorString in
        defer { self?.requestsGroup.leave() }
        guard let carModels = response?.data else {
            print(errorString ?? "Неизвестная ошибка")
            return
        }
        self?.carModels = carModels
    }
    private lazy var allDataGotHandler: () -> () = { [weak self] in
        guard let self = self else { return }
        var items: [(BrandItem, [CarModelItem])] = []
        for brand in self.brands {
            let carModels = self.carModels.filter({$0.brandId == brand.id})
            let brandItem = BrandItem(id: brand.id, name: brand.name, founders: brand.founders, foundationDate: brand.foundationDate)
            let carModelItems = carModels.map({ CarModelItem(brandId: $0.brandId, name: $0.name, releaseDate: $0.releaseDate) })
            items.append((brandItem, carModelItems))
        }
        self.homeView.setLoading(isActive: false)
        self.homeView.setItems(items: items)
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        homeView = HomeView(controller: self)
        view = homeView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Автомобили"
        homeView.configureView()
        homeView.setLoading(isActive: true)
        fetchBrandsAndCars()
    }
    
    
    func refreshData() {
        fetchBrandsAndCars()
    }
    
    
    private func fetchBrandsAndCars() {
        requestsGroup.enter()
        requestsGroup.enter()
        apiService.send(request: .getBrands, handler: getBrandsHandler)
        apiService.send(request: .getCarModels, handler: getCarModelsHandler)
        requestsGroup.notify(queue: .main, execute: allDataGotHandler)
    }
    
}
