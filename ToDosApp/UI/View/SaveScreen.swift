//
//  SaveScreen.swift
//  ToDosApp
//
//  Created by Beste Kocaoglu on 25.05.2024.
//

import UIKit

class SaveScreen: UIViewController {
    @IBOutlet weak var textFieldName: UITextField!
    
    var viewModel = SaveViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Save Screen"
    }

    @IBAction func buttonSave(_ sender: Any) {
        if let name = textFieldName.text {// Optinal binding (if let)
            viewModel.save(name: name)
        }
    }
    
}
