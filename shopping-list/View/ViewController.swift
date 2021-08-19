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
    private var selectedRowIndex: Int = 0
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    //MARK: - Private Functions
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellReuseIdentifier: ProductCell.identifier)
    }
    
    private func getProductCell(index: Int) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: ProductCell.identifier) as? ProductCell
        else {
            return UITableViewCell()
        }
        
        let product = self.controller.getProductByIndex(index: index)
        
        cell.setupCell(product: product)
        
        return cell
    }
    
    private func triggerAlert() {
        let alert: UIAlertController = UIAlertController(title: "Produto", message: "Insira o produto", preferredStyle: .alert)
        
        let btnCancel: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            print("Dismiss alert")
        }
        
        let btnConfirmar: UIAlertAction = UIAlertAction(title: "Salvar", style: .default) { action in
            print("Produto adicionado")
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
    
    private func didProductCellSelected(index: Int) {
        let alert = UIAlertController(title: "Alerta", message: "Escolha uma ação para este produto", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Remover", style: .destructive, handler: { action in
            let indexPath: IndexPath = IndexPath(row: index, section: 0)

            self.controller.removeProduct(index: index)
            self.tableView.deleteRows(at: [indexPath], with: .left)
        }))
        
        alert.addAction(UIAlertAction(title: "Tirar foto", style: .default, handler: { action in
            print("Open camera")
            self.getImage(fromSourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Escolher da biblioteca", style: .default, handler: { action in
            print("Open library")
            self.getImage(fromSourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
            print("cancel")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getImage(fromSourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(fromSourceType) {
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = fromSourceType
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    // MARK: - IBACtions
    
    @IBAction func didTappedAddProduct(_ sender: Any) {
        self.triggerAlert()
    }
    
}

// MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return controller.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getProductCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didProductCellSelected(index: indexPath.row)
        selectedRowIndex = indexPath.row
        print("Product index selected -> \(indexPath)")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image: UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let _image = image {
            self.controller.updateProductAvatar(index: selectedRowIndex, image: _image)
        }
        
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
