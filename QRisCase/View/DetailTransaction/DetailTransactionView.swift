//
//  DetailTranscation.swift
//  QRisCase
//
//  Created by anca dev on 21/03/24.
//

import UIKit

protocol DetailTransactionViewDelegate: AnyObject {
    func didKeluar()
    func didKonfirmasi(completion: Bool)
}

class DetailTransactionView: UIView {

    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelNamaMerchant: UILabel!
    @IBOutlet weak var labelNominalTransaksi: UILabel!
    @IBOutlet weak var buttonKeluar: UIButton!
    @IBOutlet weak var buttonKonfirmasi: UIButton!
    
    weak var delegate: DetailTransactionViewDelegate?
    
    private var coreDataService: CoreDataServiceProtocol?
    private var detailTransaction: DetailTrans?
    private var sisaSaldo: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupXib(frame: frame)
    }
    
    private func setupXib(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        view.layer.cornerRadius = 8
        
        addSubview(view)
        
        initialSetup()
    }
    
    private func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DetailTransactionView",
                        bundle: bundle)
        guard let view = nib.instantiate(withOwner: self,
                                         options: nil).first as? UIView else {
            return UIView()
        }
        
        return view
    }
    
    private func initialSetup() {
        buttonSetup()
    }
    
    private func buttonSetup() {
        buttonKeluar.layer.cornerRadius = 4
        buttonKonfirmasi.layer.cornerRadius = 4
    }
    
    func detailTransactionItem(detail: DetailTrans, saldo: String) {
        labelID.text = "ID: \(detail.IDTransaksi)"
        labelNamaMerchant.text = detail.namaMerchant
        labelNominalTransaksi.text = detail.nominalTransaksi.idrCurrency
        
        detailTransaction = detail
        sisaSaldo = saldo
    }

    @IBAction func didClickKeluar(_ sender: UIButton) {
        coreDataService = CoreDataService.shareInstance
//        coreDataService?.loadTransaction()
        
        self.removeFromSuperview()
        delegate?.didKeluar()
    }
    
    @IBAction func didClickKonfirmasi(_ sender: UIButton) {
        coreDataService = CoreDataService.shareInstance
        coreDataService?.saveTransaction(detail: detailTransaction ?? DetailTrans(IDTransaksi: "",
                                                                                  namaMerchant: "",
                                                                                  nominalTransaksi: ""),
                                         saldo: sisaSaldo ?? "") { completion in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.removeFromSuperview()
                self.delegate?.didKonfirmasi(completion: completion)
            }
        }
    }
    
}
