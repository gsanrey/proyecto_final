//
//  Ruta+CoreDataProperties.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 15/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ruta {

    @NSManaged var nombre: String?
    @NSManaged var descripcion: String?
    @NSManaged var foto: String?
    @NSManaged var camino: NSObject?

}
