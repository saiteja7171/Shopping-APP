//
//  ViewController.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/6/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIManger.shared.fetchProducts { response in
            switch response{
            case .success(let products):
                print(products)
            case .failure(let error):
                print(error)
            }
        }
    }


}

