//
//  DecodificadoQRVC.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class DecodificadoQRVC: UIViewController {

    @IBOutlet weak var eDecodificacion: UILabel!
    @IBOutlet weak var web: UIWebView!
    
    var url: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eDecodificacion.text = url
        web.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
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
