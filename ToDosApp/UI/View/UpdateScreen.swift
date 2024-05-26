//
//  UpdateScreen.swift
//  ToDosApp
//
//  Created by Beste Kocaoglu on 25.05.2024.
//

import UIKit

class UpdateScreen: UIViewController {
    @IBOutlet weak var textFieldName: UITextField!
    
    var toDo:ToDosModel?
    
    var viewModel = UpdateViewModel()

    
    override func viewDidLoad() {  // Bir Kere
        super.viewDidLoad()

        self.navigationItem.title = "Update Screen"
        
        if let t = toDo{
            textFieldName.text = t.name
        }

    }
    @IBAction func buttonUpdate(_ sender: Any) {
        if let t = toDo, let name = textFieldName.text {
            viewModel.update(toDo: t, name: name)
        }
    }
    
    
}
