//
//  ViewController.swift
//  AVCapture
//
//  Created by Kyle Anderson on 7/3/16.
//  Copyright © 2016 Kyle Anderson. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftPhoenixClient

class CaptureViewController: UIViewController {

    @IBOutlet weak var cameraPreviewView: CameraPreviewView!

    private var captureSession = AVCaptureSession()
    private var captureDevice : AVCaptureDevice?
    private var imageOutput: AVCaptureStillImageOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    let socket = Phoenix.Socket(domainAndPort: "10.10.10.20:4000", path: "socket", transport: "websocket")
    var topic: String? = "camera:all"
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: " ", modifierFlags: .Alternate, action: #selector(CaptureViewController.capturePhoto), discoverabilityTitle: "Types")
        ]
    }
    
    var videoConnection: AVCaptureConnection? {
        for connection in imageOutput!.connections {
            for port in connection.inputPorts {
                if port.mediaType == AVMediaTypeVideo {
                    return connection as? AVCaptureConnection
                }
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if device.hasMediaType(AVMediaTypeVideo) && device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
        }
        
        if captureDevice != nil {
            beginSession()
        }
        
        socket.join(topic: topic!, message: Phoenix.Message(subject: "camera", body: "joining")) { channel in
            let controlChannel = channel as! Phoenix.Channel
            controlChannel.on("join") { message in
                print("joined!")
            }
            controlChannel.on("capture") { message in
                guard let message = message as? Phoenix.Message,
                let id = message.message?["id"] else {
                    return
                }
                self.capturePhoto("\(id!)")
            }
        }
    }
    
    override func didRotateFromInterfaceOrientation (fromInterfaceOrientation: UIInterfaceOrientation) {
        UIView.setAnimationsEnabled(true)
    }
    
    override func shouldAutorotate() -> Bool {
        UIView.setAnimationsEnabled(false)
        return true
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        previewLayer?.frame = CGRectMake(0, 0, size.width, size.height)
        
        if let previewLayerConnection = previewLayer?.connection {
            if previewLayerConnection.supportsVideoMirroring {
                previewLayerConnection.automaticallyAdjustsVideoMirroring = false
                previewLayerConnection.videoMirrored = true
            }
            if previewLayerConnection.supportsVideoOrientation {
                var videoOrientation : AVCaptureVideoOrientation?
                switch UIDevice.currentDevice().orientation {
                case .LandscapeLeft: videoOrientation = .LandscapeRight
                case .LandscapeRight: videoOrientation = .LandscapeLeft
                case .Portrait: videoOrientation = .Portrait
                case .PortraitUpsideDown: videoOrientation = .PortraitUpsideDown
                default: break
                }
                if let orientation = videoOrientation {
                    previewLayerConnection.videoOrientation = orientation
                    print("new orientation \(orientation)")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func beginSession() {
        
        //captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        try! captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
        
        imageOutput = AVCaptureStillImageOutput()
        imageOutput?.highResolutionStillImageOutputEnabled = true
        let outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        imageOutput?.outputSettings = outputSettings
        
        captureSession.addOutput(imageOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewView.layer.addSublayer(previewLayer!)
     //   cameraPreviewView.layer.insertSublayer(previewLayer, atIndex: 1)
        previewLayer?.frame = cameraPreviewView.bounds
        print("Bounds \(cameraPreviewView.layer.bounds)")
        print("Frame \(cameraPreviewView.layer.frame)")
        print("VBounds \(self.view.layer.bounds)")
        print("VFrame \(self.view.layer.frame)")
        
        captureSession.startRunning()
    }
    

    @IBAction func cameraPressed(sender: UIButton) {
        capturePhoto()
    }
    
    internal func capturePhoto(id: String = "") {
        
        if let connection = videoConnection {
            imageOutput!.captureStillImageAsynchronouslyFromConnection(connection) { (sampleBuffer, err) in
                let jpegData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let image = UIImage(data: jpegData)
                
                if let img = image {
                    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                    print("saved photo")
                    
                    self.uploadPhoto(jpegData, url: "http://10.10.10.20:4000/upload", id: id)
                    
             
                } else {
                    print("couldn't unwrap optional UIImage")
                }
            }
        }
    }
    
    internal func uploadPhoto(imageData: NSData, url: String, id: String) {
        
        let message = Phoenix.Message(message: ["id":id])
        let payload = Phoenix.Payload(topic: topic!, event: "photo_upload", message: message)
        socket.send(payload)
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.init(rawValue: 0)) // encode the image
        let params = ["image":[ "content_type": "image/jpeg", "id":id, "file_data": base64String]]
        
        try! request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){(data, response, error) -> Void in
            if error != nil {
                print("error received \(error)")
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                print("success \(result)")
            }
        }
        task.resume()
    }
}

