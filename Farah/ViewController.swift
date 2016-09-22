//
//  ViewController.swift
//  Farah
//
//  Created by Adar Butel on 9/20/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import AVFoundation
import Speech
import UIKit

// MARK: Properties & View Controller Methods
class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder?
    var recordingURL: URL!
    var transcriptionURL: URL?
    var recognizer: UILongPressGestureRecognizer!
    
    var audioRecordings = 0 {
        didSet {
            recordingURL = getDocumentsDirectory().appendingPathComponent("\(audioRecordings)recording.m4a")
        }
    }
    
    var transcriptions = 0 {
        didSet {
            transcriptionURL = getDocumentsDirectory().appendingPathComponent("\(audioRecordings)transcription.txt")
        }
    }
    
    var authorized = false {
        didSet {
            print(authorized)
        }
    }
    
    let talkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(#imageLiteral(resourceName: "Microphone"), for: .normal)
        button.layer.borderWidth = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        
        navigationController?.isNavigationBarHidden = true
        
        recordingURL = getDocumentsDirectory().appendingPathComponent("\(audioRecordings)recording.m4a")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViews()
        checkPermissions()
        
        recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(from:)))
        recognizer.minimumPressDuration = 0.25
        talkButton.addGestureRecognizer(recognizer)
    }
}

// MARK: Permissions
extension ViewController {
    
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

// MARK: Record and Transcribe Methods
extension ViewController {
    
    func recordSpeech() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        print("Recording Speech...")
        
        do {
            
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            
            try recordingSession.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecordings += 1
            audioRecorder = try AVAudioRecorder(url: recordingURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
        } catch let error {
            print("Failed to record: \(error.localizedDescription)")
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        
        audioRecorder?.stop()
        
        if success {
            transcriptions += 1
            transcribeAudio(from: recordingURL)
        }
    }

    func transcribeAudio(from audio: URL) {
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: recordingURL)
        
        recognizer?.recognitionTask(with: request, resultHandler: { [unowned self] (result, error) in
            
            guard result != nil else {
                print("There was an error.")
                return
            }
            
            if result!.isFinal {
                let text = result?.bestTranscription.formattedString
                
                do {
                    try text?.write(to: self.transcriptionURL!, atomically: true, encoding: .utf8)
                    if text != nil {
                        self.textView.insertText(text!)
                        print(text!)
                    }
                } catch {
                    print("Failed to save transcription")
                }
            }
        })
    }
}

// MARK: URL Methods
extension ViewController {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

// MARK: Button Methods
extension ViewController {
    
    func handleLongPress(from sender: UILongPressGestureRecognizer) {
        print("Long Press Activated")
        if sender.state == .began {
            talkButton.layer.borderColor = UIColor.red.cgColor
            textView.text = ""
            recordSpeech()
        } else if sender.state == .ended {
            print("Ended")
            talkButton.layer.borderColor = UIColor.clear.cgColor
            talkButton.isSelected = false
            finishRecording(success: true)
        }
    }
}

// MARK: Layout Views
extension ViewController {
    
    func setupViews() {
        view.addSubview(talkButton)
        view.addSubview(textView)
        
        view.addConstraint(NSLayoutConstraint(item: talkButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
//        view.addConstraint(NSLayoutConstraint(item: talkButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        view.addConstraints(withFormat: "H:|-10-[v0]-10-|", views: textView)
        view.addConstraints(withFormat: "V:|-30-[v0]-10-[v1]-150-|", views: textView, talkButton)
    }
}

// MARK: AVAudioRecorderDelegate Methods
extension ViewController {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
