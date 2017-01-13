//
//  EventosTVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 4/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class EventosTVC: UITableViewController {

    var eventos = [Evento]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "Listado de Eventos"
        eventos.append(Evento(nombre: "primer evento", descripcion: "es una prueba"))
        eventos.append(Evento(nombre: "segundo evento", descripcion: "es una prueba"))
        sincroniza()
    }

    func sincroniza() {
        print ("Obteniendo listado de alumnos")
        let jsonURL = NSURL(string: "http://localhost:8000/eventos/")!
        /*
         let sessionConfiguration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
         let session = NSURLSession(configuration: sessionConfiguration)
         */
        
        let datos = NSData(contentsOfURL: jsonURL)
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves )
            let evento = json as! NSDictionary
            let eventos = evento["eventos"] as! NSArray
            let nombre = eventos[2]["nombre"] as! NSString
            let descripcion = eventos[1]["descripcion"] as! NSString
            print(nombre, descripcion)
            /*
            for asignatura in asignaturas{
                print("---------Asignatura \(asignatura["nombre"])--------------")
                for alumno in asignatura["alumnos"] as! NSArray{
                    let id = Int(alumno["id"] as! Int)
                    print("el id del alumno es: \(id)")
                }
                print("-")
            }
            */

        }
        catch _ {
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventos.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("evento", forIndexPath: indexPath) as! EventoCell
        cell.eNombre.text = eventos[indexPath.row].nombre
        cell.bComparte.tag = indexPath.row
        cell.bComparte.addTarget(self, action: "comparteEvento", forControlEvents: .TouchUpInside)
        return cell
    }

    @IBAction func comparteEvento(sender: UIButton) {
        var elementos: [AnyObject] = []
        elementos.append(self.eventos[sender.tag].nombre!)
        elementos.append(self.eventos[sender.tag].descripcion!)
        
        let actividadRD = UIActivityViewController(activityItems: elementos, applicationActivities: nil)
        actividadRD.popoverPresentationController?.sourceView = self.view
        self.presentViewController(actividadRD, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
