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
    
    //@AUTOR:Matheus Pereira
    //Data:14/10/2020
    

    @IBOutlet weak var nomeBartextfield: UITextField!
    @IBOutlet weak var enderecoTextFiel: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ratingEstrela: RatingBar!
    @IBOutlet weak var Latitude: UITextField!
    @IBOutlet weak var Longitude: UITextField!
    /*
     
     Este valor é passado por `BarTableViewController` em` prepare (para: remetente:) `
     ou construído como parte da adição de uma novo Bar.
     */
    var bar: Bar?
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Dependendo do estilo de apresentação (apresentação modal ou push), esse controlador de exibição precisa ser descartado de duas maneiras diferentes.
        let isPresentingInAddBarMode = presentingViewController is UINavigationController
        
        if isPresentingInAddBarMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    
    }
    
   
    // Este método permite configurar um controlador de exibição antes de ser apresentado.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("-------------prepare")
        super.prepare(for: segue, sender: sender)
        // Configure o controlador da visualização de destino apenas quando o botão Salvar for pressionado.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nomeBartextfield.text ?? ""
        let photo = Image.image
        let rating = ratingEstrela.rating
        let telefone = telefoneTextField.text ?? ""
        let endereco = enderecoTextFiel.text ?? ""
        let latitude = (Latitude.text! as NSString).floatValue
        let longitude = (Longitude.text! as NSString).floatValue
        
       
        
        
        // Defina o bar a ser passada para BarTableViewController após o desenrolar.
        bar = Bar(name: name, photo: photo, rating: rating,telefone: telefone,endereco: endereco,latitude: latitude,longitude:longitude)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeBartextfield.delegate = self
        enderecoTextFiel.delegate = self
        telefoneTextField.delegate = self
        enderecoTextFiel.delegate = self
        Longitude.delegate = self
        Latitude.delegate = self
    
        Image.layer.borderWidth = 1
        Image.layer.masksToBounds = false
        Image.layer.borderColor = UIColor.black.cgColor
        Image.layer.cornerRadius = Image.frame.height/2
        Image.clipsToBounds = true
        
        if let bar = bar {
            navigationItem.title = bar.name
            nomeBartextfield.text = bar.name
            Image.image = bar.photo
            ratingEstrela.rating = bar.rating
            telefoneTextField.text = bar.telefone
            enderecoTextFiel.text = bar.endereco
            Latitude.text = String(bar.latitude)
            Longitude.text = String(bar.longitude)
            
            
           
        }
        
        updateSaveButtonState()
        
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
    self.dismiss(animated: true, completion: nil)

   }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = nomeBartextfield.text
    }
  
    // MARK: Métodos particulares
    private func updateSaveButtonState() {
        
        // Desabilite o botão Salvar se o campo de texto estiver vazio.
        let text = nomeBartextfield.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
