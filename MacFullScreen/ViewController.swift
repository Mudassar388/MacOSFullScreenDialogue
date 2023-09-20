//
//  ViewController.swift
//  MacFullScreen
//
//  Created by Developer on 15/09/2023.
//
//DispatchQueue.main.async {
//    //self.view.window?.toggleFullScreen(self)
//    self.view.window?.toggleFullScreen(nil)
//    self.view.window?.backgroundColor = .clear//NSColor.black.withAlphaComponent(0.6)
//    self.view.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.6).cgColor
//
//
//}
import Cocoa
import AVKit

class ViewController: NSViewController {
    
    @IBOutlet var superView: NSView!
    @IBOutlet weak var customView: NSView!
    var playerView: AVPlayerView?
    var overlayWindow: NSWindow?
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.view.window?.backgroundColor = NSColor.black.withAlphaComponent(0.88)
        
        if let screen = NSScreen.main {
            // Set the view's frame to the bounds of the screen
            self.view.frame = screen.visibleFrame
            self.view.window?.setFrame(screen.visibleFrame, display: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a tap gesture recognizer to the view
          let tapGesture = NSClickGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.superView.addGestureRecognizer(tapGesture)
   
        
        // Add video playback code
        if let videoURL = Bundle.main.url(forResource: "Smart-Work", withExtension: "mp4") {
            let player = AVPlayer(url: videoURL)
            
            // Create an AVPlayerView and add it to the custom view
            playerView = AVPlayerView()
            playerView?.player = player
            playerView?.translatesAutoresizingMaskIntoConstraints = false
            customView.addSubview(playerView!)
            
            // Add constraints to position playerView within customView
            if let playerView = playerView {
                NSLayoutConstraint.activate([
                    playerView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
                    playerView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
                    playerView.topAnchor.constraint(equalTo: customView.topAnchor),
                    playerView.bottomAnchor.constraint(equalTo: customView.bottomAnchor)
                ])
            }
            
            // Play the video
            player.play()
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        if let window = self.view.window {
            window.close()
        }
    }
    
    @objc func handleTapp(_ gestureRecognizer: NSClickGestureRecognizer) {
        if let window = self.view.window {
            window.close()
        }
    }
    @objc func handleTap(_ gestureRecognizer: NSClickGestureRecognizer) {
        // Get the location of the tap
        let tapLocation = gestureRecognizer.location(in: self.superView)
        
        // Check if the tap occurred outside of the main parent view's bounds
        if superView.frame.contains(tapLocation) {
            if let window = self.view.window {
                window.close()
            }
        }
    }

    

}

        
