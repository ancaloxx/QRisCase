//
//  ViewController.swift
//  QRisCase
//
//  Created by anca dev on 21/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelSaldo: UILabel!
    
    private let containerView = UIView()
    private var detailTransactionView: DetailTransactionView?
    private var coreDataService: CoreDataServiceProtocol?
    private var sisaSaldo: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        coreDataService = CoreDataService.shareInstance
        loadSisaSaldo()
    }
    
    private func loadSisaSaldo() {
        coreDataService?.saveMoney() { total in
            self.labelSaldo.text = total.idrCurrency
            self.sisaSaldo = total
        }
    }
    
    private func openQRScan() {
        guard let vc = QRScanViewController.getViewController() as? QRScanViewController else {
            return
        }
        vc.delegate = self
        self.present(vc,
                     animated: true)
    }
    
    private func containerViewSetup() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        containerView.backgroundColor = .black.withAlphaComponent(0.4)
    }
    
    private func showDetailTransaction(detail: DetailTrans) {        
        detailTransactionView = DetailTransactionView()
        detailTransactionView?.layer.cornerRadius = 8
        detailTransactionView?.backgroundColor = .white
        detailTransactionView?.delegate = self
        
        guard let detailTransactionView else {
            return
        }
        
        containerViewSetup()
        
        containerView.addSubview(detailTransactionView)
        detailTransactionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailTransactionView.heightAnchor.constraint(equalToConstant: 350),
            detailTransactionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                constant: 48),
            detailTransactionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                 constant: -48),
            detailTransactionView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        detailTransactionView.detailTransactionItem(detail: detail,
                                                    saldo: sisaSaldo ?? "")
    }

    @IBAction func didClickQRis(_ sender: UIButton) {
        openQRScan()
    }
    
}

extension ViewController: QRScanViewControllerDelegate {
    
    func detailTransaction(detail: DetailTrans) {
        showDetailTransaction(detail: detail)
    }
    
}

extension ViewController: DetailTransactionViewDelegate {
    
    func didKeluar() {
        containerView.removeFromSuperview()
    }
    
    func didKonfirmasi(completion: Bool) {
        containerView.removeFromSuperview()
        loadSisaSaldo()
        
        let message = completion ? "Transaksi berhasil" : "Maaf, Transaksi gagal"
        showAlert(message: message)
    }
    
}
