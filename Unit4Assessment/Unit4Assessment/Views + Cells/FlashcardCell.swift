//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

public enum CellState{
    case cardsVC
    case searchVC
}

protocol CellDelegate: AnyObject {
    func didEdit(_ cardCell: FlashcardCell, _ flashcard: CardsInfo )
}

class FlashcardCell: UICollectionViewCell {
    
    public lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(favoritedCard(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question: "
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        return label
    }()
    
    public lazy var descriptionText: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        tv.layer.cornerRadius = 4
        tv.alpha = 0.0
        tv.isEditable = false
        return tv
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    
    var state = CellState.cardsVC
    
    //MARK:// - Current card and state
    public var delegate: CellDelegate!
    private var currentCard: CardsInfo!
    private var isShowingDescript = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpQuestionLabelConstraints()
        setUpFavoriteButtonConstraints()
        setUpDescriptionTextConstraints()
        addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        
        let duration = 1.0
        
        isShowingDescript.toggle()
        
        if isShowingDescript {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.descriptionText.alpha = 1.0
                self.questionLabel.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.descriptionText.alpha = 0.0
                self.questionLabel.alpha = 1.0
            }, completion: nil)

        }
        
    }
    
    @objc private func favoritedCard(_ sender: UIButton) {
        if state == CellState.cardsVC{
            delegate.didEdit(self, currentCard)
        } else{
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            delegate.didEdit(self, currentCard)
        }
    }
    
    
    private func setUpQuestionLabelConstraints() {
        addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpFavoriteButtonConstraints() {
        addSubview(favoriteButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpDescriptionTextConstraints() {
        addSubview(descriptionText)
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionText.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
    }
    
    public func configureCell(for card: CardsInfo) {
        currentCard = card
        if state == CellState.searchVC {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        questionLabel.text = card.cardTitle
        descriptionText.text = "\(card.facts.first ?? "") \(card.facts.last ?? "") "
    }
}
