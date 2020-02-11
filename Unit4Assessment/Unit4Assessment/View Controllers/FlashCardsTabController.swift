//
//  FlashCardsTabController.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardsTabController: UITabBarController {
    
    private var dataPersistence = DataPersistence<CardsInfo>(filename: "flashcards.plist")
    
    private lazy var cardsController: CardsViewController = {
       let viewcontroller = CardsViewController()
        viewcontroller.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "rectangle.dock"), tag: 0)
        viewcontroller.dataPersistence = dataPersistence
        return viewcontroller
    }()
    
    private lazy var createCardController: CreateCardController = {
       let viewcontroller = CreateCardController()
        viewcontroller.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        viewcontroller.dataPersistence = dataPersistence
        return viewcontroller
    }()
    
    private lazy var searchCardsController: SearchOnlineController = {
       let viewcontroller = SearchOnlineController()
        //data persistence
        viewcontroller.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        viewcontroller.dataPersistence = dataPersistence
        return viewcontroller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [UINavigationController(rootViewController: cardsController),
                           UINavigationController(rootViewController: createCardController),
                           UINavigationController(rootViewController: searchCardsController)
        ]
    }
    


}

