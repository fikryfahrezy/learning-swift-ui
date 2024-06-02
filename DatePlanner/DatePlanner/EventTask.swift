//
//  EventTask.swift
//  DatePlanner
//
//  Created by Fikry Fahrezy on 18/05/24.
//

import Foundation

struct EventTask: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
}
