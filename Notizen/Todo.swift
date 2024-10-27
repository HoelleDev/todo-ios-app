//
//  Todo.swift
//  Notizen
//
//  Created by Hoeltgebaum, Daniel (SE-A/32) on 22.10.24.
//

import Foundation
import SwiftData

@Model
class ToDo: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var isCompleted: Bool {
        didSet {
            isCompletedValue = isCompleted ? 1 : 0
        }
    }
    var isCompletedValue: Int
    var deadline: Date
    var priority: String
    var taskDescription: String?
    
    init(title: String, deadline: Date, priority: String, taskDescription: String? = nil) {
        self.id = .init()
        self.title = title
        self.date = .now
        self.isCompleted = false
        self.isCompletedValue = 0
        self.deadline = deadline
        self.priority = priority
        self.taskDescription = taskDescription
    }
}

