//
//  ProductCell.swift
//  shopping-list
//
//  Created by Guilherme Strutzki on 17/08/21.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productAvatar: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    static let identifier = "ProductCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    func setupCell(product: Product) {
        self.productLabel.text = product.name
        
        if (product.image != nil) {
            self.productAvatar.image = product.image
        }
    }
}
