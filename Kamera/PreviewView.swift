//
//  PreviewView.swift
//  Kamera
//
//  Created by OwenHong on 2019/3/23.
//  Copyright © 2019 owenhong. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PreviewContentView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func videoPreviewLayer() -> AVCaptureVideoPreviewLayer {
        return self.layer as! AVCaptureVideoPreviewLayer
    }
}

class PreviewView: UIView {
    var captureSession: AVCaptureSession? {
        didSet {
            if let session = captureSession {
                self.videoPreviewLayer().session = session
            }
        }
    }
    
    var contentView: PreviewContentView = PreviewContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rectOfInterest() -> CGRect {
        return CGRect.zero;
    }
    
    func videoPreviewLayer() -> AVCaptureVideoPreviewLayer {
        return self.contentView.layer as! AVCaptureVideoPreviewLayer
    }
}


