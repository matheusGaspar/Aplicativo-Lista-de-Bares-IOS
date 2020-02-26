//
//  BarTableViewController.swift
//  HBIos
//
//  Created by Jonathan on 04/02/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import UIKit
import os.log

class BarTableViewController: UITableViewController {

    //@AUTOR:Matheus Pereira
    //Data:14/10/2020
  // MARK: Propriedades
    
    
    var bar = [Bar]()
    //MARK: Actions
    @IBAction func unwindToBarList(sender: UIStoryboardSegue) {
        print("--------------")
        if let sourceViewController = sender.source as? ViewController, let bares = sourceViewController.bar {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
              
                // Atualiza uma barra existente.
                bar[selectedIndexPath.row] = bares
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
                // Adicione um novo bar.
                let newIndexPath = IndexPath(row: bar.count, section: 0)
                
                bar.append(bares)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
             saveBar()
        }
    }
    
    
    
    
    // MARK: Métodos particulares
    
        private func loadSampleBar() {
        let foto1 = UIImage(named: "ze")
        let foto2 = UIImage(named: "zi")
        let foto3 = UIImage(named: "zu")
        
        guard let bar1 = Bar(name: "Saint Bar", photo: foto1, rating: 4,telefone: "33972727",endereco: "Rua Curitiba",latitude: -26.920443,longitude:-49.069608) else {
            fatalError("Unable to instantiate bar1")
        }
        
        guard let bar2 = Bar(name: "Bar do zé", photo: foto2, rating: 5,telefone: "33322077",endereco: "Rua São Paulo",latitude: -26.920683,longitude:-49.069604) else {
            fatalError("Unable to instantiate bar2")
        }
        
        guard let bar3 = Bar(name: "Bar Lost", photo: foto3, rating: 3,telefone: "99364294",endereco:"Rua Bahia",latitude:-26.920970,longitude:-49.070019) else {
            fatalError("Unable to instantiate bar3")
        }
        
        bar += [bar1, bar2, bar3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use o item do botão de edição fornecido pelo controlador de exibição de tabela.
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        // Carrega os bares salvos, caso contrário, carrega dados de amostra.
        if let savedBar = loadBar(){
            bar += savedBar
        }
        else {
            
            // Carrega os dados da amostra.
          loadSampleBar()
        }
        
        
    }

    // MARK: - fonte de dados do modo de exibição de tabela

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return bar.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BarTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BarTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BarTableViewCell.")
        }
        
       
        // Busca o bar apropriada para o layout da fonte de dados.
        let bars = bar[indexPath.row]

       // Configure a célula
        
        cell.nameLabel.text = bars.name
        cell.photoImageView.image = bars.photo
        cell.ratingControl.rating = bars.rating
        
        
        return cell
    }
   
    

    
    
    // Substitua para oferecer suporte à edição condicional da exibição da tabela.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
   
    // Substitua para suportar a edição da exibição da tabela.
    // Substitua para suportar a edição da exibição da tabela.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Exclua a linha da fonte de dados
            bar.remove(at: indexPath.row)
             saveBar()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
           // Crie uma nova instância da classe apropriada, insira-a na matriz e adicione uma nova linha à visualização da tabela
        }
    }
   

    /*
    
     // Substitua para dar suporte à reorganização da exibição da tabela.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Retorna false se você não deseja que o item seja reordenado.
        return true
    }
 

    
    
    // MARK: - Navegação

    
    // Em um aplicativo baseado em storyboard, muitas vezes você deseja fazer uma pequena preparação antes da navegação
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new bar.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let barDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBarCell = sender as? BarTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBarCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBar = bar[indexPath.row]
            barDetailViewController.bar = selectedBar
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
     private func saveBar() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(bar, toFile: Bar.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Bar successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save bar...", log: OSLog.default, type: .error)
        }
    }
      private func loadBar() -> [Bar]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }

}
