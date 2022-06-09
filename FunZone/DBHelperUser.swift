//
//  DBHelperUser.swift
//  FunZone
//
//  Created by Xavier on 6/2/22.
//

import Foundation
import UIKit
import CoreData

class DBHelpUser {
    static var dbHelperUser = DBHelpUser() //accessible without a DBHelperUser instance
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}

extension DBHelpUser { //CRUD operations
    //CRUD - Creation
    func createUser(username : String, password : String) {
        //new instance of NSEntity User
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.username = username
        user.password = password
        
        //save to db
        do {
            try context?.save()
            print("User created.")
        } catch {
            print("Error: User not created.")
        }
    }
    //CRUD - Reading
    func readUser(username : String) -> User {
        var user = User() //declare the user instance to be returned
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User") //create request to fetch data from entity User
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        fetchRequest.fetchLimit = 1 //to fetch only one record from db
        do {
            let result = try context?.fetch(fetchRequest) as! [User]
            if result.count != 0 {
                user = result.first as! User
                print("User \(username) found.")
            } else {
                print("No user found.")
            }
        } catch {
            print("Error: Cannot read User info.")
        }
        return user
    }
    func userDoesExist(username : String) -> Bool {
        var userDoesExist = false
        var user = User() //declare the user instance to be returned
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User") //create request to fetch data from entity User
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        fetchRequest.fetchLimit = 1 //to fetch only one record from db
        do {
            let result = try context?.fetch(fetchRequest) as! [User]
            if result.count != 0 {
                user = result.first as! User
                print("User \(username) found.")
                userDoesExist = true
            } else {
                print("No user found.")
                userDoesExist = false
            }
        } catch {
            print("Error: Cannot read User info.")
        }
        return userDoesExist
    }
    
    //CRUD - Updating (password)
    func updateUser(username : String, password : String) {
        var user = User()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        fetchRequest.fetchLimit = 1 //to fetch only one record from db
        do {
            let result = try context?.fetch(fetchRequest)
            if result?.count != 0 {
                user = result?.first as! User
                user.password = password
                try context?.save()
                print("Password changed.")
            }
        } catch {
            print("Error: Cannot change password.")
        }
    }
    
    //CRUD - Deletion
    func deleteUser(username : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        do {
            let result = try context?.fetch(fetchRequest)
            context?.delete(result?.first as! User)
            try context?.save()
            print("User deleted.")
        } catch {
            print("Error: User not deleted.")
        }
    }
}
