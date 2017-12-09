//
//  SongListViewController.swift
//  W10_myers_ben
//
//  Created by MYERS BENJAMIN D on 10/31/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit
import CoreData

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}

class SongListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    public var albumTitle = ""
    public var artist = ""
    var songCreator = UIAlertController()
    var fetchedResultsController : NSFetchedResultsController<Song>!

    @IBOutlet weak var timecodeItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: true)
        updateTimecode()
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Can't fetch app delegate")
            return
        }
        
        let fetchRequest: NSFetchRequest<Song> = Song.fetchRequest()
        
        // Set sort descriptors for fetched data
        let sortDescriptor_title = NSSortDescriptor(key: "title", ascending: true)
        let sortDescriptor_length = NSSortDescriptor(key: "song_length", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor_title, sortDescriptor_length]
        
        // Get persistent managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController<Song>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: #keyPath(Song.title), cacheName: "songCache")
        
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
//        return fetchedResultsController?.sections?.count ?? 0
        return getAlbum(albumTitle: albumTitle).albumRel?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Song", for: indexPath)
        
        // Get the record we want to use.
        let song = getAlbum(albumTitle: albumTitle).albumRel!.allObjects[indexPath[0]]
        
        // Configure the cell...
        cell.textLabel?.text = (song as! Song).title
        cell.detailTextLabel?.text = String(toPrettyTime(length: (song as! Song).song_length))

        return cell
    }
    
    // Converts a double to a nice timecode
    func toPrettyTime(length: Double) -> String {
        let totalMin = Int(floor(length))
        let hours = totalMin/60
        let min = totalMin % 60
        let sec = Int(round((length - Double(totalMin)) * 60))
        var timecode = String(sec) + "s"
        if(totalMin > 0) {
            timecode = String(min) + "m " + timecode
            if(hours > 0) {
                timecode = String(hours) + "h " + timecode
            }
        }
        return timecode
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
            
            let fetchRequest: NSFetchRequest<Song> = Song.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "title = '\(cell.textLabel?.text ?? "")'")
            
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
                updateTimecode()
            } catch let error as NSError {
                print(error)
            }
        }
    }

    // Handles song creation alert
    @IBAction func addSong(_ sender: UIBarButtonItem) {
        songCreator = UIAlertController(title: "Add Song", message: "Enter the song's title and length (as a double, where the double refers to the number of minutes)", preferredStyle: .alert)
        
        // TITLE FIELD
        songCreator.addTextField { (textField) in textField.placeholder = "Song title"
            textField.addTarget(self, action: #selector(self.textFieldsChanged(_:)), for: .editingChanged)
        }
        
        // LENGTH FIELD
        songCreator.addTextField { (textField) in
            textField.keyboardType = UIKeyboardType.decimalPad
            textField.placeholder = "Length"
            textField.addTarget(self, action: #selector(self.textFieldsChanged(_:)), for: .editingChanged)
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let save = UIAlertAction(title: "Save", style: .default, handler: {(action) in self.saveSong(creator: self.songCreator)})
        
        save.isEnabled = false
        
        songCreator.addAction(cancel)
        songCreator.addAction(save)
        
        self.present(songCreator, animated: true, completion: nil)
    }
    
    // Actually saves song to core data
    func saveSong(creator: UIAlertController) {
        // Get the app delegate.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cannot fetch app delegate")
            return
        }
        
        // Use the app delegate object to get the managed context.
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let song = Song(entity: Song.entity(), insertInto: managedContext)
        song.title = creator.textFields![0].text?.trim()
        song.song_length = Double(creator.textFields![1].text!)!
        let album = getAlbum(albumTitle: albumTitle)
        song.songRel = album
        self.updateTimecode()
        
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
    
    func getAlbum(albumTitle: String) -> Album {
        let fetchRequest: NSFetchRequest<Album> = Album.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "title = '\(albumTitle)' AND artist = '\(artist)'")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Can't get delegate")
            return Album()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            var records = try managedContext.fetch(fetchRequest)
            if(records.count > 0) {
                return records[0]
            }
        } catch _ as NSError {
            return Album()
        }
        return Album()
    }
    
    func updateTimecode() {
        timecodeItem.title = toPrettyTime(length: 0.0)
        
        var time = 0.0
        
        for song in getAlbum(albumTitle: albumTitle).albumRel!.allObjects {
            time += (song as! Song).song_length
        }
        
        timecodeItem.title = toPrettyTime(length: time)
    }
}
