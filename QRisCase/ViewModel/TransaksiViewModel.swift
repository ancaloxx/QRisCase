//
//  TransaksiViewModel.swift
//  QRisCase
//
//  Created by anca dev on 22/03/24.
//

import Foundation

protocol TransaksiViewModelProtocol: AnyObject {
    var numberOfItem: Int { get }
    var transactionOfItem: [Transaksi] { get }
    
    func loadItem(handle: @escaping(Bool) -> Void)
}

class TransaksiViewModel: TransaksiViewModelProtocol {
    
    private var service: CoreDataServiceProtocol?
    private var transactions: [Transaksi]?
    
    var numberOfItem: Int {
        guard let transactions else {
            return 0
        }
        return transactions.count
    }
    
    var transactionOfItem: [Transaksi] {
        guard let transactions else {
            return [Transaksi]()
        }
        return transactions
    }
    
    func loadItem(handle: @escaping(Bool) -> Void) {
        service = CoreDataService.shareInstance
        service?.loadTransaction() { completion in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.transactions = completion
                handle(true)
            }
        }
    }
    
}
