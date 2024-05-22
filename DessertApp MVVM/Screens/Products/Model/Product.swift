//
//  Product.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/6/24.
//

import Foundation

struct Product: Codable {
    let id : Int
    let title : String
    let price : Float
    let description : String
    let category : String
    let image : String
    let rating : RatingDetails
}
struct RatingDetails: Codable{
    let rate : Float
    let count : Int
}
