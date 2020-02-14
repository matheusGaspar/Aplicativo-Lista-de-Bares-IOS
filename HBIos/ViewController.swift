//
//  ViewController.swift
//  HBIos
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    @IBOutlet weak var nomeBartextfield: UITextField!
    @IBOutlet weak var enderecoTextFiel: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingBar!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var bar: Bar?
    
    //MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameLabel.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        bar = Bar(name: name, photo: photo, rating: rating)
    }
    
   


    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeBartextfield.delegate = self
        enderecoTextFiel.delegate = self
        telefoneTextField.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nomeCampo: String!
        switch textField{
        case nomeBartextfield:
        nomeCampo = "Bar:"
            break;
        case enderecoTextFiel:
            nomeCampo = "Endereco:"
            break;
        default:
            nomeCampo = "OutroCampo:"
            break;
           
        }
        let message = nomeCampo+textField.text!
        print(message)
        return true
    }
    
    @IBAction func Botao(_ sender: Any) {
        print("Bar:" + nomeBartextfield.text!)
        print("Endereco:" + enderecoTextFiel.text!)
        print("OutroCampo:" + telefoneTextField.text!)
        
        
    }
    @IBAction func gestor(_ sender: Any) {
        let image  = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            
        }
        
    }
    
    @IBAction func `import`(_ sender: Any) {
        let image  = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            
        }
        
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            Image.image = image
        }
    else{
    
    }
    self.dismiss(animated: true, completion: nil)

   }
}
