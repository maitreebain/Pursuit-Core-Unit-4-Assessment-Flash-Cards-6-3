//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsViewController: UIViewController {
    
    private let cardsView = CardsView()
    public var dataPersistence: DataPersistence<CardsInfo>!
    
    override func loadView() {
        view = cardsView
    }
    
    public var cardItem: CardsInfo?
    
    var cards = [CardsInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.cardsView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        cardsView.collectionView.delegate = self
        cardsView.collectionView.dataSource = self
        
        //register cell here
        cardsView.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardsCell")
    }
    
    private func loadFavorites() {
        do {
            cards = try dataPersistence.loadItems()
        } catch {
            print("no items available")
        }
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 1
        let itemHeight: CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath)
        
        cell.backgroundColor = .blue
        
        return cell
    }
    
}

//needs DP extension here
extension CardsViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadFavorites()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadFavorites()
    }
    
    
}
