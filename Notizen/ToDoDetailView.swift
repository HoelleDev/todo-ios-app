//
//  newItemView.swift
//  Notizen
//
//  Created by Hoeltgebaum, Daniel (SE-A/32) on 17.10.24.
//

import SwiftUI

struct ToDoDetailView : View {
    
    enum Mode {
        case add, edit
    }
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var sharedModelContainer
    
    // Array für Picker der Priorität
    let prioritys = ["High", "Medium", "Low"]
    
    // ToDo für die Datenbank
    @State var contextToDo: ToDo?
    
    // Temporäres ToDo für den Edit Modus da sonst jede Änderung direkt gespeichert wird
    @State var tempToDo: ToDo
    
    // Modus initial im Add Modus
    @State var mode: Mode = .add
    
    init(toDo: ToDo?) {
        if let toDo = toDo {
            //Wenn ToDo existiert, speichere ich ihn ab und lege temporäres an, damit die Änderungen
            //nicht direkt in der DB gespeichert werden
            mode = .edit
            self.contextToDo = toDo
            self.tempToDo = .init(title: toDo.title, deadline: toDo.deadline, priority: toDo.priority, taskDescription: toDo.taskDescription)
        } else {
            // Wenn noch kein ToDo besteht, lege ein leeres ToDo an.
            self.tempToDo = .init(title: "", deadline: .now, priority: prioritys[1], taskDescription: nil)
        }
    }
    
    private func saveToDoInDatabase() {
        switch mode {
        case .add:
            sharedModelContainer.insert(tempToDo)
            break
            
        case .edit:
            // Wenn bereits toDo existiert, überschreibe den Text mit der tempToDo aus dem Textfeld
            if let toDo = contextToDo {
                toDo.title = tempToDo.title
                toDo.deadline = tempToDo.deadline
                toDo.priority = tempToDo.priority
                toDo.taskDescription = tempToDo.taskDescription
            }
            break
        }
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title (required)", text: $tempToDo.title)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Description", text: Binding(
                    get: { tempToDo.taskDescription ?? "" },
                    set: { newValue in
                        tempToDo.taskDescription = newValue.isEmpty ? nil : newValue
                    }
                ))
                .textFieldStyle(.roundedBorder)
                
                DatePicker(
                    "Deadline",
                    selection: $tempToDo.deadline
                )
                
                Section(header: Text("Pirority")) {
                    Picker("Priority", selection: $tempToDo.priority) {
                        ForEach(prioritys, id: \.self) { priority in
                            Text(priority).tag(priority)
                        }
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
            }
            .padding()
            .navigationTitle(mode == .add ? "Add ToDo" : "Edit ToDo")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(mode == .add ? "Add" : "Save") {
                        saveToDoInDatabase()
                    }
                    // Speichern neuer Task erst möglich mit Titel
                    .disabled(tempToDo.title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        cancel()
                    }
                }
            }
        }
    }
}
#Preview {
    ToDoDetailView(toDo: nil)
}
