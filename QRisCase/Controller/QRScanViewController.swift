//
//  QRScanViewController.swift
//  QRisCase
//
//  Created by anca dev on 21/03/24.
//

import UIKit
import AVFoundation

struct DetailTrans {
    var IDTransaksi: String
    var namaMerchant: String
    var nominalTransaksi: String
}

protocol QRScanViewControllerDelegate: AnyObject {
    func detailTransaction(detail: DetailTrans)
}

class QRScanViewController: UIViewController {
    
    private var captureSession = AVCaptureSession()
    
    weak var delegate: QRScanViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        qrScanSetup()
    }
    
    private func qrScanSetup() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("error")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            
            output.setMetadataObjectsDelegate(self,
                                              queue: DispatchQueue.main)
            
            captureSession.addInput(input)
            captureSession.addOutput(output)
            
            output.metadataObjectTypes = [.qr]
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            
            view.layer.addSublayer(previewLayer)
            
            captureSession.startRunning()
        } catch {
            print(String(describing: error))
        }
    }

}

extension QRScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              metadataObject.type == .qr,
              let stringValue = metadataObject.stringValue else {
            return
        }
        
        let stringArray = stringValue.components(separatedBy: ".")
        let idTransaksi = stringArray[1]
        let namaMerchant = stringArray[2]
        let nominalTransaksi = stringArray[3]
        
        let detailTrans = DetailTrans(IDTransaksi: idTransaksi,
                                      namaMerchant: namaMerchant,
                                      nominalTransaksi: nominalTransaksi)
        
        self.delegate?.detailTransaction(detail: detailTrans)
        self.dismiss(animated: true)
    }
    
}

extension QRScanViewController {
    static func getViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "QRScan") as? QRScanViewController else {
            return UIViewController()
        }
        
        return vc
    }
}
