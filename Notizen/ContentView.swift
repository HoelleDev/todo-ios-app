//
//  ContentView.swift
//  Notizen
//
//  Created by Hoeltgebaum, Daniel (SE-A/32) on 30.09.24.
//

import SwiftUI

struct ToDo: Identifiable {
    let id = UUID()
    let text : String
    let date : Date
    var isCompleted: Bool
}

struct ContentView: View {
    @State var showNewItem = false
    @State var todoList = [
        ToDo(text: "Learn SwiftUI", date: .now, isCompleted: false),
        ToDo(text: "Learn SwiftData", date: .now, isCompleted: true),
        ToDo(text: "Learn iOS Development", date: .now, isCompleted: false)
        
    ]
    
    private func sortItems() {
        todoList.sort {
            $0.date > $1.date
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        todoList.remove(atOffsets: offsets)
    }
    
    private func insertItem() {
        todoList.append(ToDo(text: "Neuer Eintrag", date: .now, isCompleted: false))
        sortItems()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($todoList) { $todo in
                    HStack {
                        Button {
                            todo.isCompleted.toggle()
                        } label: {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(Color(todo.isCompleted ? .gray : .blue))
                        }
        
                        if todo.isCompleted == true {
                            Text(todo.text)
                                .font(.subheadline)
                                .strikethrough()
                        }
                        else {
                            Text(todo.text)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Text(todo.date.formatted())
                            .font(.footnote)
                    }
                }
                .onDelete(perform: deleteItem)
                
            }
            .sheet(isPresented: $showNewItem, content: {
                newItemView()
            })
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showNewItem = true
                    } ,label: {
                        Image(systemName: "plus")
                    })
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        insertItem()
                    } label: {
                        Text("Hinzufügen")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
