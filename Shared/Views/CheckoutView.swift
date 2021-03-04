//
//  CheckoutView.swift
//  CupCake (iOS)
//
//  Created by Tuan Son Nguyen on 4/3/21.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    @State var showConfirmation = false
    @State var confirmationMessage = ""
    
    var body: some View {
        // using GeometryReader to size the image so that the image fits multiple screen
        GeometryReader { geo in
            VStack {
                Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                    
                Text("Your total cost is $\(order.price, specifier: "%.2f")")
                    .font(.title)
                
                Button("Place Order") {
                    placeOrder()
                }
                .padding()
            }
        }
        // yellow navigation bar issues: https://developer.apple.com/forums/thread/669459
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showConfirmation, content: {
            Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("Yayy!")))
        })
    }
    
    func placeOrder() {
        
        // use try? if throw error shows up: Errors thrown from here are not handled
        guard let encoded = try? JSONEncoder().encode(order) else {
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = encoded
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print("request error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                print("order success")
                showConfirmation = true
                confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            } else {
                print("error in decoding error")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
