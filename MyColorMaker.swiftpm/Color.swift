//
//  Memory.swift
//  MyColorMaker
//
//  Created by user on 2023/04/20.
//

import Foundation
import SwiftUI
import CoreData

// Create Core Data class for entity
@objc(Colors)
public class Colors: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var image: Data?
    @NSManaged public var color: UIColor
    @NSManaged public var date: Date
    @NSManaged public var hexcode: String
    @NSManaged public var filter: String
    
}

