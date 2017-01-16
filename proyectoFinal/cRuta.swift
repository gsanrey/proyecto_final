//
//  cRuta.swift
//  final
//
//  Created by Gabriel Urso Santana Reyes on 28/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class cRuta{
    var nombre: String? = ""
    var descripcion: String? = ""
    //var camino = [CLLocationCoordinate2D]()
    var pasos = [CLLocation]()

    var foto: UIImage? = nil
    
    var puntosDeInteres: [cPuntoDeInteres] = [cPuntoDeInteres]()
    

    init(nombre: String, descripcion: String){
        self.nombre = nombre
        self.descripcion = descripcion
    }
      /*  
    init(ruta: cRuta){
        self.nombre = ruta.nombre
        self.descripcion = ruta.descripcion
        self.puntosDeInteres = ruta.puntosDeInteres
    }
 */
    /*
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.nombre = decoder.decodeObjectForKey("nombre") as? String
        self.descripcion = decoder.decodeObjectForKey("descripcion") as? String
        self.foto = decoder.decodeObjectForKey("foto") as? UIImage
        self.camino = decoder.decodeObjectForKey("camino") as! [CLLocationCoordinate2D]
    }
    convenience init(nombre: String, descripcion: String) {
        self.init()
        self.nombre = nombre
        self.descripcion = descripcion
    }
    override func encodeWithCoder(coder: NSCoder) {
        if let nombre = nombre { coder.encodeObject(nombre, forKey: "nombre") }
        if let descripcion = descripcion { coder.encodeObject(descripcion, forKey: "descripcion") }
        
    }
*/
    

    
}
