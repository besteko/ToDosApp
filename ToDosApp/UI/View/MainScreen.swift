//
//  ViewController.swift
//  ToDosApp
//
//  Created by Beste Kocaoglu on 25.05.2024.
//

import UIKit

class MainScreen: UIViewController {

    @IBOutlet weak var toDosTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var toDosList = [ToDosModel]()
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ToDos"
        
        setUpTheme()
        
        searchBar.delegate = self
        toDosTableView.delegate = self
        toDosTableView.dataSource = self
        
        _ =  viewModel.toDosList.subscribe(onNext: {list in
            self.toDosList = list
            self.toDosTableView.reloadData()
            
        })
                
    }
    override func viewWillAppear(_ animated: Bool) {
        //Sayfa her göründüğünde çalışır
        //Bu sayfaya geri dönüldüğünde çalışır
        viewModel.loadToDos()
    }
    
    
    func setUpTheme() {
        
        let apperence = UINavigationBarAppearance()
        
        apperence.backgroundColor = UIColor(named: "MainColor")
        apperence.titleTextAttributes = [.foregroundColor: UIColor(named: "AlternativeColor1")!, .font: UIFont(name: "Pacifico-Regular", size: 22)!]
        
        navigationController?.navigationBar.tintColor = UIColor(named: "AlternativeColor1")
        navigationController?.navigationBar.standardAppearance = apperence
        navigationController?.navigationBar.compactAppearance = apperence
        navigationController?.navigationBar.scrollEdgeAppearance = apperence
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare çalıştı")
        if segue.identifier == "toUpdate" {
            print("toUpdate çalıştı")
            if let toDo = sender as? ToDosModel {//Downcasting(Superclass >Subclass)
                let destinationVC = segue.destination as! UpdateScreen
                destinationVC.toDo = toDo
                
            }
        }
    }
    
}

extension MainScreen : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
        if searchText == "" {
            viewModel.loadToDos()
        } else {
            viewModel.search(searchText: searchText)
        }
    }
}

extension MainScreen : UITableViewDelegate,UITableViewDataSource, CellProtocol {
    
    func buttonDeleteClicked(indexPath: IndexPath) {
        let toDo = self.toDosList[indexPath.row]
        print("ToDo Delete : \(toDo)")
        
        let alert = UIAlertController(title: "Delete Process", message: "Do you want to delete the \(toDo.name!)?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
            self.viewModel.delete(toDo: toDo)
            
        }
        alert.addAction(yesAction)
        
        self.present(alert, animated: true)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return toDosList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoCell
            
            let toDo = toDosList[indexPath.row]
            
            cell.labelName.text = toDo.name
            
            cell.cellProtocol = self
            cell.indexPath = indexPath
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let toDo = toDosList[indexPath.row]
            performSegue(withIdentifier: "toUpdate", sender: toDo)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        //right - trailing , left - leading
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction,view,bool in
                let toDo = self.toDosList[indexPath.row]
                print("ToDo Delete : \(toDo)")
                
                let alert = UIAlertController(title: "Delete Process", message: "Do you want to delete the \(toDo.name!)?", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancelAction)
                
                let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                    self.viewModel.delete(toDo: toDo)
                    
                }
                alert.addAction(yesAction)
                
                self.present(alert, animated: true)
                
            }
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    }

