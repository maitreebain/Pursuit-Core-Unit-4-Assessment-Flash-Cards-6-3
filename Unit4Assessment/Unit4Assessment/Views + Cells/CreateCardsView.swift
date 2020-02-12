//
//  CreateCardsView.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardsView: UIView {
    
    public lazy var titleText: UITextField = {
        let title = UITextField()
        title.placeholder = "enter title here"
        title.backgroundColor = .white
        title.layer.cornerRadius = 4
        return title
    }()
    
    public lazy var descripText: UITextView = {
        let descrip = UITextView()
        descrip.text = "enter description here"
        descrip.font = UIFont(name: "Geeza Pro", size: 17.0)
        descrip.backgroundColor = .white
        descrip.layer.cornerRadius = 4
        return descrip
    }()

    public lazy var secondDescripText: UITextView = {
        let descrip = UITextView()
        descrip.text = "enter description here"
        descrip.font = UIFont(name: "Geeza Pro", size: 17.0)
        descrip.backgroundColor = .white
        descrip.layer.cornerRadius = 4
        return descrip
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpTitleTextConstraints()
        setUpDescriptTextConstraints()
        setUpSecondDescriptConstraints()
    }
    
    private func setUpTitleTextConstraints() {
        addSubview(titleText)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    private func setUpDescriptTextConstraints() {
        addSubview(descripText)
        
        descripText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descripText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            descripText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descripText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descripText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setUpSecondDescriptConstraints() {
        addSubview(secondDescripText)
        
        secondDescripText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondDescripText.topAnchor.constraint(equalTo: descripText.bottomAnchor, constant: 20),
            secondDescripText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            secondDescripText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            secondDescripText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
}
