//
//  TransaksiViewController.swift
//  QRisCase
//
//  Created by anca dev on 22/03/24.
//

import UIKit

class TransaksiViewController: UIViewController {
    
    @IBOutlet weak var listTransaksi: UITableView!
    
    private var viewModel: TransaksiViewModelProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTransaksi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        listTransaksiSetup()
    }
    
    private func loadTransaksi() {
        viewModel = TransaksiViewModel()
        viewModel?.loadItem() { completion in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if completion {
                    self.listTransaksi.reloadData()
                }
            }
        }
    }
    
    private func listTransaksiSetup() {
        listTransaksi.register(UINib(nibName: TransaksiCell.cellIdentifier,
                                     bundle: nil),
                               forCellReuseIdentifier: TransaksiCell.cellIdentifier)
    }

}

extension TransaksiViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else {
            return 0
        }
        return viewModel.numberOfItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransaksiCell.cellIdentifier,
                                                       for: indexPath) as? TransaksiCell, let viewModel else {
            return UITableViewCell()
        }
        
        if !cell.alreadySetup {
            cell.initialSetup(transaksi: viewModel.transactionOfItem[indexPath.row])
        }
        
        return cell
    }
    
}
