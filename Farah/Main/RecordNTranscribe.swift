//
//  RecordNTranscribe.swift
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
        
        textView.insertText("\(name): ")
        
        do {
            
            // Set recording session to Play and Record, and activate
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try recordingSession.setActive(true)
            
            // No idea if these are good settings
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                // High quality Audio Quality, might improve speed with low quality?
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecordings += 1
            audioRecorder = try AVAudioRecorder(url: recordingURL, settings: settings)
            audioRecorder?.delegate = self
            
            // Start recording speech
            audioRecorder?.record()
            
        } catch let error {
            print("Failed to record: \(error.localizedDescription)")
            finishRecording(success: false)
        }
    }
    
    // Called when user ends recording
    func finishRecording(success: Bool) {
        
        // Stop recording
        audioRecorder?.stop()
        
        // If the recording was successful
        if success {
            
            // Start transcribing recording.
            transcribeAudio(from: recordingURL)
        }
    }
    
    // Transcribe speech to text.
    func transcribeAudio(from audio: URL) {
        
        // Change Label to transcribing while transcribing
        transcribing = true
        
        // Create default recognizers and request for transcription
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: recordingURL)
        
        // Start transcription
        recognizer?.recognitionTask(with: request, resultHandler: { [unowned self] (result, error) in
            
            // Make sure result is not nil
            guard result != nil else {
                print("An error occurred")
                
                // Switch Label back to default hold down message
                self.transcribing = false
                return
            }
            
            // Change textview to 'Name: Result' as transcriptions come in
            self.textView.text = "\(self.name): \(((result?.bestTranscription.formattedString)!))"
            
            // When user is finished recording
            if result!.isFinal {
                
                // Make sure there's a result
                if let text = result?.bestTranscription.formattedString {
                    
                    
                    // Check for response from SimpleCases
                    if Response.grabSimpleResponse(from: text).1 {
                        
                        // Check for text command
                        if (Response.grabSimpleResponse(from: text).0 == "text") {
                            
                            // Text user
                            self.textUser(from: text)
                        } else {
                            
                            // If not text command, respond with first available SimpleResponse
                            self.UIrespond(with: Response.grabSimpleResponse(from: text).0)
                        }
                    }
                }
                
                // Switch Label back to Default Hold Down Message
                self.transcribing = false
            }
            })
    }
}
