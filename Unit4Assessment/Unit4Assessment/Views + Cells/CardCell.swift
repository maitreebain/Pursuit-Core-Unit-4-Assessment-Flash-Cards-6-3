//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol CardCellDelegate {
    func didEdit(_ cardCell: CardCell, _ flashcard: CardsInfo )
}

class CardCell: UICollectionViewCell {
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        //add gesture target here
        return gesture
    }()
    
    public lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipses.circle"), for: .normal)
        button.addTarget(self, action: #selector(editButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private var delegate: CardCellDelegate!
    private var currentCard: CardsInfo!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
    }
    
    //needs a button for edit
    @objc private func editButtonPressed(_ sender: UIButton) {
        delegate.didEdit(self, currentCard)
    }
    
}
