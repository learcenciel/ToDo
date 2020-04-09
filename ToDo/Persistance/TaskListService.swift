//
//  TaskListService.swift
//  ToDo
//
//  Created by Alexander on 07.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class TaskListService {
    
    var tasks: [Task]?
    
    func createTask(title: String, description: String?, color: [Float]) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        let task = Task(entity: taskEntity, insertInto: managedContext)
        
        let id = UUID()
        
        task.setValue(id, forKey: "id")
        task.setValue(title, forKey: "title")
        task.setValue(color[0], forKey: "red")
        task.setValue(color[1], forKey: "green")
        task.setValue(color[2], forKey: "blue")
        
        if let description = description {
            task.setValue(description, forKey: "descript")
        }
        
        do {
            try managedContext.save()
        } catch let error {
            print("Error creating task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(title: String, description: String?, color: [Float], uuId: UUID) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(uuId)")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            
            let objectToUpdate = fetchedResults[0] as! NSManagedObject
            objectToUpdate.setValue(title, forKey: "title")
            objectToUpdate.setValue(description, forKey: "descript")
            
            objectToUpdate.setValue(color[0], forKey: "red")
            objectToUpdate.setValue(color[1], forKey: "green")
            objectToUpdate.setValue(color[2], forKey: "blue")
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteTask(uuId: UUID) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(uuId)")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            
            let objectToUpdate = fetchedResults[0] as! NSManagedObject
            managedContext.delete(objectToUpdate)
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    
    
    func fetchAllTasks() -> [Task]? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            let tasksResult = results as! [Task]
            
            self.tasks = tasksResult
        } catch let error {
            print("Error fetching tasks: \(error)")
        }
        
        return self.tasks
    }
}
