//
//  ChildrenTableViewCell.swift
//  AlefTest
//
//  Created by Igor Pyltsov on 01.11.2021.
//

import UIKit
import TextFieldEffects

protocol ChildrenTabelViewCellDelegate {
    func updateCell(id:Int, newName:String, newAge:Int)
    func deleteCell(id:Int)
}

class ChildrenTableViewCell: UITableViewCell {

    @IBOutlet weak var childNameField: HoshiTextField!
    @IBOutlet weak var childAgeField: HoshiTextField!
    var childId:Int?
    
    var delegate:ChildrenTabelViewCellDelegate?
 
    
    /**
     Переменная Data для получения данных из ViewConroller
     */
    var data:Child? {
        didSet {
            guard data != nil else {
                return
            }
            childNameField.text = data?.name
            childAgeField.text = String(data?.age ?? 0)
            childId = data?.id ?? 0
        }
    }
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        childAgeField.delegate = self
        childNameField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func deleteCellAction(_ sender: UIButton) {
        guard let id = childId else {
            return
        }
        delegate?.deleteCell(id: id)
    }
}


/**
 Подписываемся на протол   UITextFieldDelegate  чтобы воспользоваться  методом shouldChangeCharactersIn
 для ограничения набора символов доступных для ввода в поля возраста.
 */

extension ChildrenTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == childAgeField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    /**
     Так как в задании указано, что данные о детях вводятся и редактируюся в блоке,
     я ловлю событие окончания редактирования TextField и обновляю массив model.childrenList,
     используя делегирование.
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == childNameField {
            guard
                let id = childId,
                let newName = childNameField.text,
                let newAge = Int(childAgeField.text ?? "0")
            else {
                return
            }
            delegate?.updateCell(id: id, newName: newName, newAge: newAge)
        }
        
        if textField == childAgeField {
            guard
                let id = childId,
                let newName = childNameField.text,
                let newAge = Int(childAgeField.text ?? "0")
            else {
                return
            }
            delegate?.updateCell(id: id, newName: newName, newAge: newAge)
        }
    }
}
