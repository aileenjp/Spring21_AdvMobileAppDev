//
//  FifthViewController.swift
//  music
//
//  Created by Aileen Pierce on 1/19/21.
//

import UIKit
import AVFoundation

class FifthViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    let fileName = "audio.m4a"
    
    @IBAction func recordAudio(_ sender: Any) {
        //if not already recording, start recording
        if audioRecorder?.isRecording == false {
            playButton.isEnabled = false
            stopButton.isEnabled = true
            audioRecorder?.delegate = self
            audioRecorder?.record()
        }
    }

    @IBAction func playAudio(_ sender: Any) {
        //if not recording play audio file
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder!.url)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay() //prepares the audio player for playback by preloading its buffers
                audioPlayer!.play() //plays audio file
            } catch let error {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func stopAudio(_ sender: Any) {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        recordButton.isEnabled = true
        
        //stop recording or playing
        if audioRecorder?.isRecording == true {
            audioRecorder!.stop()
        } else {
            audioPlayer!.stop()
        }
    }
    
    func setupAudio(){
        //disable buttons since no audio has been recorded
        playButton.isEnabled = false
        stopButton.isEnabled = false
        
        //get path for the audio file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //document directory
        let audioFileURL = docDir.appendingPathComponent(fileName)
        print(audioFileURL)
        
        //the shared audio session instance
        let audioSession = AVAudioSession.sharedInstance()
        do {
            //sets the category for recording and playback of audio
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .init(rawValue: 1))
        } catch {
            print("audio session error: \(error.localizedDescription)")
            }
        
        //recorder settings
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), //specifies audio codec
                        AVSampleRateKey: 1200, //sample rate in hertz
                        AVNumberOfChannelsKey: 1, //number of channels
                        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue] //audio bit rate
        do {
            //create the AVAudioRecorder instance
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.prepareToRecord()
            print("audio recorder ready")
        } catch {
            print("audio recorder error: \(error.localizedDescription)")
            }
    }
    
    //AVAudioPlayerDelegate method
    //Called when a recording is stopped or has finished due to reaching its time limit

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
