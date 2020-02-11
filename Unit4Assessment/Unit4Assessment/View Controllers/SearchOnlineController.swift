//
//  SearchOnlineController.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchOnlineController: UIViewController {
    
    private let searchView = SearchOnlineView()
    public var dataPersistence: DataPersistence<CardsInfo>!
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .blue
        
    }
    

}
