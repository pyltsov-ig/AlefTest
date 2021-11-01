//
//  ViewController.swift
//  AlefTest
//
//  Created by Igor Pyltsov on 01.11.2021.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {

    @IBOutlet weak var adulteName: HoshiTextField!
    @IBOutlet weak var adultAge: HoshiTextField!
    @IBOutlet weak var addChild: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var childrenTableView: UITableView!
    
    
    //var childrenList = [Child]()
    
    var addBtnIsDisabled:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        
        addChild.layer.borderColor = UIColor.systemTeal.cgColor
        clearButton.layer.borderColor = UIColor.red.cgColor
        
        
        model.childrenSort()
        childrenTableView.reloadData()
    }

    @IBAction func addChildBtnAction(_ sender: UIButton) {
        model.addChild()
        model.childrenSort()
        showHideAddBtn()
        childrenTableView.reloadData()
    }
    
    @IBAction func clearBtnAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Удалить все данные?", message: "Удаление", preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "Очистить", style: .default) { _ in
            model.clearAllData()
            self.showHideAddBtn()
            self.adulteName.text = ""
            self.adultAge.text = ""
            self.childrenTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "отмена", style: .cancel) { _ in
            return
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func showHideAddBtn() {
        (model.childrenList.count == 5) ? (addChild.isHidden = true) : (addChild.isHidden = false)
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.childrenList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = childrenTableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as? ChildrenTableViewCell else {return ChildrenTableViewCell()}
                
        cell.data = model.childrenList[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewController:ChildrenTabelViewCellDelegate {
    
    func updateCell(id:Int, newName:String, newAge:Int) {
        model.updateChild(id: id, newName: newName, newAge: newAge)
        childrenTableView.reloadData()
        hideKeyboard()
    }
    
    func deleteCell(id: Int) {
        model.deleteChild(id: id)
        showHideAddBtn()
        childrenTableView.reloadData()
        hideKeyboard()
    }
}




