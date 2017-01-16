//
//  RutasIC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 14/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class RutasIC: WKInterfaceController, WCSessionDelegate {
    let datos = ["uno", "uno", "uno","dos", "dos", "dos"]
    
    @IBAction func concectar() {
        print("datos \(counterData)")
    }
    
    var counterData = [String]()
    var session: WCSession!
    
    @IBOutlet var tablaRutas: WKInterfaceTable!
    
    override init() {
        super.init()
        loadTableData()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        let counterValue = message["counterValue"] as? String
        
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        dispatch_async(dispatch_get_main_queue()) {
            self.counterData.append(counterValue!)
            print(self.counterData)
        }
    }
    
    private func loadTableData(){
        tablaRutas.setNumberOfRows(datos.count, withRowType: "Row")
        
        if (WCSession.isSupported()) {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            
        }
        do {
            let applicationDict = ["r1":"ruta1", "r2":"ruta2"]
            try WCSession.defaultSession().updateApplicationContext(applicationDict)
        } catch {
            // Handle errors here
        }
        
        for nruta in 0..<datos.count{
            print(nruta)
            /*
            let row = tablaRutas.rowControllerAtIndex(nruta) as! Row
            row.nombre.setText(datos[1])
            row.fecha.setText(datos[1])
            row.descripcion.setText(datos[1])
 */
        }
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
