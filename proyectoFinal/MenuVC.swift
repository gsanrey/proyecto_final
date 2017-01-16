//
//  MenuVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import WatchConnectivity

class MenuVC: UIViewController, WCSessionDelegate {

    @IBOutlet weak var pruebaConexionWatch: UIButton!
    @IBAction func pruebaConexionReloj(sender: UIButton) {
        print("vamos a conectar! \(conecta)")
        let applicationData = ["counterValue":String(conecta)]
        
        session!.sendMessage(applicationData, replyHandler: {(_: [String : AnyObject]) -> Void in
            // handle reply from iPhone app here
            }, errorHandler: {(error ) -> Void in
                // catch any errors here
        })
        conecta = conecta + 1
    }
    
    var session: WCSession? = nil
    var conecta = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session!.delegate = self
            session!.activateSession()
            
        }
        do {
            let applicationDict = ["r1":"ruta1", "r2":"ruta2"]
                try WCSession.defaultSession().updateApplicationContext(applicationDict)
        } catch {
            // Handle errors here
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func acerdaDe(sender: UIButton) {
        let ventana = UIAlertController(title: "Acerca de", message: "Proyecto Final de Desarrollo de Aplicaciones iOS. Aplicación desarrollada por ©Gabriel Urso Santana Reyes ", preferredStyle: UIAlertControllerStyle.Alert)
        ventana.addAction(UIAlertAction(title: "continuar", style: UIAlertActionStyle.Default, handler: { (nil) in
            print("continuamos...")
            
        }))
        self.presentViewController(ventana, animated: true, completion: nil)

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
