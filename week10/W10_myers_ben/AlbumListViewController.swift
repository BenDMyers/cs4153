//
//  AlbumListViewController.swift
//  W10_myers_ben
//
//  Created by MYERS BENJAMIN D on 10/31/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit
import CoreData

class AlbumListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var albumCreator = UIAlertController()
    var fetchedResultsController : NSFetchedResultsController<Album>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cannot fetch app delegate")
            return
        }
        // Get persistent managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Album> = Album.fetchRequest()
        
        // Set sort descriptors for fetched data
        let sortDescriptor_title = NSSortDescriptor(key: "title", ascending: true)
        let sortDescriptor_artist = NSSortDescriptor(key: "artist", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor_title, sortDescriptor_artist]
        
        fetchedResultsController = NSFetchedResultsController<Album>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: #keyPath(Album.title), cacheName: "albumCache")
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        }
        catch let error as NSError {
            print("Cannot load data \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController?.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Album", for: indexPath)
        
        // Get the record we want to use.
        let album = fetchedResultsController.object(at: indexPath)

        // Configure the cell...
        cell.textLabel?.text = album.title
        cell.detailTextLabel?.text = album.artist! + " · " + String(album.year_of_release)

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let cell = self.tableView(tableView, cellForRowAt: indexPath)
            print(cell.textLabel?.text)
            
            let fetchRequest: NSFetchRequest<Album> = Album.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "title = '\(cell.textLabel?.text ?? "")' AND artist = '\(cell.detailTextLabel?.text?.components(separatedBy: " · ")[0] ?? "")'")

//            fetchRequest.predicate = NSPredicate(format: "title = '\(cell.textLabel?.text ?? "")'")
            
            print(fetchRequest.predicate)
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print("Can't get delegate")
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            do {
                var records = try managedContext.fetch(fetchRequest)
                if(records.count > 0) {
                    managedContext.delete(records[0])
                }
                try managedContext.save()
                //self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.reloadData()
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SongListViewController {
            if let send = sender as? UITableViewCell {
                destination.title = send.textLabel?.text
                destination.albumTitle = (send.textLabel?.text)!
                destination.artist = (send.detailTextLabel?.text?.components(separatedBy: " · ")[0])!
            }
        }
    }

    // Handles album creation alert
    @IBAction func addAlbum(_ sender: UIBarButtonItem) {
        
        albumCreator = UIAlertController(title: "Add Album", message: "Enter the album's title, artist, and release year.", preferredStyle: .alert)
        
        // TITLE FIELD
        albumCreator.addTextField { (textField) in textField.placeholder = "Album title"
            textField.addTarget(self, action: #selector(self.textFieldsChanged(_:)), for: .editingChanged)
        }
        
        // ARTIST FIELD
        albumCreator.addTextField { (textField) in textField.placeholder = "Artist"
            textField.addTarget(self, action: #selector(self.textFieldsChanged(_:)), for: .editingChanged)
        }
        
        // RELEASE YEAR FIELD
        albumCreator.addTextField { (textField) in
            textField.keyboardType = UIKeyboardType.numberPad
            textField.placeholder = "Release year"
            textField.addTarget(self, action: #selector(self.textFieldsChanged(_:)), for: .editingChanged)
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let save = UIAlertAction(title: "Save", style: .default, handler: {(action) in self.saveAlbum(creator: self.albumCreator)})
        
        save.isEnabled = false
        
        albumCreator.addAction(cancel)
        albumCreator.addAction(save)
        
        self.present(albumCreator, animated: true, completion: nil)
    }

    // Actually saves album to core data
    func saveAlbum(creator: UIAlertController) {
        // Get the app delegate.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cannot fetch app delegate")
            return
        }
        
        // Use the app delegate object to get the managed context.
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let album = Album(entity: Album.entity(), insertInto: managedContext)
        album.title = creator.textFields![0].text?.trim()
        album.artist = creator.textFields![1].text?.trim()
        album.year_of_release = Int16(creator.textFields![2].text!)!
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Cannot save data: \(error)")
        }
    }
    
    // Determines whether any fields are empty, and
    // enables/disables the Save action accordingly
    @objc func textFieldsChanged(_ textField: UITextField) {
        if let alert = presentedViewController as? UIAlertController, let action = alert.actions.last {
            var anyEmpty = false
            for field in alert.textFields! {
                if field.text?.characters.count == 0 {
                    anyEmpty = true
                }
            }
            if anyEmpty {
                action.isEnabled = false
            }
            else {
                action.isEnabled = true
            }
        }
    }
}
