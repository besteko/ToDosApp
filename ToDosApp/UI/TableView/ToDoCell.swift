//
//  ToDoCell.swift
//  ToDosApp
//
//  Created by Beste Kocaoglu on 25.05.2024.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    
    var cellProtocol: CellProtocol?
       var indexPath: IndexPath?
       
       override func awakeFromNib() {
           super.awakeFromNib()
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
       
       @IBAction func buttonDelete(_ sender: Any) {
           print("Delete button clicked")
           cellProtocol?.buttonDeleteClicked(indexPath: indexPath!)
       }
   }

   protocol CellProtocol {
       func buttonDeleteClicked(indexPath: IndexPath)
   }

