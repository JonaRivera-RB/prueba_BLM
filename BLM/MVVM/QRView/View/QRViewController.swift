//
//  QRViewController.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 11/08/22.
//

import Foundation
import UIKit
import AVFoundation
import SafariServices

class QRViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!

    // MARK: - Properties
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    public var coordinator: Coordinator?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    // MARK: - Functions
    private func setupUI() {
        textView.isHidden = true
        textView.isEditable = false
    }

    private func setQR() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }

        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    func found(code: String) {
        if code.isValidURL {
            guard let url = URL(string: code) else { return }

            let config = SFSafariViewController.Configuration()
            let newsPaperView = SFSafariViewController(url: url, configuration: config)
            present(newsPaperView, animated: true)
        }else {
            textView.isHidden = false
            textView.text = code
        }
    }

    @IBAction func openQRWasPressed() {
        setQR()
    }
    
}

// MARK: - Storyboarded
extension QRViewController: Storyboarded {

    static var storyboardName: String {
        return "QRViewStoryboard"
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        previewLayer.removeFromSuperlayer()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }

}
