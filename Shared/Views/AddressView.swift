//
//  AddressView.swift
//  CupCake (iOS)
//
//  Created by Tuan Son Nguyen on 4/3/21.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("street", text: $order.street)
                TextField("suburb", text: $order.suburb)
                TextField("state", text: $order.state)
            }
            
            Section {
                NavigationLink("Checkout", destination: CheckoutView(order: order))
                    .disabled(order.validAddress)
            }
        }
        .navigationTitle("Delivery Details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
