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
    
    var dataPersistence: DataPersistence<CardsInfo>!
    
    override func loadView() {
        view = searchView
    }
    
    private var savedStatus = false
    
    public var onlineCards = [CardsInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9198673368, green: 0.923560679, blue: 0.992310226, alpha: 1)
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(FlashcardCell.self, forCellWithReuseIdentifier: "cardsCell")
        loadData()
    }
    
    private func loadData() {
        do{
            onlineCards = try CardsAPIClient.getCard()
        } catch {
            print("no data found: \(error)")
        }
    }
    
}



extension SearchOnlineController: UICollectionViewDelegateFlowLayout {
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

extension SearchOnlineController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onlineCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath) as?
            FlashcardCell else {
                fatalError("could not downcast to SearchCell")
        }
        
        let selectedCard = onlineCards[indexPath.row]
        
        cell.backgroundColor = .white
        cell.layer.borderWidth = 4
        cell.configureCell(for: selectedCard)
        cell.state = CellState.searchVC
        cell.delegate = self
        
        return cell
    }
    
}

extension SearchOnlineController: CellDelegate {
    func didEdit(_ cardCell: FlashcardCell, _ flashcard: CardsInfo) {
        
        savedStatus = dataPersistence.hasItemBeenSaved(flashcard)
        
        if savedStatus == true {
            let alert = UIAlertController(title: "Card already saved!", message: "Please choose another flashcard", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            do {
                try dataPersistence.createItem(flashcard)
                print("saved flashcard")
            } catch {
                print("could not save flashcard")
            }
            
        }
    }
    
}
