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

        view.backgroundColor = .yellow
        //add bar button  items here
        
        //delegate for text field
    }
    
    //functions for button items here
}
