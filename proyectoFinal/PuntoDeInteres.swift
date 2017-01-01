//
//  puntoDeInteres.swift
//  final
//
//  Created by Gabriel Urso Santana Reyes on 29/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import Foundation
import CoreLocation

class PuntoDeInteres{
    var nombre: String? = nil
    var coordenada: CLLocationCoordinate2D? = nil
    
    init(nombre: String, coordenada: CLLocationCoordinate2D){
        self.nombre = nombre
        self.coordenada = coordenada
    }
}