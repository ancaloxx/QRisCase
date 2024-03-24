//
//  CoreDataService.swift
//  QRisCase
//
//  Created by anca dev on 21/03/24.
//

import CoreData
import UIKit

protocol CoreDataServiceProtocol: AnyObject {
    func saveMoney(total: @escaping(String) -> Void)
    func saveTransaction(detail: DetailTrans, saldo: String, completion: @escaping(Bool) -> Void)
    func loadTransaction(completion: @escaping([Transaksi]) -> Void)
}

class CoreDataService: CoreDataServiceProtocol {
    
    static let shareInstance = CoreDataService()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveMoney(total: @escaping(String) -> Void) {
        do {
            if let items = try context.fetch(Saldo.fetchRequest()) as? [Saldo] {
                if items.count > 0 {
                    total(items.last?.total ?? "")
                } else {
                    let newSaldo = Saldo(context: context)
                    newSaldo.total = "300000"
                    
                    do {
                        try context.save()
                        total(newSaldo.total ?? "")
                    } catch {
                        print(String(describing: error))
                    }
                }
            }
        } catch {
            print(String(describing: error))
        }
    }
    
    func saveTransaction(detail: DetailTrans, saldo: String, completion: @escaping(Bool) -> Void) {
        let newTransaction = Transaksi(context: context)
        newTransaction.nama_merchant = detail.namaMerchant
        newTransaction.nominal_transaksi = detail.nominalTransaksi
        
        let newSaldo = Saldo(context: context)
        let sisaSaldo = Double(saldo) ?? 0
        let nominal = Double(detail.nominalTransaksi) ?? 0
        let calc = sisaSaldo - nominal
        
        newSaldo.total = String(calc)
        
        do {
            try context.save()
            completion(true)
        } catch {
            print(String(describing: error))
            completion(false)
        }
    }
    
    func loadTransaction(completion: @escaping([Transaksi]) -> Void) {
        
        
        do {
            guard let items = try context.fetch(Transaksi.fetchRequest()) as? [Transaksi] else {
                return
            }
            
            completion(items)
        } catch {
            print(error)
        }
    }
    
}
