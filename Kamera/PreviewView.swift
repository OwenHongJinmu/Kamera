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
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}

class PreviewView: UIView {
    var captureSession: AVCaptureSession? {
        didSet {
            if let session = captureSession {
                videoPreviewLayer.session = session
            }
        }
    }
    
    var contentView: PreviewContentView = PreviewContentView()
    
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return contentView.layer as! AVCaptureVideoPreviewLayer
    }
    
    private var focusRectLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - public methods
    func rectOfInterest() -> CGRect {
        return CGRect.zero;
    }
    
    func focusOn(touchPoint: CGPoint) {
        let rect = CGRect(x: touchPoint.x - 20, y: touchPoint.y - 20, width: 40, height: 40)
        drawfocusRectLayerWith(rect: rect, color: UIColor.yellow)
    }
    //MARK: - private methods
    
    func drawfocusRectLayerWith(rect: CGRect, color: UIColor) {
        removefocusRectLayer()
        let maskPath: UIBezierPath = UIBezierPath(rect: rect)
        focusRectLayer = CAShapeLayer()
        focusRectLayer?.strokeColor = color.cgColor
        focusRectLayer?.fillColor = UIColor.clear.cgColor
        focusRectLayer?.lineWidth = 2
        focusRectLayer?.path = maskPath.cgPath
        if let frl = focusRectLayer {
            layer.addSublayer(frl)
        }
    }
    
    func removefocusRectLayer() {
        if focusRectLayer != nil {
            focusRectLayer?.removeFromSuperlayer()
            focusRectLayer = nil
        }
    }
}


