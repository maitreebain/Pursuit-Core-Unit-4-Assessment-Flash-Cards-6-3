//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment

class Unit4AssessmentTests: XCTestCase {
    
    func testCardsModel() {
        let jsonData =
            """
{
    "cardListType": "q and a",
    "apiVersion": "1.2.3",
    "cards": [{
            "id": "1",
            "cardTitle": "What is the difference between a synchronous & an asynchronous task?",
            "facts": [
                "Synchronous: waits until the task have completed.",
                "Asynchronous: completes a task in the background and can notify you when complete."
            ]
        },
        {
            "id": "2",
            "cardTitle": "What is an Enum?",
            "facts": [
                "contains a group of related values.",
                "enumerations define a finite number of states, and can bundle associated values with each individual state.",
                "you can use them to model the state of your app and its internal processes."
            ]
        }
    ]
}
""".data(using: .utf8)!
        
        let expectedCard = "What is the difference between a synchronous & an asynchronous task?"
        
        do {
            let cards = try JSONDecoder().decode(CardsData.self, from: jsonData)
            let cardTitle = cards.cards.first?.cardTitle
            XCTAssertEqual(expectedCard, cardTitle, "title recieved: \(cardTitle ?? ""), card title is \(expectedCard)")
        }catch {
            XCTFail("decoding error: \(error)")
        }
        
        
    }
    
}
