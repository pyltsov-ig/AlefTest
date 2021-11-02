//
//  ViewController.swift
//  AlefTest
//
//  Created by Igor Pyltsov on 01.11.2021.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {
    
    /**
     Для требуемой функциональности TextField используются уже готвые элементы, которые загружены с GitHub
     TextFieldEffects
     */
    @IBOutlet weak var adulteName: HoshiTextField!
    @IBOutlet weak var adultAge: HoshiTextField!
    
    @IBOutlet weak var addChild: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var childrenTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        
        adulteName.delegate = self
        adultAge.delegate = self
        
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
        
        /**
         Здесь реализована ActionSheet и обработка нажатий на ее кнопки
         */
        
        let alert = UIAlertController(title: "Удалить все данные?", message: "", preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "очистить", style: .default) { _ in
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
    
    /**
     Показываем или скрываем кнопку добавления данных о ребенке в зависимости от количества элементов в массиве
     */
    func showHideAddBtn() {
        (model.childrenList.count == 5) ? (addChild.isHidden = true) : (addChild.isHidden = false)
    }
    
    /**
     При распознавании касания в любом месте экрана, не занятого TextField, закрываем клавиатуру.
     */
    @IBAction func tapRecognizeAction(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

/**
 Подписываемся на протоколы  UITableViewDelegate, UITableViewDataSource  для работы с TableView данных о детях
 */
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.childrenList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = childrenTableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as? ChildrenTableViewCell else {
            return ChildrenTableViewCell()
        }
                
        cell.data = model.childrenList[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    /**
     Делаем ячейку больше по высоте, чтобы было похоже на то что требуется в задании.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

/**
 Подписываемся на протокол  ChildrenTabelViewCellDelegate чтобы работать с методами  updateCell и  deleteCell,
 делегироваными ChildrenTableViewCell
 */
extension ViewController:ChildrenTabelViewCellDelegate {
    
    func updateCell(id:Int, newName:String, newAge:Int) {
        model.updateChild(id: id, newName: newName, newAge: newAge)
        childrenTableView.reloadData()
        
    }
    
    func deleteCell(id: Int) {
        model.deleteChild(id: id)
        showHideAddBtn()
        childrenTableView.reloadData()
    }
}
/**
 Подписываемся на протол   UITextFieldDelegate  чтобы воспользоваться  методом shouldChangeCharactersIn
 для ограничения набора символов доступных для ввода в поля возраста.
 */

extension ViewController:UITextFieldDelegate {

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == adultAge {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }

}

