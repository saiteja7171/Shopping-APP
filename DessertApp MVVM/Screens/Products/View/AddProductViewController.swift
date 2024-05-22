//
//  AddProductViewController.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/12/24.
//

import UIKit

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addProduct()
        
    }
    
    func addProduct(){
        guard let url = URL(string: "https://dummyjson.com/products/add")else{return}
        // If we are using URL request we are indicating to the compiler that we are using 'POST/UPDATE/DELETE'
        let parameter = AddProduct(title: "This is test data")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // JSON Encoder + Encodable is used to convert model to data
        request.httpBody = try? JSONEncoder().encode(parameter)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{return}
            do{
                let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                
            }catch{
                print(error)
            }
        }.resume()
    }
}
