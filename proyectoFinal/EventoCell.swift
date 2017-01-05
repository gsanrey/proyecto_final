//
//  EventoCell.swift
//  proyectoFinal
//
//  Created by Gabriel Urso Santana Reyes on 4/1/17.
//  Copyright © 2017 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class EventoCell: UITableViewCell {


    @IBOutlet weak var eNombre: UILabel!
    @IBOutlet weak var eDescripcion: UILabel!
    @IBOutlet weak var bComparte: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
