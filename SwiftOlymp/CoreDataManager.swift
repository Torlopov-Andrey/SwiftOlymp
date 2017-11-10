//
//  CoreDataStack.swift
//  TinkoffTest
//
//  Created by Andrey Torlopov on 10/8/17.
//  Copyright © 2017 Andrey Torlopov. All rights reserved.
//

import Foundation
import CoreData

enum CDEntities {
    case news, newsDetail
    
    var title: String {
        switch self  {
        case .news:
            return "News"
        case .newsDetail:
            return "DetailNews"
        }
    }
    
    var entity: NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: self.title, in: CoreDataManager.instance.context)!
    }
    
    var newManagedObject: NSManagedObject {
        return NSManagedObject(entity: self.entity, insertInto: CoreDataManager.instance.context)
    }
}

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let projectName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        let container = NSPersistentContainer(name: projectName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchedResultsController(entityName: String,
                                  keyForSort: String,
                                  ascending: Bool) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: CoreDataManager.instance.context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }

    func saveContext (completion: (() -> ())? = nil) {
        if self.context.hasChanges {
            do {
                try self.context.save()
                if let c = completion { c() }
            }
            catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
