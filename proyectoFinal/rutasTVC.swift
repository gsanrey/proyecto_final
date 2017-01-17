//
//  rutasTVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import CoreLocation
import WatchConnectivity
import CoreData


class rutasTVC: UITableViewController, WCSessionDelegate {
    
    var aRutas: [cRuta]? = nil
    var nueRuta: cRuta? = nil
    
    override func viewWillAppear(animated: Bool) {
        // mucho cuidado
        if let eruta = nueRuta{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if eruta.foto != nil{
                UIImageWriteToSavedPhotosAlbum(eruta.foto!, nil, nil, nil)
            }
            appDelegate.dataController.guardaRuta(eruta.nombre! , descripcion: eruta.descripcion!, foto: "tec", camino: eruta.pasos)
            nueRuta = nil
        }
        
        // comprobacion de la grabacion
        //lectura de las rutas persistentes
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let req = NSFetchRequest()
        req.entity = NSEntityDescription.entityForName("Ruta", inManagedObjectContext: appDelegate.dataController.managedObjectContext)
        do{
            let res = try appDelegate.dataController.managedObjectContext.executeFetchRequest(req)
            print("Vamos a obtener los datos de las rutas que hay ... \(res.count)")
            for i in 0..<res.count{
                let nRuta = res[i] as! Ruta
                print("obtenemos la ruta \(nRuta.nombre) \(nRuta.descripcion)")
                let comprobacionRuta = cRuta(nombre: nRuta.nombre!, descripcion: nRuta.description)
                comprobacionRuta.descripcion = nRuta.descripcion
                comprobacionRuta.foto = UIImage(named: nRuta.foto!)
                let camino = NSKeyedUnarchiver.unarchiveObjectWithData(nRuta.camino as! NSData) as! [CLLocation]
                comprobacionRuta.pasos = camino
                print("\(comprobacionRuta.nombre) \(comprobacionRuta.descripcion)")
                
            }
        }
        catch{
            print("error leer")
            abort()
        }
        
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("comenzamos la tabla de rutas")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "RUTAS"
        
        aRutas = [cRuta]()
        
        // Almacenamiento persistente de varias rutas si no existen datos
        var req = NSFetchRequest()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        req.entity = NSEntityDescription.entityForName("Ruta", inManagedObjectContext: appDelegate.dataController.managedObjectContext)
        do{
            let res = try appDelegate.dataController.managedObjectContext.executeFetchRequest(req)
            if res.count < 1{
                print("Al no haber datos anteriores, creamos un par de ellos")
                // 1 ruta
                var camino = [CLLocation]()
                camino.append(CLLocation(latitude: 19.52748, longitude: -96.92315))
                camino.append(CLLocation(latitude: 19.53748, longitude: -96.94315))
                camino.append(CLLocation(latitude: 19.54748, longitude: -96.93315))
                appDelegate.dataController.guardaRuta("primera" , descripcion: "PRIMERA", foto: "tec", camino: camino)
                // 2 ruta
                camino = [CLLocation]()
                camino.append(CLLocation(latitude: 19.359727, longitude: -99.257700))
                camino.append(CLLocation(latitude: 19.362896, longitude: -99.268846))
                camino.append(CLLocation(latitude: 19.358543, longitude: -99.276304))
                appDelegate.dataController.creaRuta("segunda" , descripcion: "SEGUNDA", foto: "tec", camino: camino)
                appDelegate.dataController.creaRuta("we" , descripcion: "SEGUNDA", foto: "tec", camino: camino)
                appDelegate.dataController.creaRuta("re" , descripcion: "SEGUNDA", foto: "tec", camino: camino)
                appDelegate.dataController.creaRuta("qw" , descripcion: "SEGUNDA", foto: "tec", camino: camino)

            }
        }
        catch{
            abort()
        }

        //lectura de las rutas persistentes
        req = NSFetchRequest()
        req.entity = NSEntityDescription.entityForName("Ruta", inManagedObjectContext: appDelegate.dataController.managedObjectContext)
        do{
            let res = try appDelegate.dataController.managedObjectContext.executeFetchRequest(req)
            print("Vamos a obtener los datos de las rutas que hay ... \(res.count)")
            for i in 0..<res.count{
                let nRuta = res[i] as! Ruta
                print("obtenemos la ruta - \(nRuta.id) - \(nRuta.nombre) \(nRuta.descripcion) ")
                let aniadeRuta = cRuta(nombre: nRuta.nombre!, descripcion: nRuta.description)
                aniadeRuta.descripcion = nRuta.descripcion
                aniadeRuta.foto = UIImage(named: nRuta.foto!)
                let camino = NSKeyedUnarchiver.unarchiveObjectWithData(nRuta.camino as! NSData) as! [CLLocation]
                aniadeRuta.pasos = camino
                aRutas?.append(aniadeRuta)
                print("\(aniadeRuta.nombre) \(aniadeRuta.descripcion)")
                
            }
        }
        catch{
            print("error leer")
            abort()
        }
        
        print("-------------------     y ahora a probar ")
        let rreq = NSFetchRequest()
        rreq.entity = NSEntityDescription.entityForName("Entity", inManagedObjectContext: appDelegate.dataController.managedObjectContext)
            do{
                let res = try appDelegate.dataController.managedObjectContext.executeFetchRequest(rreq)
                for i in 0..<res.count{
                    let d = res[i] as! Entity
                    //print("\(d.a) \(d.b)")
                    
                }

            }
            catch{
                print("error leer")
                abort()
        }

        
        
        // CREACION DE PUNTOS DE INTERÉS
        let coorPtoInteres = CLLocationCoordinate2D(latitude: 19.52748, longitude: -96.92315)
        aRutas![0].puntosDeInteres.append(cPuntoDeInteres(nombre: "prueba", coordenada: coorPtoInteres))
        
    }


    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aRutas!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celda", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = aRutas![indexPath.row].nombre
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    @IBAction func aniade(sender: UIBarButtonItem) {
        print("Añadiendo para probar")
        aRutas!.append(cRuta(nombre: "2", descripcion: "la tercera"))
        self.tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender?.title == "NUEVA"{
            let creaRuta = segue.destinationViewController as! MapaVC
            //let nuevaRuta = cRuta(nombre:  String(aRutas!.count + 1), descripcion: "")
            nueRuta = cRuta(nombre:  String(aRutas!.count + 1), descripcion: "")
            creaRuta.nuevaRuta = nueRuta
            self.aRutas!.append(nueRuta!)
            //self.tableView.reloadData()
            return
        }
        
        let info = segue.destinationViewController as! infoRutaVC
        let ip = self.tableView.indexPathForSelectedRow
        info.ruta = self.aRutas![(ip?.row)!]
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
