//
//  ViewController.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase


class CategoryViewController: UIViewController {
    
    var dbRef:DatabaseReference?
    
    var categoryView = CategoryView()
    
    var categories = [Category]() {
        didSet{
            DispatchQueue.main.async {
                self.categoryView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navSetup()
        categoryView.tableView.delegate = self
        categoryView.tableView.dataSource = self
        viewContraints()
        
        loadDataFromFirebase()
    }
    
    private func loadDataFromFirebase() {
        dbRef = Database.database().reference()
        dbRef?.child("Categories").observe(.value) { (snapShot) in
            var cats = [Category]()
            for child in snapShot.children {
                let newCat = Category(snapShot: child as! DataSnapshot)
                cats.append(newCat)
            }
            self.categories = cats
        }
    }
    
    func navSetup(){
        navigationItem.title = "Categories"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "iconCreate"), style: .plain, target: self, action: #selector(addCat))
    }
    @objc private func addCat(){
        let alertController = UIAlertController(title: "New Category", message: "Plase type the category's name", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField) in
            textField.textColor = UIColor.red
            textField.placeholder = "Enter category's name"
        }
        
        let saveButton = UIAlertAction(title: "Save", style: .default, handler: { (alert) in
            if let firstTextField = alertController.textFields![0] as? UITextField, let message = firstTextField.text {
                self.saveCat(message: message)
            }
        })
        alertController.addAction(cancelButton)
        alertController.addAction(saveButton)
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveCat(message: String) {
         dbRef = Database.database().reference()
        let newCat = dbRef?.child("Categories").childByAutoId()
        let newVal = Category(ref: newCat, name: message)
        newCat?.setValue(newVal.toAnyObj())
    }
    
    
    
    private func viewContraints() {
        view.addSubview(categoryView)
        categoryView.backgroundColor = .yellow
        categoryView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat = categories[indexPath.row]
        let destinationVC = CreateQandAViewController()
        destinationVC.category = cat
        navigationController?.pushViewController(destinationVC, animated: true)
        //present(destinationVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell {
            let category = categories[indexPath.row]
            cell.configCell(cat: category)
            return cell
        }
        return UITableViewCell()
    }
}
