//
//  TransaksiCell.swift
//  QRisCase
//
//  Created by anca dev on 22/03/24.
//

import UIKit

class TransaksiCell: UITableViewCell {

    @IBOutlet weak var labelNamaMerchant: UILabel!
    @IBOutlet weak var labelNominalTransaksi: UILabel!
    
    var alreadySetup = false
    
    func initialSetup(transaksi: Transaksi) {
        labelNamaMerchant.text = transaksi.nama_merchant
        labelNominalTransaksi.text = transaksi.nominal_transaksi?.idrCurrency ?? ""
        alreadySetup = true
    }
    
}
