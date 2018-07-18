//
//  TableViewController.swift
//  Petty
//
//  Created by Sergio Esteban on 7/07/18.
//  Copyright © 2018 Sergio Esteban. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
var datos = [String]()

class TableViewController: UITableViewController {
    
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    var NewItem = document.data()["name"] as! String
                    print(NewItem)
                    datos.append(NewItem)
                }
            }
            self.tableView.reloadData()
        }
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = datos[indexPath.row]
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.lightGray
        }else{
            cell.backgroundColor = UIColor.white
        }

        return cell
    }
    @IBAction func AddingItem(_ sender: Any) {
        print("Adding")
        
        let alert = UIAlertController(title: "Nuevo Usuario", message: "Ingrese nuevo usuario" , preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Ingrese el nombre"
        }
        
        alert.addAction(UIAlertAction(title: "Agregar", style: .default, handler: { (action) in
            let newUser: String = (alert.textFields?.first?.text)!
            
            var ref: DocumentReference? = nil
            
            ref = db.collection("Users").addDocument(data: [
                "name": newUser
                ])
            datos.append(newUser)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: {(action) -> Void in
        }))
        
        self.present(alert,animated: true,completion: nil)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
