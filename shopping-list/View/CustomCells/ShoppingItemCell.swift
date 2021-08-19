//
//  ShoppingItemCell.swift
//  shopping-list
//
//  Created by Guilherme Strutzki on 17/08/21.
//

import UIKit

class ShoppingItemCell: UITableViewCell {
    
    @IBOutlet weak var productAvatar: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    static let identifier = "ShoppingItemCell"

    func setupCell(product: Product) {
        self.productLabel.text = product.name
        
        if (product.image != nil) {
            self.productAvatar.image = product.image
        }
    }
}
