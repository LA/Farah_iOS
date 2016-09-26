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
    var timer = Timer()
    var increaseAlpha = false
    var textToAnalyze: [String]?
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
            transcriptionURL = getDocumentsDirectory().appendingPathComponent("\(transcriptions)transcription.txt")
        }
    }
    
    var authorized = false
    
    let talkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(#imageLiteral(resourceName: "Microphone"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Hold down to speak to Farah."
        label.font = UIFont.boldSystemFont(ofSize: labelFontSize)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: TVFontSize)
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
        recognizer.minimumPressDuration = duration
        talkButton.addGestureRecognizer(recognizer)
    }
}

// MARK: URL Methods
extension MainViewController {
    
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
