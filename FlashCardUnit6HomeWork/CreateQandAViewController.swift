//
//  CreateQandAViewController.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase
class CreateQandAViewController: UIViewController {
    var dbRef:DatabaseReference?
    var createQandAView = CereateQandAView()
    var category: Category!
    
    var questionAnswer = [Card]() {
        didSet{
            DispatchQueue.main.async {
                self.createQandAView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createQandAView.tableView.delegate = self
        createQandAView.tableView.dataSource = self
        loadDataFromFirebase()
        viewContraints()
        navSetup()
    }
    
    private func loadDataFromFirebase() {
        dbRef = Database.database().reference()
        dbRef?.child("Cards").observe(.value) { (snapShot) in
            var qa = [Card]()
            for child in snapShot.children {
                let newQA = Card(snapShot: child as! DataSnapshot)
                if newQA.catKey == self.category.key{
                qa.append(newQA)
                }
            }
            self.questionAnswer = qa
        }
    }
    
    func navSetup(){
        navigationItem.title = category.name
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "icoAdd"), style: .plain, target: self, action: #selector(creatQA))
        navigationItem.largeTitleDisplayMode = .always
    }
    @objc private func creatQA(){
        let alertController = UIAlertController(title: "New Question and Answer", message: "Plase enter A question and Answere", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField) in
            textField.textColor = UIColor.red
            textField.placeholder = "Enter question"
        }
        alertController.addTextField { (textField) in
            textField.textColor = UIColor.blue
            textField.placeholder = "Enter Answer"
        }
        
        let saveButton = UIAlertAction(title: "Save", style: .default, handler: { (alert) in
            var question = ""
            var answer = ""
            if let firstTextField = alertController.textFields![0] as? UITextField, let message1 = firstTextField.text {
                question = message1
            }
            if let secondTExtField = alertController.textFields![1] as? UITextField, let message2 = secondTExtField.text {
                answer = message2
            }
            self.saveQA(question: question, answer: answer)
        })
        alertController.addAction(cancelButton)
        alertController.addAction(saveButton)
        present(alertController, animated: true, completion: nil)
    }
    

    
    private func saveQA(question: String, answer: String) {
        dbRef = Database.database().reference()
        let newQA = dbRef?.child("Cards").childByAutoId()
        let newVal = Card(ref: newQA, catKey: self.category.key, question: question, answer: answer)
        newQA?.setValue(newVal.toAnyObj())
    }

    
    
    private func viewContraints() {
        view.addSubview(createQandAView)
        createQandAView.backgroundColor = .yellow
        createQandAView.snp.makeConstraints { (make) in
        make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CreateQandAViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionAnswer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QACell", for: indexPath) as? QandACell {
            let qanda = questionAnswer[indexPath.row]
            cell.configCell(qaCell: qanda)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
extension CreateQandAViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
