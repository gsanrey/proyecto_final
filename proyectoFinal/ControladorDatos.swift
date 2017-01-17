//
//  ControladorDatos.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 17/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class ControladorDatos {
    let managedObjectContext: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext){
        self.managedObjectContext = moc
    }
    
    convenience init?(){
        guard let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd") else{
            return nil
        }
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else{
            return nil
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let persistantStoreFileURL = urls[0].URLByAppendingPathComponent("labase.sqlite")
        
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistantStoreFileURL, options: nil)
        } catch {
            fatalError("Error adding store.")
        }
        self.init(moc: moc)
    }
    
    func guardaEntity(nombre: String ){
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: self.managedObjectContext) as! Entity
        entity.attribute = nombre
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
    
    func guardaRuta(nombre: String, descripcion: String, foto: String, camino: [CLLocation] ){
        let gRuta = NSEntityDescription.insertNewObjectForEntityForName("Ruta", inManagedObjectContext: self.managedObjectContext) as! Ruta
        gRuta.nombre = nombre
        gRuta.descripcion = descripcion
        gRuta.foto = foto
        gRuta.camino = NSKeyedArchiver.archivedDataWithRootObject(camino)
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
    
    
}


