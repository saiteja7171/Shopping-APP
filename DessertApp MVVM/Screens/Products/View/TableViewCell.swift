//
//  TableViewCell.swift
//  DessertApp MVVM
//
//  Created by Sai Teja Atluri on 2/8/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var product: Product?{
        didSet{
            configuration()
        }
    }
    
    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var rating: UIButton!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configuration(){
        title.text = product?.title
        category.text = product?.category
        rating.setTitle("\(product!.rating.rate)", for: .normal)
        price.text = "$\(product!.price)"
        productDescription.text = product?.description
        ProductImage.setImage(urlstring: product?.image ?? "")
                
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
