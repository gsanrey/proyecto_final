//
//  evento.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 4/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import Foundation

class Evento {
    var nombre: String? = nil
    var descripcion: String? = nil
    var fecha: NSDate? = nil

    
    init(nombre: String, descripcion: String, fecha: String){
        self.nombre = nombre
        self.descripcion = descripcion
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(fecha)
        self.fecha = date
    }
}
