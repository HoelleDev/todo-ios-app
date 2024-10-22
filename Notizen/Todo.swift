//
//  Todo.swift
//  Notizen
//
//  Created by Hoeltgebaum, Daniel (SE-A/32) on 22.10.24.
//

import Foundation

struct ToDo: Identifiable {
    let id = UUID()
    let text : String
    let date : Date
    var isCompleted: Bool
}
