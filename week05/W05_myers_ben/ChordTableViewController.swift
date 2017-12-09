//
//  ChordTableViewController.swift
//  W05_myers_ben
//
//  Created by MYERS BENJAMIN D on 9/21/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit

class ChordTableViewController: UITableViewController {
    @IBOutlet var ChordTable: UITableView!
    
    var chords = [
        (name: "A", aFret: 0, eFret: 0, cFret: 1, gFret: 2),
        (name: "B", aFret: 2, eFret: 2, cFret: 3, gFret: 4),
        (name: "C", aFret: 3, eFret: 0, cFret: 0, gFret: 0),
        (name: "D", aFret: 0, eFret: 2, cFret: 2, gFret: 2),
        (name: "E", aFret: 2, eFret: 0, cFret: 4, gFret: 1),
        (name: "F", aFret: 0, eFret: 1, cFret: 0, gFret: 2),
        (name: "G", aFret: 2, eFret: 3, cFret: 2, gFret: 0),
        (name: "Am", aFret: 0, eFret: 0, cFret: 0, gFret: 2),
        (name: "Bm", aFret: 2, eFret: 2, cFret: 2, gFret: 4),
        (name: "Cm", aFret: 3, eFret: 3, cFret: 3, gFret: 0),
        (name: "Dm", aFret: 0, eFret: 1, cFret: 2, gFret: 2),
        (name: "Em", aFret: 2, eFret: 3, cFret: 4, gFret: 0),
        (name: "Fm", aFret: 3, eFret: 1, cFret: 0, gFret: 1),
        (name: "Gm", aFret: 1, eFret: 3, cFret: 2, gFret: 0),
        (name: "A7", aFret: 0, eFret: 0, cFret: 1, gFret: 0),
        (name: "B7", aFret: 2, eFret: 2, cFret: 3, gFret: 2),
        (name: "C7", aFret: 1, eFret: 0, cFret: 0, gFret: 0),
        (name: "D7", aFret: 3, eFret: 2, cFret: 2, gFret: 2),
        (name: "E7", aFret: 2, eFret: 0, cFret: 2, gFret: 1),
        (name: "F7", aFret: 3, eFret: 1, cFret: 3, gFret: 2),
        (name: "G7", aFret: 2, eFret: 1, cFret: 2, gFret: 0)
    ]
    
    
    // Enables view controller responding to touch events
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
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
        return chords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Chord", for: indexPath)
        
        // Configure the cell...
        let chord = chords[indexPath.row]
        let frets = String(chord.gFret) + String(chord.cFret) + String(chord.eFret) + String(chord.aFret)
        cell.textLabel?.text = chord.name
        cell.detailTextLabel?.text = frets
        
        return cell
    }
    
    // Given the name of a chord, return its index in the chords array
    func getChordIndexByName(name: String) -> Int {
        for(i, ch) in chords.enumerated() {
            if name == ch.name {
                return i
            }
        }
        return -1
    }
    
    // Let ChordViewController know which chord to display
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let destination = segue.destination as? ChordViewController {
            destination.chord = chords[getChordIndexByName(name: (cell.textLabel?.text)!)]
        }
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

