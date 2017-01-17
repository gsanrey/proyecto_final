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
        let persistantStoreFileURL = urls[0].URLByAppendingPathComponent("labase0.sqlite")
        
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
    
    func creaRuta(nombre: String, descripcion: String, foto: String, camino: [CLLocation] ){
        // Creación de una nueva ruta
        let nuevaRuta = NSEntityDescription.insertNewObjectForEntityForName("Ruta", inManagedObjectContext: self.managedObjectContext) as! Ruta
        nuevaRuta.nombre = nombre
        nuevaRuta.descripcion = descripcion
        nuevaRuta.foto = foto
        nuevaRuta.camino = NSKeyedArchiver.archivedDataWithRootObject(camino)
        
        let req = NSFetchRequest()
        req.entity = NSEntityDescription.entityForName("Ruta", inManagedObjectContext: self.managedObjectContext)
        do{
            let res = try self.managedObjectContext.executeFetchRequest(req)
            nuevaRuta.id = res.count + 1
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context or execute search")
        }
        
    }
    
    func guardaRuta(nombre: String, descripcion: String, foto: String, camino: [CLLocation]? ){
        let gRuta = NSEntityDescription.insertNewObjectForEntityForName("Ruta", inManagedObjectContext: self.managedObjectContext) as! Ruta
        gRuta.nombre = nombre
        gRuta.descripcion = descripcion
        gRuta.foto = foto
        if camino != nil{
            gRuta.camino = NSKeyedArchiver.archivedDataWithRootObject(camino!)
        }
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
    
    
}


