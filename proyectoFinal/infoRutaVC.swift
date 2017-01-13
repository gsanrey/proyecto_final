//
//  infoRutaVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import MapKit

class infoRutaVC: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, UITextFieldDelegate  {

    var ruta: cRuta? = nil

    @IBOutlet weak var eNombre: UITextField!
    @IBOutlet weak var eDescripcion: UITextField!
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var botonComparte: UIBarButtonItem!
    
    private var miCamara = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Información de la ruta"
        let button1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "comparte")
        self.navigationItem.rightBarButtonItem = button1
        
        
        eNombre.delegate = self
        eDescripcion.delegate = self
        
        eNombre.text = self.ruta?.nombre
        eDescripcion.text  = self.ruta?.descripcion
        if let fotoHecha = ruta?.foto{
            foto.image = fotoHecha
        }
        mapa.delegate = self
        
        for anotacion in (ruta?.puntosDeInteres)!{
            let pin = MKPointAnnotation()
            pin.title = anotacion.nombre
            pin.coordinate = anotacion.coordenada!
            mapa.addAnnotation(pin)
            //mapa.centerCoordinate = anotacion.coordenada!
        }
        
        let centro = ruta!.camino[0]
        let region = MKCoordinateRegionMakeWithDistance(centro, 3000, 3000)
        mapa.setRegion(region, animated: true)
        mapa.centerCoordinate = centro
        
        let polyline = MKPolyline(coordinates: &(ruta!.camino), count: ruta!.camino.count)
        mapa.addOverlay(polyline, level: MKOverlayLevel.AboveRoads)
        
        miCamara.delegate = self
    }
    
    func comparte(){
        var objetosParaCompartir = ["Los Puntos de Interés visitados!"]
        for pInteres in (ruta?.puntosDeInteres)!{
            objetosParaCompartir.append(pInteres.nombre!)
        }
        let actividadRD = UIActivityViewController(activityItems: objetosParaCompartir, applicationActivities: nil)
        actividadRD.title = "Compartición de Puntos de Interés"
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            actividadRD.popoverPresentationController?.sourceView = self.view
        }
        self.presentViewController(actividadRD, animated: true, completion: nil)
    }

    @IBAction func guarda(sender: UIButton) {
        ruta?.descripcion = eDescripcion.text!
        ruta?.nombre = eNombre.text!
    }

    @IBAction func hacerFoto(sender: UIButton) {
        miCamara.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(miCamara, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        foto.image = image
        ruta?.foto = image
        miCamara.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        miCamara.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 3.0
        return renderer
    }
    
    @IBAction func comparte(sender: UIBarButtonItem) {
        print ("Vamos a compartir la ruta!")
        var elementos: [AnyObject] = []
        elementos.append(self.ruta!.nombre)
        elementos.append(self.ruta!.descripcion)

        let actividadRD = UIActivityViewController(activityItems: elementos, applicationActivities: nil)
        actividadRD.popoverPresentationController?.sourceView = self.view
        self.presentViewController(actividadRD, animated: true, completion: nil)
        
        
    }

    @IBAction func ocultaTeclado(sender: UITextField){
        sender.resignFirstResponder() // oculta el teclado al pulsar Intro
    }
    @IBAction func pulsaFondoOcultaTeclado(sender: UIControl){
        eNombre.resignFirstResponder()
        eDescripcion.resignFirstResponder()
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if control == view.rightCalloutAccessoryView{
            print("HOLAAAAA")
            
            //Perform a segue here to navigate to another viewcontroller
            // On tapping the disclosure button you will get here
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("nextView") as! ComoLlegarVC
            //self.presentViewController(nextViewController, animated:true, completion:nil)
            let puntoLugar = MKPlacemark(coordinate: (view.annotation?.coordinate)!, addressDictionary: nil)
            nextViewController.destino = MKMapItem(placemark: puntoLugar)
            nextViewController.destino.name = (view.annotation?.title)!
            
            self.showViewController(nextViewController, sender:self)
            //let ve = UIStoryboardSegue(identifier: "nextViewq", source: self, destination: nextViewController)
            //self.prepareForSegue(ve, sender: self)
            
        }
    }
    
    // Here we add disclosure button inside annotation window
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        print("viewForannotation")
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            //println("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        let button = UIButton(type: UIButtonType.DetailDisclosure)
        //.buttonWithType(UIButtonType.DetailDisclosure) as UIButton // button with info sign in it
        pinView?.rightCalloutAccessoryView = button
        return pinView
    }
    
}
