//
//  ShoppingController.swift
//  shopping-list
//
//  Created by Guilherme Strutzki on 17/08/21.
//

import UIKit

class ShoppingController {
    private var products = [Product]()
    
    func addProduct(_ name: String) {
        if (name.isEmpty) { return }
        
        products.append(Product(name: name, image: nil))
    }
    
    func getAllProducts() -> [Product] {
        return self.products
    }
    
    func getProductByIndex(index: Int) -> Product {
        return self.products[index]
    }
    
    func getProductsCount() -> Int {
        return self.products.count
    }
    
    func updateProductAvatar(index: Int, image: UIImage) {
        let currentProduct = self.products[index]
        let updatedProduct = Product(name: currentProduct.name, image: image)
        
        self.products[index] = updatedProduct
    }
    
    func removeProduct(index: Int) {
        self.products.remove(at: index)
    }
    
}
