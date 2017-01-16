//
//  ARCV.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 13/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import CoreLocation

class ARCV: UIViewController, ARDataSource, CLLocationManagerDelegate {

    private let manejador = CLLocationManager()
    var rutaActual: cRuta? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        iniciaRAG()
    }

    
    func iniciaRAG(){
        let puntosDeInteresAR = situaPuntosDeInteres(rutaActual!)
        
        let arViewController = ARViewController()
        arViewController.debugEnabled = true
        arViewController.dataSource = self
        arViewController.maxDistance = 0
        arViewController.maxVisibleAnnotations = 100
        arViewController.maxVerticalLevel = 5
        arViewController.headingSmoothingFactor = 0.05
        arViewController.trackingManager.userDistanceFilter = 25
        arViewController.trackingManager.reloadDistanceFilter = 75
        
        arViewController.setAnnotations(puntosDeInteresAR)
        //arViewController.set
        self.presentViewController(arViewController, animated: true, completion: nil)
    }
    
    private func situaPuntosDeInteres(ruta: cRuta) -> Array<ARAnnotation>{
        var anotaciones: [ARAnnotation] = []
        for i in ruta.puntosDeInteres        {
            let anotacion = ARAnnotation()
            let localiza = CLLocation(latitude: (i.coordenada?.latitude)! , longitude: i.coordenada!.longitude)
            anotacion.location = localiza
            anotacion.title = i.nombre
            anotaciones.append(anotacion)
        }
        return anotaciones
    }
    
    func ar(arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let vista = TestAnnotationView()
        vista.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.5)
        vista.frame = CGRect(x: 0,y: 0,width: 150,height: 60)
        return vista
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            self.manejador.startUpdatingLocation()
        }else{
            self.manejador.stopUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(manager.location!.coordinate.latitude)  - \(manager.location!.coordinate.longitude) . \(manager.location!.horizontalAccuracy)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alerta = UIAlertController(title: "ERROR", message: "error \(error.code)", preferredStyle: .Alert)
        let accionOK = UIAlertAction(title: "OK", style: .Default, handler: {accion in
            //..
        })
        alerta.addAction(accionOK)
        self.presentViewController(alerta, animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
