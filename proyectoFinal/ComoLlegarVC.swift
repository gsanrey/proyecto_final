//
//  ComoLlegarVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 10/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import MapKit

class ComoLlegarVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapaRuta: MKMapView!
    var destino: MKMapItem!
    var origen: MKMapItem!

    let localizador = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.localizador.delegate = self
        self.localizador.desiredAccuracy = kCLLocationAccuracyBest
        self.localizador.requestWhenInUseAuthorization()
        
        mapaRuta.delegate = self
        
        let puntoCoor = CLLocationCoordinate2D(latitude: 37.33157962, longitude: -122.03054783)
        let puntoLugar = MKPlacemark(coordinate: puntoCoor, addressDictionary: nil)
        destino = MKMapItem(placemark: puntoLugar)
        destino.name = "..."
    }

    func obtenerRuta(origen: MKMapItem, destino: MKMapItem){
        let solicitud: MKDirectionsRequest = MKDirectionsRequest()
        solicitud.source = origen
        solicitud.destination = destino
        solicitud.transportType = .Walking
        let indicaciones = MKDirections(request: solicitud)
        indicaciones.calculateDirectionsWithCompletionHandler({
            (respuesta: MKDirectionsResponse?, error: NSError?) in
            if error != nil{
                print("Error al obtener la ruta")
            }else{
                self.muestraRuta(respuesta!)
            }
            
        })
    }
    func muestraRuta(respuesta: MKDirectionsResponse){
        for ruta in respuesta.routes{
            mapaRuta.addOverlay(ruta.polyline, level: MKOverlayLevel.AboveRoads)
            for paso in ruta.steps{
                print(paso.instructions)
            }
        }
        let centro = origen.placemark.coordinate
        let region = MKCoordinateRegionMakeWithDistance(centro, 3000, 3000)
        mapaRuta.setRegion(region, animated: true)
        
    }
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            self.localizador.startUpdatingLocation()
            mapaRuta.showsUserLocation = true
        }else{
            self.localizador.stopUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let punto = manager.location{
            print("\(manager.location!.coordinate.latitude)  - \(manager.location!.coordinate.longitude) . \(manager.location!.horizontalAccuracy)")
            let puntoLugar =  MKPlacemark(coordinate: punto.coordinate, addressDictionary: nil)
            origen = MKMapItem(placemark: puntoLugar)
            origen.name = "POSICION ACTUAL"

        }
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
