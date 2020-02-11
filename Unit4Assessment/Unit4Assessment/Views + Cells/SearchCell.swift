//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    //needs button for saving
    public lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(favoritedCard(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question: "
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public lazy var descriptionText: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .red
        return tv
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        //add gesture target here
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    
    //MARK:// - Current card and state
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
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc private func favoritedCard(_ sender: UIButton) {
        
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
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    public func configureCell(for card: CardsInfo) {
        questionLabel.text = card.cardTitle
    }
}
