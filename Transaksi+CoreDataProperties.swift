//
//  Transaksi+CoreDataProperties.swift
//  QRisCase
//
//  Created by anca dev on 21/03/24.
//
//

import Foundation
import CoreData


extension Transaksi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaksi> {
        return NSFetchRequest<Transaksi>(entityName: "Transaksi")
    }

    @NSManaged public var nama_merchant: String?
    @NSManaged public var nominal_transaksi: String?

}

extension Transaksi : Identifiable {

}
