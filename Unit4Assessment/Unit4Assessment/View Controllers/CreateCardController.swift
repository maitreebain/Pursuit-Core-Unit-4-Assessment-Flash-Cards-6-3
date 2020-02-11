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
    public var card: CardsInfo?
    
    override func loadView() {
        view = createCardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButtonPressed(_:)))
        //delegate for text field
        createCardsView.titleText.delegate = self
        createCardsView.descripText.delegate = self
        createCardsView.secondDescripText.delegate = self
    }
    
    //functions for button items here
    @objc private func createButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Empty field!", message: "Please enter a title/description", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: nil))
        
        if createCardsView.titleText.text == ""{
            present(alert, animated: true)
            } else if createCardsView.descripText.text.isEmpty || createCardsView.descripText.text == "Enter description here" {
            present(alert, animated: true)
        } else if createCardsView.secondDescripText.text.isEmpty || createCardsView.secondDescripText.text == "Enter description here" {
            present(alert, animated: true)
        }
        
        let newCard = CardsInfo(cardTitle: createCardsView.titleText.text ?? "", facts: [createCardsView.descripText.text, createCardsView.secondDescripText.text])
        
        do {
            try dataPersistence.createItem(newCard)
        } catch {
            print("could not create card: \(error)")
        }
        
    }
}

extension CreateCardController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension CreateCardController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}
