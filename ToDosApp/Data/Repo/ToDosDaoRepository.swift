//
//  ToDosDaoRepository.swift
//  ToDosApp
//
//  Created by Beste Kocaoglu on 26.05.2024.
//

import Foundation
import RxSwift

class ToDosDaoRepository {
    var toDosList = BehaviorSubject<[ToDos]>(value: [ToDos]())
    
    func save(name:String){
        print("ToDo Save : \(name)")
    }
    
    func update(id: Int, name:String){
        print("ToDos Update : \(id) - \(name)")
    }
    
    func delete(id:Int){
        print("ToDo Delete : \(id)")
    }
    
    func search(searchText:String){
        print("ToDo Search : \(searchText)")
    }
    
    func loadToDos(){
        var list = [ToDos]()
        let toDos1 = ToDos(id: 1, name: "Spor yap")
        let toDos2 = ToDos(id: 2, name: "Ödev")
        let toDos3 = ToDos(id: 3, name: "Alışveriş")
        list.append(toDos1)
        list.append(toDos2)
        list.append(toDos3)
        
        toDosList.onNext(list)//Trigger-Tetikleme
}

}
