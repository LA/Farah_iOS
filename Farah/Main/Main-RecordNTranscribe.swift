//
//  Main-RecordNTranscribe.swift
//  Farah
//
//  Created by Adar Butel on 9/21/16.
//  Copyright © 2016 com.adarbutel. All rights reserved.
//

import AVFoundation
import Foundation
import Speech

// MARK: Record and Transcribe Methods
extension MainViewController {
    
    
    func recordSpeech() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        print("Recording Speech...")
        
        textView.insertText("\(name): ")
        
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
        
        // Change Label to Transcribing while Transcribing
        self.changeLabel(transcribing: true)
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: recordingURL)
        
        recognizer?.recognitionTask(with: request, resultHandler: { [unowned self] (result, error) in
            
            guard result != nil else {
                print("An error occurred")
                // Switch Label back to Default Hold Down Message
                self.changeLabel(transcribing: false)
                return
            }
            
            if result!.isFinal {
                
                if let text = result?.bestTranscription.formattedString {
                    
                    var successful = false
                    
                    // try text?.write(to: self.transcriptionURL!, atomically: true, encoding: .utf8)
                    
                    self.textView.insertText(text)
                    
                    // Say Character Count
                    if SimpleCases.sayCharacterCount(from: text).1 && !successful {
                        self.respond(with: SimpleCases.sayCharacterCount(from: text).0!)
                        successful = true
                    }
                    
                    // Say Doing Well
                    if SimpleCases.sayDoingWell(from: text).1 && !successful {
                        self.respond(with: SimpleCases.sayDoingWell(from: text).0!)
                        successful = true
                    }
                    
                    // Say I Am Farah
                    if SimpleCases.sayIAm(from: text).1 && !successful {
                        self.respond(with: SimpleCases.sayIAm(from: text).0!)
                        successful = true
                        
                    }
                    
                    if !successful {
                        self.respond(with: SimpleCases.doesNotUnderstand())
                    }
                    
                    // Switch Label back to Default Hold Down Message
                    self.changeLabel(transcribing: false)
                    
                }
            }
        })
    }
    
    func respond(with message: String) {
        textView.insertText("\n\n")
        textView.insertText("Farah: ")
        textView.insertText(message)
    }
}
