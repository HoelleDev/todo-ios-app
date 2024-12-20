import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Environment(\.modelContext) private var sharedModelContainer
    
    @State private var showSheet = false
    @State private var selectedToDo: ToDo?
    
    // Abfrage aller ToDos aus der DB
    // Sortierung nach Deadline
    @Query(sort: \ToDo.deadline, order: .forward) private var toDos: [ToDo]
    
    private func add() {
        showSheet = true
    }
    
    private func deleteItem(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                sharedModelContainer.delete(toDos[index])
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) { todo in
                    HStack {
                        Button {
                            todo.isCompleted.toggle()
                        } label: {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(Color(todo.isCompleted ? .gray : .blue))
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                if todo.isCompleted == true {
                                    Text(todo.title)
                                        .font(.headline)
                                }
                                else {
                                    Text(todo.title)
                                        .font(.headline)
                                }
                            }
                            HStack{
                                Text(todo.deadline.formatted())
                                Spacer()
                                Text(todo.priority)
                                    .foregroundStyle(.gray)
                            }
                            if let description = todo.taskDescription {
                                Text(description)
                            }
                        }
                        .strikethrough(todo.isCompleted)
                        
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                //Berechnung des Index da durch Edit + Delete die Funktion onDelete
                                // nicht möglich ist. firstIndex sucht das todo in toDos und gibt Index zurück
                                if let index = toDos.firstIndex(of: todo) {
                                    deleteItem(at: IndexSet(integer: index))
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                selectedToDo = todo
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                            
                        }
                    }
                }
            }
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: add) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                ToDoDetailView(toDo: nil)
            })
            .sheet(item: $selectedToDo) { toDo in
                ToDoDetailView(toDo: toDo)
            }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDo.self, inMemory: true) // Zum Testen in Preview
}
