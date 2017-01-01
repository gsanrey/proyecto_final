//
//  infoRutaVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import MapKit

class infoRutaVC: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate  {

    var ruta: cRuta? = nil

    @IBOutlet weak var eNombre: UITextField!
    @IBOutlet weak var eDescripcion: UITextField!
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var foto: UIImageView!
    
    private var miCamara = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    /*
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        foto.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        ruta?.foto
        miCamara.dismissViewControllerAnimated(true, completion: nil)
    }*/

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        miCamara.dismissViewControllerAnimated(true, completion: nil)
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
