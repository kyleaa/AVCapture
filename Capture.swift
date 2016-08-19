//
//  Capture.swift
//  AVCapture
//
//  Created by Kyle Anderson on 7/5/16.
//  Copyright © 2016 Kyle Anderson. All rights reserved.
//

import UIKit
import AVFoundation

class Capture: NSObject {
    
    let devices = AVCaptureDevice.devices()
    
    var cameraRear : AVCaptureDevice? {
        for device in devices {
            if device.hasMediaType(AVMediaTypeVideo) && device.position == AVCaptureDevicePosition.Back {
                return device as? AVCaptureDevice
            }
        }
        return nil
    }
    
    
    
}
