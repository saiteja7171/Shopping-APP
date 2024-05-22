//
//  EndPointType.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/9/24.
//

import Foundation

enum HTTPMethods: String{
    case get = "GET"
    case post = "POST"
}

// In protocol we define only declaration of objects
protocol EndPointURLFormation{
    var baseURL: String { get }
    var URLPath: String { get }
    var url: URL? { get }
    var methods: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String : String]? { get }
}

// each case represents each module
enum ScreenModules{
    case products
    case addProduct(product: AddProduct)
    //case login
}

extension ScreenModules: EndPointURLFormation{
       var baseURL: String {
        switch self{
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
        
    }
    
    var URLPath: String {
        switch self {
        case .products:
            return "products"
        //case .login
        case .addProduct:
            return "products/add"
        }
        
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(URLPath)")
    }
    
    var methods: HTTPMethods {
        switch self{
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self{
        case .products:	 // We are not sending body to getProductList API so we are sending as nil
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        return APIManger.commonHeaders
    }
    
    
}
