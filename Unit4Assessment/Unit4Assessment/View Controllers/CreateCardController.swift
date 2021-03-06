//
//  CreateCardController.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardController: UIViewController {

    private let createCardsView = CreateCardsView()
    public var dataPersistence: DataPersistence<CardsInfo>!
    
    override func loadView() {
        view = createCardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9198673368, green: 0.923560679, blue: 0.992310226, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButtonPressed(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
        createCardsView.titleText.delegate = self
        createCardsView.descripText.delegate = self
        createCardsView.secondDescripText.delegate = self
    }
    
    @objc private func createButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Empty field!", message: "Please enter a title/description", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: nil))
        
        if createCardsView.titleText.text == ""{
            present(alert, animated: true)
            } else
            if createCardsView.descripText.text.isEmpty {
            present(alert, animated: true)
        } else if createCardsView.secondDescripText.text.isEmpty {
            present(alert, animated: true)
        }
        
        let newCard = CardsInfo(cardTitle: createCardsView.titleText.text ?? "", facts: [createCardsView.descripText.text, createCardsView.secondDescripText.text])
        
        
        if !newCard.cardTitle.isEmpty, !newCard.facts.isEmpty {
        do {
            try dataPersistence.createItem(newCard)
            print("saved card")
        } catch {
            print("could not create card: \(error)")
        }
        
        let cardsVC = CardsViewController()
        cardsVC.dataPersistence = dataPersistence
        navigationController?.pushViewController(cardsVC, animated: true)
        }
    }
}

extension CreateCardController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension CreateCardController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        textView.text = ""
    }
    
}
