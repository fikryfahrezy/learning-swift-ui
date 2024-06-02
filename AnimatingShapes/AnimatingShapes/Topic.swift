//
//  Topic.swift
//  AnimatingShapes
//
//  Created by Fikry Fahrezy on 27/05/24.
//

import SwiftUI

struct Topic: Identifiable, Hashable {
    var id : UUID = UUID()
    var title : String
    var description: String
    var systemSymbol : String
    var destination : Destination
}
