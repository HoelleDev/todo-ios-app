 import Foundation
import SwiftData

@Model
class ToDo: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var isCompleted: Bool
    var deadline: Date
    var priority: String
    var taskDescription: String?
    
    init(title: String, deadline: Date, priority: String, taskDescription: String? = nil) {
        self.id = .init()
        self.title = title
        self.date = .now
        self.isCompleted = false
        self.deadline = deadline
        self.priority = priority
        self.taskDescription = taskDescription
    }
}

