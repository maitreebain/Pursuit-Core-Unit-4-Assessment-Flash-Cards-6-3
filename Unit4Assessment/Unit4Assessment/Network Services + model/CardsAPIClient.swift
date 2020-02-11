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
    
    static func getCards(completion: @escaping (Result<[CardsInfo], AppError>) -> ()) {
        let endPointURL = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        
        guard let url = URL(string: endPointURL) else {
            completion(.failure(.badURL(endPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let card = try JSONDecoder().decode(CardsData.self, from: data)
                    
                    completion(.success(card.cards))
                } catch {
                    
                }
            }
        }
    }
}

