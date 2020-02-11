//
//  CardsDataModel.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct CardsData: Codable & Equatable {
    let cards: [CardsInfo]
}

struct CardsInfo: Codable & Equatable {
    let cardTitle: String
    let facts: [String]
}

