//
//  PuntoDeInteresVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class PuntoDeInteresVC: UIViewController {

    @IBOutlet weak var tNombre: UITextField!
    @IBOutlet weak var tDescripcion: UITextView!
    
    var puntoDeInteres: PuntoDeInteres? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func guardar(sender: UIButton) {
        puntoDeInteres?.nombre = tNombre.text

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
