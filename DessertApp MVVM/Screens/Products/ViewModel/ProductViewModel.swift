//
//  ProductViewModel.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/8/24.
//

import Foundation
class ProductViewModel{
    var product: [Product] = [] // server response saved in this variable
    var eventHandler: ((_ event: Event) -> Void)?
    
    // 4.
    func getProductList(){
        self.eventHandler?(.startLoading)
    
       /* APIManger.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response{
            case .success(let products):
                self.product = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }*/
        
        // 5.
        APIManger.shared.request(modelType: [Product].self, ScreenTypeModule: ScreenModules.products) { response in
            self.eventHandler?(.stopLoading)
            switch response{
            case .success(let products):
                self.product = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func addProduct(parameters: AddProduct){
        APIManger.shared.request(modelType: AddProduct.self, ScreenTypeModule: ScreenModules.addProduct(product: parameters)) { result in
            switch result{
            case .success(let products):
                self.eventHandler?(.newProductAdded(product: products))
            case .failure(let error):
                print(error)
            }
        }
    }
}

// This establish the communication between Viewmodel and ViewController
extension ProductViewModel{
    enum Event{
        case startLoading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }
}
