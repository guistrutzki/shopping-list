//
//  ViewController.swift
//  shopping-list
//
//  Created by Guilherme Strutzki on 17/08/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let controller = ShoppingController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    @IBAction func didTappedAddProduct(_ sender: Any) {
        self.triggerAlert()
    }
    
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib(nibName: ShoppingItemCell.identifier, bundle: nil), forCellReuseIdentifier: ShoppingItemCell.identifier)
    }
    
    func getShoppingItemCell(index: Int) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: ShoppingItemCell.identifier) as? ShoppingItemCell
        else {
            return UITableViewCell()
        }
        
        let product = self.controller.getProductByIndex(index: index)
        
        cell.setupCell(product: product)
        
        return cell
    }
    
    func triggerAlert() {
        let alert: UIAlertController = UIAlertController(title: "Produto", message: "Insira o produto", preferredStyle: .alert)
        
        let btnCancel: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            print("Dismiss alert")
        }
        
        let btnConfirmar: UIAlertAction = UIAlertAction(title: "Salvar", style: .default) { action in
            print("Salvar")
            let textField = alert.textFields![0]
            
            self.controller.addProduct(textField.text ?? "")
            self.tableView.reloadData()
        }
        
        alert.addAction(btnCancel)
        alert.addAction(btnConfirmar)
        
        alert.addTextField { textField in
            textField.placeholder = "Digite o produto"
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return controller.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getShoppingItemCell(index: indexPath.row)
    }
}
