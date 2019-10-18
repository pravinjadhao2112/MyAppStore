//
//  DataBaseHandler.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import Foundation
import CoreData

class DataBaseHandler: NSObject {
    private static var instance : DataBaseHandler?
    
    class func sharedInstance() -> DataBaseHandler{
        if instance == nil{
            instance = DataBaseHandler()
        }
        return instance!
    }
    
    func createManagedObject(tableName : String) -> NSManagedObject {
        
        return NSEntityDescription.insertNewObject(forEntityName: tableName, into: self.getManagedObjectContext())
    }
    
    func fetchData(tableName : String,predicate : NSPredicate?,sortDiscriptor :NSSortDescriptor? ) -> [AnyObject]? {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: tableName)
        if predicate != nil {
            fetchRequest.predicate = predicate
        }
        
        if sortDiscriptor != nil{
            fetchRequest.sortDescriptors = [sortDiscriptor!]
        }
        do{
            let result = try self.getManagedObjectContext().fetch(fetchRequest)
            if result.count > 0 {
                return result as [AnyObject]?
            }else{
                return []
            }
        }catch{
            return nil
        }
    }
    
    func deleteRecord(tableName : String,predicate : NSPredicate?) -> Bool {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: tableName)
        if(predicate != nil){
            fetchRequest.predicate = predicate
        }
        do{
            let result = try self.getManagedObjectContext().fetch(fetchRequest)
            
            for obj in result{
                if let manageObject = obj as? NSManagedObject{
                    self.getManagedObjectContext().delete(manageObject)
                }
            }
            return self.saveContext()
        }catch{
            return false
        }
    }
    
    func getManagedObjectContext() -> NSManagedObjectContext {
        
        if #available(iOS 10.0, *) {
            return self.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            return self.managedObjectContext
        }
    }
    
    // MARK:- Core Data stack
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        
        
        let container = NSPersistentContainer(name: "MyAppStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () -> Bool {
        
        // Fallback on earlier versions
        
        var context = self.managedObjectContext
        if #available(iOS 10.0, *) {
            
            context = persistentContainer.viewContext
        }
        if context.hasChanges {
            
            do {
                
                try context.save()
                return true
            } catch {
                
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
        }
        return false
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = Bundle.main.url(forResource: "MyAppStore", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("MyAppStore.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let myOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                             NSInferMappingModelAutomaticallyOption: true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: myOptions)
        } catch {
            
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}
