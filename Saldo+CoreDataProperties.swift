//
//  Saldo+CoreDataProperties.swift
//  QRisCase
//
//  Created by anca dev on 22/03/24.
//
//

import Foundation
import CoreData


extension Saldo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saldo> {
        return NSFetchRequest<Saldo>(entityName: "Saldo")
    }

    @NSManaged public var total: String?

}

extension Saldo : Identifiable {

}
