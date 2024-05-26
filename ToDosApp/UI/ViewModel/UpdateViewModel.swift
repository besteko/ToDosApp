//
//  UpdateViewModel.swift
//  ToDosApp
//
//  Created by Beste Kocaoglu on 26.05.2024.
//

import Foundation

class UpdateViewModel{
    var toDosRepo = ToDosDaoRepository()
    
    func update(toDo: ToDosModel, name:String){
        toDosRepo.update(toDo: toDo, name: name)
    }

}
