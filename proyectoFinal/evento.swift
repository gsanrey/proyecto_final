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
    
    init(nombre: String, descripcion: String){
        self.nombre = nombre
        self.descripcion = descripcion
    }
}
