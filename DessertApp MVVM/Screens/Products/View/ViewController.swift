//
//  ViewController.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/6/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var productTableView: UITableView!
    
    
    let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()  // 1 .
//        checkForHighestNumberWithGeneric(a: 6, b: 6.89)
//        checkTypeOfInput(input: "9")
//        checkTypeOfInput(input: "Char")
//        checkTypeOfInput(input: 18)
//        checkTypeOfInput(input: 19.3)
//        checkTypeOfInput(input: false)
//        checkTypeOfInput(input: [10,28,74])
//        checkTypeOfInput(input: [43,"Hi",23.3,true])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddProductButton(_ sender: UIBarButtonItem) {
        let product = AddProduct(title: "Data displaying on the screen")
        viewModel.addProduct(parameters: product)
    }
    
}
extension ViewController{
    
    // 2.
    func configuration(){
        productTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        initiViewModel()
        observeEvent()
    }
    func initiViewModel(){
        //3.
        viewModel.getProductList()
    }
    func observeEvent(){
        viewModel.eventHandler = { event in
            switch event{
            case .startLoading:
                print("Start Loading")
            case .stopLoading:
                print("Stop Loading")
            case .dataLoaded:
                print("Data loaded")
                print(self.viewModel.product)
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error?.localizedDescription as Any)
            case .newProductAdded(product: let product):
                print(product)
            }
        }
    }
//    func checkForHighestNumber(a: Int, b: Int){
//        if(a>b){
//            print("A is higher than B")
//        }else{
//            print("B is higher than A")
//        }
//    }
//    func checkForHighestNumberWithGeneric<T: Comparable>(a: T, b: T){
//        if(a>b){
//            print("A is higher than B")
//        }else{
//            print("B is higher than A")
//        }
//    }
    func checkTypeOfInput<T>(input: T){
        print("The input value is \(type(of: input))")
    }
}
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else{return UITableViewCell()}
        let products = viewModel.product[indexPath.row]
       cell.product = products
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}

/*
 func fetchProducts(completion: @escaping handler)  {
      
      guard let url = URL(string: Constants.APIs.productUrl) else{
          completion(.failure(.invalidURL))
          return}
      //background task
      // If we are using (with: url) that means we are using 'GET'
 
      URLSession.shared.dataTask(with: url) {data, response, error in
          guard let data,error == nil else{
              completion(.failure(.invalidData))
              return}
          guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else{
              completion(.failure(.invalidResponse))
              return}
          do{
              let products = try JSONDecoder().decode([Product].self, from: data)
              completion(.success(products))
          }catch{
              completion(.failure(.message(error: error)))
          }
      }.resume()
     
  }
 */
