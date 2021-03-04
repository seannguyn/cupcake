//
//  NetworkCallView.swift
//  CupCake (iOS)
//
//  Created by Tuan Son Nguyen on 4/3/21.
//

import SwiftUI

struct NetworkCallView: View {
    
    @State var results: [Result] = []
    @State var key: String = ""
    var disabledForm : Bool {
        return key.isEmpty
    }
    
    var body: some View {
        if results.count == 0 {
            Form {
                Section {
                    TextField("Key", text: $key)
                }
                Section {
                    Button("Fetch Data", action: {
                        fetchData()
                    })
                    .disabled(disabledForm)
                }
            }
        } else {
            List(results, id: \.trackId) { item in
                HStack {
                    Text("TrackId: \(item.trackId)")
                    Text("TrackName: \(item.trackName)")
                    Text("CollectionName: \(item.collectionName)")
                }
            }
        }
    }
    
    func fetchData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("bad URL")
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                print("error in fetching data")
                return
            }
            
            // decode
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                
                // assign data to State using main Queue
                // async means that the background wont wait for the closure to be run
                // instead it just add to the queue and carries on with its background task
                DispatchQueue.main.async {
                    results = response.results
                }
                
                return
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}

struct NetworkCallView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkCallView()
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
