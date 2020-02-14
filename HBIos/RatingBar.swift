//
//  RatingBar.swift
//  HBIos
//
//  Created by Jonathan on 31/01/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import UIKit

@IBDesignable class RatingBar: UIStackView {
   
    
  
    // MARK: Propriedades
   private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
   // MARK: Inicialização
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    private func setupButtons() {
        
        // Limpe todos os botões existentes
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
           
            // Crie o botão
            let button = UIButton()
            
           
            // Defina as imagens dos botões
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
           
            // Adicionar restrições
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            
            // Defina o rótulo de acessibilidade
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
         
            // Configure a ação do botão
            button.addTarget(self, action: #selector(RatingBar.ratingButtonTapped(button:)), for: .touchUpInside)
            
            
            // Adicione o botão à pilha
            addArrangedSubview(button)
            
            
            // Adicione o novo botão à matriz de botões de classificação
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()

 }
    @objc func ratingButtonTapped(button: UIButton) { guard let index = ratingButtons.index(of: button) else {
        fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
       
        // Calcula a classificação do botão selecionado
        let selectedRating = index + 1
        
        if selectedRating == rating {
          
            // Se a estrela selecionada representa a classificação atual, redefina a classificação para 0.
            rating = 0
        } else {
           
            // Caso contrário, defina a classificação para a estrela selecionada
            rating = selectedRating
        }
    }
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
          
            // Se o índice de um botão for menor que a classificação, esse botão deverá ser selecionado.
            button.isSelected = index < rating
            
           
            // Define a string de dica para a estrela atualmente selecionada
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
        
            // Calcular a cadeia de valor
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            
            // Atribua a string de dica e a string de valor
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

}
