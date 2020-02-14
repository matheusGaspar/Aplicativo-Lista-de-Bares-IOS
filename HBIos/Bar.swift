//
//  Bar.swift
//  HBIos
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import UIKit
import os.log

class Bar: NSObject, NSCoding {
    
    //@Author:Matheus Pereira
    //Data:14/02/2020
    
    //Salva os campos em relação a suas chaves,usando o encode e o Decoder pasando os objetos,pegando pelos determinados campos.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(telefone, forKey: PropertyKey.telefone)
        aCoder.encode(endereco, forKey: PropertyKey.endereco)
    
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
      
        // O nome é obrigatório. Se não pudermos decodificar uma string de nome, o inicializador falhará.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Bar object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let endereco = aDecoder.decodeObject(forKey: PropertyKey.endereco) as? String else {
            os_log("Unable to decode the name for a Bar object.", log: OSLog.default, type: .debug)
            return nil
        }
        
     
        // Como a foto é uma propriedade opcional do Meal, use apenas conversão condicional.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        guard let telefone = aDecoder.decodeObject(forKey: PropertyKey.telefone) as? String else {
            os_log("Unable to decode the name for a Bar object.", log: OSLog.default, type: .debug)
            return nil
        }
        
     
        // Deve chamar o inicializador designado.
        self.init(name: name, photo: photo, rating: rating, telefone: telefone, endereco: endereco)
    }
    

    /*
   // Substitua apenas draw () se você executar um desenho personalizado.
     // Uma implementação vazia afeta negativamente o desempenho durante a animação.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    // MARK: Propriedades
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var telefone: String
    var endereco: String
  
    

    
    
    // MARK: Inicialização
    
    init?(name: String, photo: UIImage?, rating: Int,telefone: String,endereco: String) {
        
     // A inicialização falhará se não houver nome ou se a classificação for negativa.
        if name.isEmpty || rating < 0  {
            return nil
        }
        if telefone.isEmpty && endereco.isEmpty{
            return nil
        }
        
      
        // Inicialize propriedades armazenadas.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.telefone = telefone
        self.endereco = endereco
       
        
        
    }
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let telefone = "telefone"
        static let endereco = "endereco"
        
    }
    
    // MARK: caminhos de arquivamento
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bar")
}

