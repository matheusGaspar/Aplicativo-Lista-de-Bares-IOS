//
//  BarTableViewCell.swift
//  HBIos
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//



import UIKit


class BarTableViewCell: UITableViewCell {
    //@AUTOR:Matheus Pereira
    //Data:14/02/2020
    // MARK: Propriedades
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingBar!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
   // Código de inicialização
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure a visualização para o estado selecionado
    }
    

}
