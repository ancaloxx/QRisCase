//
//  Extension+String.swift
//  QRisCase
//
//  Created by anca dev on 22/03/24.
//

import UIKit

extension String {
    
    var idrCurrency: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        let textNumber = Double(self)
        return formatter.string(for: textNumber) ?? ""
    }
    
}
