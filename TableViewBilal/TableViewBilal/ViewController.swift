//
//  ViewController.swift
//  TableViewBilal
//
//  Created by Bilal Gökpinar / BBS2H20A on 09.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    // Unsere DataSource
    var games = ["Far Cry 6", "Battlefield 2042", "GTA"]
    
    
    @IBOutlet weak var MyTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyTableView.dataSource = self
        MyTableView.delegate = self
        
        // Hinzufügen dess Edit-Button
        navigationItem.rightBarButtonItem = editButtonItem
        
        // Title
        title = "Games"
        
        //leere UIView um die Tableview zu "kürzen"
        MyTableView.tableFooterView = UIView()
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        print ("Set Editing")
        
        // Wenn Editing False ist, wird es auf True gesetzet und auch umgekehrt
        super.setEditing(!isEditing, animated: true)
        MyTableView.setEditing(!MyTableView.isEditing, animated: true)
    }


}

// Erweiterung unserer Klasse ViewController
extension ViewController: UITableViewDataSource{
    
    // Wieviele Zellen(Cells) sollen erstellt werden
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    // Wie sollen die Cells aussehen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let myCell = MyTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            myCell.textLabel?.text = games[indexPath.row]
            return myCell
    }
}


// Erweiterung unserer Klasse ViewController
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    // Funktion zum Verschieben der Cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    
    // Konstante für die ausgewählte Cell
        let selectedGame = games[sourceIndexPath.row]
        
    // Funktion zum Löschen der Cell im Array
        games.remove(at: sourceIndexPath.row)
        
    // Funktion zum Einfügen des neuen Wertes im Array
        games.insert(selectedGame, at: destinationIndexPath.row)
        
    // Funktion zum Löschen der Cells
        func tableView( tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            
            if editingStyle == .delete {
                // Löschen aus dem Array
                games.remove(at: indexPath.row)
                
                // Löschen aus der TableView
                MyTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
