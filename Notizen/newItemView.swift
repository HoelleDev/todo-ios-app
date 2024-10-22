//
//  newItemView.swift
//  Notizen
//
//  Created by Hoeltgebaum, Daniel (SE-A/32) on 17.10.24.
//

import SwiftUI

struct newItemView : View {
    @State private var newItem: String = ""
    @State private var displayedText: String? = nil
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if let textToShow = displayedText {
                    Text(textToShow)
                }
                
                Button {
                    displayedText = newItem.isEmpty ? nil : newItem
                } label: {
                    Text("Anzeigen")
                }
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                
                Spacer()
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    newItemView()
}
