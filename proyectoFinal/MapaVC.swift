//
//  MapaVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaVC: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    let localizador = CLLocationManager()
    var nuevaRuta: cRuta? = nil
    
    private var miCamara = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.localizador.delegate = self
        self.localizador.desiredAccuracy = kCLLocationAccuracyBest
        self.localizador.requestWhenInUseAuthorization()
        miCamara.delegate = self
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            self.localizador.startUpdatingLocation()
        }else{
            self.localizador.stopUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let punto = manager.location{
            print("\(manager.location!.coordinate.latitude)  - \(manager.location!.coordinate.longitude) . \(manager.location!.horizontalAccuracy)")
            mapa.centerCoordinate = punto.coordinate
            if nuevaRuta?.camino.count == 0{
                let region = MKCoordinateRegionMakeWithDistance(punto.coordinate, 30, 30)
                mapa.setRegion(region, animated: true)
                mapa.centerCoordinate = punto.coordinate
            }
            nuevaRuta!.camino.append(punto.coordinate)
            let polyline = MKPolyline(coordinates: &(nuevaRuta!.camino), count: nuevaRuta!.camino.count)
            mapa.addOverlay(polyline, level: MKOverlayLevel.AboveRoads)
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

    @IBAction func hacerFoto() {
        miCamara.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(miCamara, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        nuevaRuta!.foto = image
        print("foto tomada")
        miCamara.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        miCamara.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func aniadePuntoInteres(sender: UIButton) {
        
        let vista = UIAlertController(title: "Añade Punto de Interés", message: "...", preferredStyle: UIAlertControllerStyle.Alert)
        let textField = vista.addTextFieldWithConfigurationHandler { (nil) in
            //..
        }
        //textField.placeholder = "Foo!"
        vista.addAction(UIAlertAction(title: "añade", style: UIAlertActionStyle.Default, handler: { (nil) in
            self.nuevaRuta?.puntosDeInteres.append(PuntoDeInteres(nombre: vista.textFields![0].text!, coordenada: (self.nuevaRuta?.camino.last)!))
            let pin = MKPointAnnotation()
            pin.title = vista.textFields![0].text!
            pin.coordinate = (self.nuevaRuta?.camino.last)!
            self.mapa.addAnnotation(pin)
            print(vista.textFields![0].text)
        
        }))
        vista.addAction(UIAlertAction(title: "cancelar", style: UIAlertActionStyle.Default, handler: { (nil) in
            print("Cancelar")
            
        }))
        self.presentViewController(vista, animated: true, completion: nil)
        
    }
    
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 3.0
        return renderer
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
