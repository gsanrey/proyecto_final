//
//  rutasTVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import CoreLocation

class rutasTVC: UITableViewController {
    
    var aRutas = [cRuta(nombre: "0", descripcion: "la numero uno, primera"), cRuta(nombre: "1", descripcion: "la segunda")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "RUTAS"
        
        let coorPtoInteres = CLLocationCoordinate2D(latitude: 19.52748, longitude: -96.92315)
        aRutas[0].puntosDeInteres.append(PuntoDeInteres(nombre: "prueba", coordenada: coorPtoInteres))
        aRutas[0].camino.append(CLLocationCoordinate2D(latitude: 19.52748, longitude: -96.92315))
        aRutas[0].camino.append(CLLocationCoordinate2D(latitude: 19.53748, longitude: -96.94315))
        aRutas[0].camino.append(CLLocationCoordinate2D(latitude: 19.54748, longitude: -96.93315))

        aRutas[1].camino.append(CLLocationCoordinate2D(latitude: 19.359727, longitude: -99.257700))
        aRutas[1].camino.append(CLLocationCoordinate2D(latitude: 19.362896, longitude: -99.268846))
        aRutas[1].camino.append(CLLocationCoordinate2D(latitude: 19.358543, longitude: -99.276304))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return aRutas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celda", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = aRutas[indexPath.row].nombre
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
        aRutas.append(cRuta(nombre: "2", descripcion: "la tercera"))
        self.tableView.reloadData()
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender?.title == "NUEVA"{
            let creaRuta = segue.destinationViewController as! MapaVC
            var nuevaRuta = cRuta(nombre:  String(aRutas.count + 1), descripcion: "")
            creaRuta.nuevaRuta = nuevaRuta
            self.aRutas.append(nuevaRuta)
            self.tableView.reloadData()
            return
        }
        
        let info = segue.destinationViewController as! infoRutaVC
        let ip = self.tableView.indexPathForSelectedRow
        info.ruta = self.aRutas[(ip?.row)!]
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
