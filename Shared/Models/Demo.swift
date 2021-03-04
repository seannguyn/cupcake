//
//  Demo.swift
//  CupCake (iOS)
//
//  Created by Tuan Son Nguyen on 4/3/21.
//

import Foundation

// When a class is marked as ObservableObject, and has @Published in front of variables,
// it does not conform to Codable, because these vars are wrapped by @Published.
// in order to make conform to Codable, we need to manually decode and encode it

// Step 1: declare enum CodingKeys: CodingKey
// Step 2: declare required init(from decoder: Decoder) throws { declare container and decode }
// Step 3: declare func encoder(from encoder: Encoder) { declare container and encode }

class Demo: Codable, ObservableObject {
    @Published var name: String
    @Published var age: Int
    
    enum CodingKeys: CodingKey {
        case name, age
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
