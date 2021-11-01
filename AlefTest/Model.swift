//
//  Model.swift
//  AlefTest
//
//  Created by Igor Pyltsov on 01.11.2021.
//

import Foundation


struct Child {
    var id: Int = 0
    var name: String = ""
    var age:Int = 0
}

class Model {
    
    var childrenList = [Child]()
    private var primaryKey = 0
    
    func childrenSort(){
        self.childrenList.sort {
            ($0.id ) > ($1.id )
        }
    }

    func addChild() {
        primaryKey += 1
        let child = Child(id: primaryKey, name: "", age: 0)
        childrenList.append(child)
        print(primaryKey)
    }
    
    func updateChild(id:Int, newName:String, newAge: Int){
        
        guard let index = childrenList.firstIndex(where: {$0.id == id})
        else {return}
        
        childrenList[index].name = newName
        childrenList[index].age = newAge
        
    }
    
    func deleteChild(id:Int) {
        
        guard let index = childrenList.firstIndex(where: {$0.id == id})
        else {return}
        
        childrenList.remove(at: index)
    }
    
    func clearAllData() {
        childrenList.removeAll()
    }
    
      

}

var model = Model()

