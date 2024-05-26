//
//  ToDosDaoRepository.swift
//  ToDosApp
//
//  Created by Beste Kocaoglu on 26.05.2024.
//

import Foundation
import RxSwift

class ToDosDaoRepository {
    var toDosList = BehaviorSubject<[ToDosModel]>(value: [ToDosModel]())
    
    let contex = appDelegate.persistentContainer.viewContext
    
    func save(name:String){
        let toDo = ToDosModel(context: contex)
        toDo.name = name
        
        appDelegate.saveContext()
        
    }
    
    func update(toDo: ToDosModel, name:String){
        toDo.name = name
        
        appDelegate.saveContext()
       
    }
    
    func delete(toDo:ToDosModel){
        contex.delete(toDo)
        
        appDelegate.saveContext()
       
    }
    
    func search(searchText:String){
        do {
            let fr = ToDosModel.fetchRequest()
            fr.predicate = NSPredicate(format: "name CONTAINS[c]%@", searchText)
            let list = try contex.fetch(fr)
            toDosList.onNext(list)//Trigger-Tetikleme
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
    func loadToDos(){
        do {
            let fr = ToDosModel.fetchRequest()
            let list = try contex.fetch(fr)
            toDosList.onNext(list)//Trigger-Tetikleme
        } catch{
            print(error.localizedDescription)
        }
}

}
