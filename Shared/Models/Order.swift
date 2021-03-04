//
//  Order.swift
//  CupCake (iOS)
//
//  Created by Tuan Son Nguyen on 4/3/21.
//

import Foundation

final class Order: Codable, ObservableObject {
    
    init() {}
    
    static let types: [String] = ["Vanilla", "Strawberry", "Chocolate", "RainBow"]
    
    // cake details
    @Published var type: Int = 0
    @Published var quantity: Int = 0
    @Published var specialRequest: Bool = false {
        didSet {
            if self.specialRequest == false {
                self.frosting = false
                self.sprinkle = false
            }
        }
    }
    @Published var frosting: Bool = false
    @Published var sprinkle: Bool = false
    
    // address
    @Published var street: String = ""
    @Published var suburb: String = ""
    @Published var state: String = ""
    var validAddress: Bool {
        return self.street.isEmpty || self.suburb.isEmpty || self.state.isEmpty
    }
    
    var price : Double {
        var totalPrice: Double = 0
        let typePrice = Double((type + 1) / 2)
        let quantityPrice = typePrice * Double(quantity)
        let sprinklePrice = Double(quantity) * 0.2
        let frostingPrice = Double(quantity) * 0.3
        
        totalPrice = typePrice + quantityPrice + sprinklePrice + frostingPrice
        
        return totalPrice
    }
    
    // Decodable
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequest, frosting, sprinkle, street, suburb, state
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        specialRequest = try container.decode(Bool.self, forKey: .specialRequest)
        frosting = try container.decode(Bool.self, forKey: .frosting)
        sprinkle = try container.decode(Bool.self, forKey: .sprinkle)
        
        street = try container.decode(String.self, forKey: .street)
        suburb = try container.decode(String.self, forKey: .suburb)
        state = try container.decode(String.self, forKey: .state)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(specialRequest, forKey: .specialRequest)
        try container.encode(frosting, forKey: .frosting)
        try container.encode(sprinkle, forKey: .sprinkle)
        
        try container.encode(street, forKey: .street)
        try container.encode(suburb, forKey: .suburb)
        try container.encode(state, forKey: .state)
    }
}
