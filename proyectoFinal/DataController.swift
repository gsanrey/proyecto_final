//
//  DataController.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 15/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class DataController {
    let managedObjectContext: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext){
        self.managedObjectContext = moc
    }
    
    convenience init?(){
        guard let modelURL = NSBundle.mainBundle().URLForResource("RutaModels", withExtension: "momd") else{
            return nil
        }
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else{
            return nil
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let persistantStoreFileURL = urls[0].URLByAppendingPathComponent("Bookmarks.sqlite")
        
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistantStoreFileURL, options: nil)
        } catch {
            fatalError("Error adding store.")
        }
        self.init(moc: moc)
    }
    
    func guardaRuta(nombre: String, descripcion: String, foto: String, camino: [CLLocation] ){
        let nuevaRuta = NSEntityDescription.insertNewObjectForEntityForName("Ruta", inManagedObjectContext: self.managedObjectContext) as! Ruta
        
        nuevaRuta.nombre = nombre
        nuevaRuta.descripcion = descripcion
        nuevaRuta.foto = foto
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(camino)
        nuevaRuta.camino = data
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
}
