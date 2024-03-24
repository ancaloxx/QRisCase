//
//  Extension+UIViewController.swift
//  QRisCase
//
//  Created by anca dev on 22/03/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String = "Transaksi", message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Oke",
                                     style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(buttonOk)
        self.present(alert,
                     animated: true)
    }
    
}
