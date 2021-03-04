//
//  ContentView.swift
//  Shared
//
//  Created by Tuan Son Nguyen on 4/3/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) { typeIndex in
                            Text(Order.types[typeIndex])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 0...20) {
                        Text("Number for cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    // with the .animation, the second and third toggles slide out smoothly
                    Toggle(isOn: $order.specialRequest.animation()) {
                        Text("Any special request?")
                    }
                    
                    if (order.specialRequest) {
                        Toggle(isOn: $order.frosting.animation()) {
                            Text("Extra Frosting?")
                        }
                        
                        Toggle(isOn: $order.sprinkle.animation()) {
                            Text("Add Sprinke?")
                        }
                    }
                }
                
                Section {
                    NavigationLink("Delivery Detail", destination: AddressView(order: order))
                        .disabled(!(order.quantity > 0))
                }
            }
            .navigationTitle("Cupcake Order")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
