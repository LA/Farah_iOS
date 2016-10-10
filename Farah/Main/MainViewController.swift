//
//  MainViewController.swift
//  Farah
//
//  Created by Adar Butel on 9/20/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import AVFoundation
import Speech
import UIKit

private let labelFontSize = 30 as CGFloat
private let TVFontSize = 25 as CGFloat
private let duration = 0.25

// MARK: Properties & View Controller Methods
class MainViewController: UIViewController, AVAudioRecorderDelegate {
    
    var name = "You"
    var canUnderstand = false
    var increaseAlpha = false
    var authorized = false
    
    var transcribing = false {
        
        // When transcribing is changed, changeLabel based on it
        didSet {
            changeLabel(transcribing: transcribing)
        }
    }
    
    var timer = Timer()
    var transcribingTimer = Timer()
    var textToAnalyze: [String]?
    var audioRecorder: AVAudioRecorder?
    var recordingURL: URL!
    var recognizer: UILongPressGestureRecognizer!
    
    // Pretty sure this is useless, will test eventually
    var audioRecordings = 0 {
        didSet {
            recordingURL = getDocumentsDirectory().appendingPathComponent("\(audioRecordings)recording.m4a")
        }
    }
    
    // Button used for talking to Farah
    let talkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(#imageLiteral(resourceName: "Microphone"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Label above talkButton
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = holdDownMsg
        label.font = UIFont.systemFont(ofSize: labelFontSize)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Textview for chat with Farah
    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: TVFontSize)
        textView.textColor = .lightGray
        textView.backgroundColor = homeBGColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        
        // Hide the navigation bar
        navigationController?.isNavigationBarHidden = true
        
        // Pretty sure this is also useless
        recordingURL = getDocumentsDirectory().appendingPathComponent("\(audioRecordings)recording.m4a")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViews()
        checkPermissions()
        
        // Add all methods and recognizers to button
        recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(from:)))
        recognizer.minimumPressDuration = duration
        talkButton.addTarget(self, action: #selector(handleTap(recording:)), for: .touchUpInside)
        talkButton.addGestureRecognizer(recognizer)
    }
}

// MARK: URL Methods
extension MainViewController {
    
    // Also probably useless
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

// MARK: AVAudioRecorderDelegate Methods
extension MainViewController {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
