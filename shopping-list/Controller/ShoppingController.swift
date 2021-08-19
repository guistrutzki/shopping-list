//
//  ShoppingController.swift
//  shopping-list
//
//  Created by Guilherme Strutzki on 17/08/21.
//

protocol ShoppingControllerDelegate: AnyObject {
    func handleShoppingItemTapped(name: String)
}

class ShoppingController {
    private var products = [Product]()
    
    weak var delegate: ShoppingControllerDelegate?
    
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
    
}
