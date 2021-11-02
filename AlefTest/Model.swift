//
//  Model.swift
//  AlefTest
//
//  Created by Igor Pyltsov on 01.11.2021.
//

import Foundation

/**
 Структура Child для описания ребенка. id нужен для сортировки и для поиска элементов при удалении и редактировании.
 */
struct Child {
    var id: Int = 0
    var name: String = ""
    var age:Int = 0
}

/**
 Класс модель предназначен для  выполнения всех манипуляций с данными. Все компоненты программы имеют
 доступ к данным тоолько через методы и свойства экземпляра класса.
 */

class Model {
    
    /**
     Массив для хранения списка детей.
     */
    var childrenList = [Child]()
    
    /**
     primaryKey служит для хранения последнего максимального номера id в массиве childrenList.
     Значение primaryKey инкрементируется при каждом добавлении ребенка. Никогда не сбрасывается.
     Таким образом id будет всегда уникальным. Конечно так не делается обычно, но тут для скорости  я сделал.
     */
    private var primaryKey = 0
    
    /**
     Сортировка нужна для того чтобы при добавлении ребенка блок появлялся вверху TableView
     */
    func childrenSort(){
        self.childrenList.sort {
            ($0.id ) > ($1.id )
        }
    }
    
    /**
     Добавление данных ребенке
     */

    func addChild() {
        primaryKey += 1
        let child = Child(id: primaryKey, name: "", age: 0)
        childrenList.append(child)
        print(primaryKey)
    }
    
    /**
     Редактирование данных о ребенке
     */
    
    func updateChild(id:Int, newName:String, newAge: Int){
        
        guard let index = childrenList.firstIndex(where: {$0.id == id})
        else {return}
        
        childrenList[index].name = newName
        childrenList[index].age = newAge
        
    }
    
    /**
     Удаление данных о ребенке
     */
    
    func deleteChild(id:Int) {
        
        guard let index = childrenList.firstIndex(where: {$0.id == id})
        else {return}
        
        childrenList.remove(at: index)
    }
    
    /**
     Очистка массива
     */
    
    func clearAllData() {
        childrenList.removeAll()
    }
    
      

}
/**
 Создаем экземпляр model для работы
 */
var model = Model()

