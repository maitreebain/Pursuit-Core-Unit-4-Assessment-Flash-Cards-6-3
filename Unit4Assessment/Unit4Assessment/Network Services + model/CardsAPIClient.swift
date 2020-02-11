//
//  CardsAPIClient.swift
//  Unit4Assessment
//
//  Created by Maitree Bain on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper


struct CardsAPIClient {
    public enum AppleServiceError: Error {
      case resourcePathDoesNotExist
      case contentsNotFound
      case decodingError(Error)
    }
    
    
    public static func getCard() throws -> [CardsInfo] {
        guard let path = Bundle.main.path(forResource: "Cards", ofType: "json") else {
        throw AppleServiceError.resourcePathDoesNotExist
        }
        
        guard let json = FileManager.default.contents(atPath: path) else {
            throw AppleServiceError.contentsNotFound
        }
        
        do {
            let cards = try JSONDecoder().decode(CardsData.self, from: json)
            
            return cards.cards
        }catch {
            throw AppleServiceError.decodingError(error)
        }
        
        
    }
    
}
