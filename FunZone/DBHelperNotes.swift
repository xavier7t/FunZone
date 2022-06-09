//
//  DBHelperNotes.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import Foundation
import UIKit
import CoreData



class DBHelpNotes {
    static var dbHelperNotes = DBHelpNotes() //accessible without a DBHelperUser instance
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}

extension DBHelpNotes { //CRUD Operations
    //CRUD - Creation
    func createNote(title : String, body : String) {
        //new instance of NSEntity Note
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context!) as! Note
        note.title = title
        note.body = body
        
        //save to db
        do {
            try context?.save()
            print("Note created.")
        } catch {
            print("Error: Note not created.")
        }
    }
    
    //CRUD - Reading
    func readNote(title : String) -> Note {
        var note = Note()
        let fetechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetechRequest.predicate = NSPredicate(format: "title == %@", title)
        fetechRequest.fetchLimit = 1
        do {
            let result = try context?.fetch(fetechRequest) as! [Note]
            if result.count != 0 {
                note = result.first as! Note
                print("Found a note named: \(title).")
            } else {
                print("No note found.")
            }
        } catch {
            print("Error: Cannot read Note info.")
        }
        return note
    }
    func readNote() -> [Note] { //overloading readNote() function to obtain an array of all notes to populate the tableView
        var noteArr = [Note]()
        let fetechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            noteArr = try context?.fetch(fetechRequest) as! [Note]
        } catch {
            print("Error: Cannot read Note info.")
        }
        return noteArr
    }
    
    func noteTitleDoesExist(title : String) -> Bool {
        var noteTitleDoesExist = false
        var note = Note() //declare the ntoe instance to be returned
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note") //create request to fetch data from entity User
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.fetchLimit = 1 //to fetch only one record from db
        do {
            let result = try context?.fetch(fetchRequest) as! [Note]
            if result.count != 0 {
                note = result.first as! Note
                print("Note \(title) found.")
                noteTitleDoesExist = true
            } else {
                print("No note found.")
                noteTitleDoesExist = false
            }
        } catch {
            print("Error: Cannot read Note info.")
        }
        return noteTitleDoesExist
    }
    
    //CRUD - Updating (body)
    func updateNote(title : String, body : String) {
        var note = Note()
        let fetechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetechRequest.predicate = NSPredicate(format: "title == %@", title)
        fetechRequest.fetchLimit = 1
        do {
            let result = try context?.fetch(fetechRequest)
            if result?.count != 0 {
                note = result?.first as! Note
                note.body = body
                try context?.save()
                print("Note saved.")
            }
        } catch {
            print("Error: Cannot save note.")
        }
    }
    
    //CRUD - Deletion
    func deleteNote(title : String) {
        var fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchReq.predicate = NSPredicate(format: "title == %@", title)
        do {
            let note = try context?.fetch(fetchReq)
            context?.delete(note?.first as! Note)
            try context?.save()
            print("Note deleted.")
        } catch {
            print("Error. Data not deleted.")
        }
    }
}
