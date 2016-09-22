//
//  Main-Permissions.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import AVFoundation
import Speech

// MARK: Permissions
extension MainViewController {
    
    func checkPermissions() {
        // check status for all three permissions
        let transcribeAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized
        let recordingAuthorized = AVAudioSession.sharedInstance().recordPermission() == .granted
        
        // make a single authorized boolean from all three
        let authorized = recordingAuthorized && transcribeAuthorized
        
        //if we're missing one show the first screen
        if !authorized {
            requestRecordPermissions()
        }
    }
    
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.authorized = true
                } else {
                    print("Denied")
                }
            }
        }
    }
    
    func requestRecordPermissions() {
        AVAudioSession.sharedInstance().requestRecordPermission { (allowed) in
            DispatchQueue.main.async {
                if allowed {
                    self.requestTranscribePermissions()
                } else {
                    print("Declined")
                }
            }
        }
    }
}
