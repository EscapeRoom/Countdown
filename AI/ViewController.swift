//
//  ViewController.swift
//  AI
//
//  Created by Jacob Johannesen on 2/25/15.
//  Copyright (c) 2015 MonsterCreate. All rights reserved.
//

import Cocoa
import AVFoundation
import AVKit

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet var submitButton: NSButton!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var progressBar: NSProgressIndicator!
    @IBOutlet var playerView: AVPlayerView!
    @IBOutlet weak var percentLabel: NSTextFieldCell!
    @IBOutlet weak var countdownLabel: NSTextField!
    @IBOutlet weak var imageView1: NSImageView!
    @IBOutlet weak var imageView2: NSImageView!
    @IBOutlet weak var imageView3: NSImageView!
    @IBOutlet weak var imageView4: NSImageView!
    @IBOutlet weak var imageView5: NSImageView!
    @IBOutlet weak var imageView6: NSImageView!
    
    var timer: NSTimer = NSTimer();
    
    var numUnlocked: Int = 0;
    
    var unlockedArray: [Int] = [0,0,0,0,0,0]
    
    var minsLeft: Int = 40;
    var secsLeft: Int = 0;
    var repeatsLeft: Int = 0;
    
    override func viewDidLoad() {
        if #available(OSX 10.10, *) {
            super.viewDidLoad()
        } else {
            // Fallback on earlier versions
        }
        self.view.layer?.backgroundColor = NSColor.orangeColor().CGColor
        
        self.textField.target = self
        self.textField.action = Selector("sendString")
        self.textField.delegate = self
        
        let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("EscapeRoom", ofType:"mp4")!)
        let videoPlayer = AVPlayer(URL: url)
        self.playerView.player = videoPlayer
        videoPlayer.play()
        
        updatePercentComplete();
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func startCountdown()
    {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
    }
    
    func updatePercentComplete()
    {
        self.percentLabel.stringValue = String(format: "%d of 6 Puzzles Complete", numUnlocked)
    }
    
    func countDown()
        
    {
        if(minsLeft==10 && secsLeft==0)
        {
            if(numUnlocked >= 4)
            {
                let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("30 Min Succeeding", ofType:"mp4")!)
                let videoPlayer = AVPlayer(URL: url)
                self.playerView.player = videoPlayer
                videoPlayer.play()
            }
            else
            {
                let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("30 Min. Failing", ofType:"mp4")!)
                let videoPlayer = AVPlayer(URL: url)
                self.playerView.player = videoPlayer
                videoPlayer.play()
            }
        }
        if(minsLeft==25 && secsLeft==0)
        {
            if(numUnlocked >= 3)
            {
                let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("15 Min. Succeeding", ofType:"mp4")!)
                let videoPlayer = AVPlayer(URL: url)
                self.playerView.player = videoPlayer
                videoPlayer.play()
            }
            else
            {
                let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("15MinFailing", ofType:"mp4")!)
                let videoPlayer = AVPlayer(URL: url)
                self.playerView.player = videoPlayer
                videoPlayer.play()
            }
        }
        if(self.secsLeft == 0)
        {
            if(self.minsLeft == 0)
            {
                let sound = NSSound(named: "monster.mp3")
                sound?.play()
                
                let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("Room Failure", ofType:"mp4")!)
                let videoPlayer = AVPlayer(URL: url)
                self.playerView.player = videoPlayer
                videoPlayer.play()
                
                self.timer.invalidate()
            }
            else
            {
                self.secsLeft = 60;
                self.minsLeft--;
            }
        }
        else
        {
            self.secsLeft--;
        }
        
        let sound = NSSound(named: "click.mp3")
        sound?.play()
        
        self.countdownLabel.stringValue = String(format: "%02d:%02d", minsLeft, secsLeft)
    }
    
    func sendString() {
        print(self.textField!.stringValue);
        if(self.textField!.stringValue == "")
        {
        }
        else if(self.textField!.stringValue == "lightspeed")
        {
            self.timer.invalidate()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
        }
        else if(self.minsLeft==0 && self.secsLeft == 0)
        {
            self.textField.stringValue = ""
            let sound = NSSound(named: "beep7.mp3")
            sound?.play()
        }
        else if(self.textField!.stringValue == "23" && self.unlockedArray[0] == 0)
        {
            self.unlockedArray[0] = 1
            
            let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("DrAdamsInternIntro", ofType:"mp4")!)
            let videoPlayer = AVPlayer(URL: url)
            self.playerView.player = videoPlayer
            videoPlayer.play()
            
            self.textField!.stringValue = ""
            
            numUnlocked++;
            progressBar.incrementBy(16.6)
            
            startCountdown()
            
            updateAll()
        }
//        else if(self.textField!.stringValue == "178" && self.unlockedArray[0] == 0)
//        {
//            self.unlockedArray[0] = 1
//            
//            let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("DrAdamsJanitorIntro", ofType:"mp4")!)
//            let videoPlayer = AVPlayer(URL: url)
//            self.playerView.player = videoPlayer
//            videoPlayer.play()
//            
//            self.textField!.stringValue = ""
//            
//            numUnlocked++;
//            
//            startCountdown()
//            progressBar.incrementBy(16.6)
//            updateAll()
//        }
        else if(self.textField!.stringValue == "13" && self.unlockedArray[1] == 0)
        {
            self.unlockedArray[1] = 1
            
            self.textField!.stringValue = ""
            
            numUnlocked++;
            progressBar.incrementBy(16.6)
            updateAll()
        }
        else if(self.textField!.stringValue == "8" && self.unlockedArray[2] == 0)
        {
            self.unlockedArray[2] = 1
            
            self.textField!.stringValue = ""
            
            numUnlocked++;
            progressBar.incrementBy(16.6)
            updateAll()
        }
        else if(self.textField!.stringValue == "18" && self.unlockedArray[3] == 0)
        {
            self.unlockedArray[3] = 1
            
            self.textField!.stringValue = ""
            
            numUnlocked++;
            progressBar.incrementBy(16.6)
            updateAll()
        }
        else if(self.textField!.stringValue == "5" && self.unlockedArray[4] == 0)
        {
            self.unlockedArray[4] = 1
            
            self.textField!.stringValue = ""
            
            numUnlocked++;
            progressBar.incrementBy(16.6)
            updateAll()
        }
        else if(self.textField!.stringValue == "15" && self.unlockedArray[5] == 0)
        {
            self.unlockedArray[5] = 1
            
            self.textField!.stringValue = ""
            
            numUnlocked++;
            progressBar.incrementBy(16.6)
            updateAll()
        }
        else
        {
            self.textField.stringValue = ""
            let sound = NSSound(named: "beep7.mp3")
            sound?.play()
        }
    }
    
    func updateAll()
    {
        if(numUnlocked == 6)
        {
            self.timer.invalidate()
            
            let sound = NSSound(named: "happy.mp3")
            sound?.volume = 0.1
            sound?.play()
            
            let url = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("Room Success", ofType:"mp4")!)
            let videoPlayer = AVPlayer(URL: url)
            self.playerView.player = videoPlayer
            videoPlayer.play()
        }
        else
        {
            let sound = NSSound(named: "traitAdded.mp3")
            sound?.play()
        }
        
        updatePercentComplete();
    }
    
    func control(control: NSControl, textView: NSTextView, completions words: [String], forPartialWordRange charRange: NSRange, indexOfSelectedItem index: UnsafeMutablePointer<Int>) -> [String] {
        return []
    }
    

}



