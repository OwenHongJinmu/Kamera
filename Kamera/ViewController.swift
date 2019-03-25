//
//  ViewController.swift
//  Kamera
//
//  Created by OwenHong on 2019/3/23.
//  Copyright © 2019 owenhong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var contentView: PreviewView = {
        let pvv = PreviewView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return pvv
    }()
    
    private var captureSession: AVCaptureSession = {
        let cs = AVCaptureSession()
        return cs
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupCamera()
    }
    
    func setupSubviews() {
        view.addSubview(contentView)
    }
    
    func setupCamera() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .high
        
    }
    
    func checkAuthorization() {
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized:
            setupCamera()
            break
        case .denied:
            //show a tip for user
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if(granted) {
                    DispatchQueue.main.async {
                        self.setupCamera()
                    }
                }
            }
            break
        case .restricted:
            //The client is not authorized to access the hardware for the media type. The user cannot change the client's status, possibly due to active restrictions such as parental controls being in place.
            break
        default:
            break
        }
    }
    
    //MARK - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
}

