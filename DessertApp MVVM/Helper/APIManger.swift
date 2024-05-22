//
//  APIManger.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/6/24.
//
/*
 static:    When we declare any property or a key word with static keyword in class we can directly         access that property without creating the instance of the class.
 Singleton: whenever we are creating a instance within the class itself and not allowing others to          create the instance outside then we declare with private init.
 singleton: Whenever we are creating a instance outside the class
            eg: creating an instance in other class.
 final:     If someone wants to inherit the singleton class if you dont want them to inherit it you         can declare the class with Final keyword
 */

import Foundation
// Singleton
enum DataErrors : Error{
    case invalidResponse
    case invalidURL
    case invalidData
    case invalidDecoding
    case message(error: Error?)
    
}
typealias handler<T> = (Result<T, DataErrors>) -> Void

final class APIManger{
    static let shared = APIManger()
    private init(){}
    
    // 6. 
    func request<T:Codable>(modelType: T.Type,
                    ScreenTypeModule: EndPointURLFormation,
                    completion: @escaping handler<T>){
        
        guard let url = ScreenTypeModule.url else{
            return completion(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = ScreenTypeModule.methods.rawValue
        
        // We are not using guard let because it should work for GET method also
        if let parameter = ScreenTypeModule.body {
            request.httpBody = try? JSONEncoder().encode(parameter)
        }
        request.allHTTPHeaderFields = ScreenTypeModule.headers
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data ,error == nil else{
                completion(.failure(.invalidData))
                return}
            
            guard let response = response as? HTTPURLResponse, 
                      200 ... 299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return}
            
            do{
                // JSON Decoder + decodable is used to convert data into model.
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products)) // 7.
            }catch{
                completion(.failure(.message(error: error)))
            }
        }.resume()
    }
    static var commonHeaders: [String : String]{
        return ["Content-Type": "application/json"]
    }
  
    
}

