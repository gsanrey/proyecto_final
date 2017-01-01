//
//  obtieneCodigoVC.swift
//  LecturaQR
//
//  Created by Gabriel Urso Santana Reyes on 30/12/16.
//  Copyright © 2016 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import AVFoundation

class obtieneCodigoVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {
    
    var sesion: AVCaptureSession?
    var capa: AVCaptureVideoPreviewLayer?
    var marcoQR: UIView?
    var urls: String? = nil
    
    override func viewDidAppear(animated: Bool) {
        //marcoQR?.frame = CGRectZero
        sesion?.startRunning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Lectura de QR"
        let dispositivo = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
            let entrada = try AVCaptureDeviceInput(device: dispositivo)
            sesion = AVCaptureSession()
            sesion?.addInput(entrada)
            let metaDatos = AVCaptureMetadataOutput()
            sesion?.addOutput(metaDatos)
            metaDatos.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metaDatos.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            capa = AVCaptureVideoPreviewLayer(session: sesion!)
            capa!.videoGravity = AVLayerVideoGravityResizeAspectFill
            capa!.frame = view.layer.bounds
            view.layer.addSublayer(capa!)
            /*
            marcoQR = UIView()
            marcoQR?.layer.borderColor = UIColor.redColor().CGColor
            marcoQR?.layer.borderWidth = 3.0
            view.addSubview(marcoQR!)
            */
            sesion?.startRunning()
   
        }
        catch{
            
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        marcoQR?.frame = CGRectZero
        if (metadataObjects == nil || metadataObjects.count == 0){
            return
        }
        let objetoMetadata = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objetoMetadata.type == AVMetadataObjectTypeQRCode{
            //let objetoBordes = capa?.transformedMetadataObjectForMetadataObject(objetoMetadata as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            //marcoQR?.frame = objetoBordes.bounds
            if (objetoMetadata.stringValue != nil){
                self.urls = objetoMetadata.stringValue
                let veDecodifica = self.navigationController
                print(urls)
                //let navc = self.navigationController
                self.sesion?.stopRunning()
                print(veDecodifica?.title)
                veDecodifica!.performSegueWithIdentifier("direccionCodigo", sender: self)
            }
            
        }
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
