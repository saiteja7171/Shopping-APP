//
//  UIImageView + Extention.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/8/24.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView{
    func setImage(urlstring: String){
        guard let url = URL.init(string: urlstring)else{return}
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlstring)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
