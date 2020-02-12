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
        cardsView.collectionView.register(FlashcardCell.self, forCellWithReuseIdentifier: "cardsCell")
        dataPersistence.delegate = self
        loadFavorites()
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
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath) as? FlashcardCell else {
            fatalError("could not downcast to CardCell")
        }
        
        cell.backgroundColor = .white
        cell.layer.borderWidth = 4
        
        let selectedItem = cards[indexPath.row]
        
        cell.configureCell(for: selectedItem)
        cell.state = CellState.cardsVC
        cell.delegate = self
        return cell
    }
    
    
}

extension CardsViewController: CellDelegate {
    
    func didEdit(_ cardCell: FlashcardCell, _ flashcard: CardsInfo) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (alertAction) in
            self.delete(card: flashcard)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func delete(card: CardsInfo) {
        guard let index = cards.firstIndex(of: card) else {
            return
        }
        
        do {
            try dataPersistence.deleteItem(at: index)
        }catch {
            print("could not delete item")
        }
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
