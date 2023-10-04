//
//  ViewController.swift
//  MacFullScreen
//
//  Created by Developer on 15/09/2023.

import Cocoa
import AVKit

class ViewController: NSViewController {
    
    @IBOutlet weak var customView: NSView!
    @IBOutlet weak var custom1: NSView!
    
    var playerView: AVPlayerView?
    var player = AVPlayer()
    
    override func viewDidAppear() {
        super.viewDidAppear()
        // Hide the default title bar and buttons
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.titleVisibility = .hidden
        self.view.window?.standardWindowButton(.closeButton)?.isHidden = true
        self.view.window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.view.window?.standardWindowButton(.zoomButton)?.isHidden = true
        
        // set transparency of window
        self.view.window?.backgroundColor = NSColor.black.withAlphaComponent(0.88)
        
        if let screen = NSScreen.main {
            // Set the view's frame to the bounds of the screen
            self.view.frame = screen.visibleFrame
            self.view.window?.setFrame(screen.visibleFrame, display: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //            Add a tap gesture recognizer to the view
        let tapGesture = NSClickGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.custom1.addGestureRecognizer(tapGesture)
        
        // Add video playback code
        if let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4") {
            player = AVPlayer(url: videoURL)
            
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
                    playerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])
            }
            
            // Play the video
            player.play()
        }
    }
    
    @IBAction func close(_ sender: Any) {
        if let window = self.view.window {
            self.player.pause()
            window.close()
        }
    }
    
    @IBAction func share(_ sender: Any) {
        print("share tapped")
        guard let videoURL = player.currentItem?.asset as? AVURLAsset else {
            return
        }
        
        let sharingServicePicker = NSSharingServicePicker(items: [videoURL.url])
        sharingServicePicker.delegate = self
        sharingServicePicker.show(relativeTo: .zero, of: self.view, preferredEdge: .minY)
    }
    
    @IBAction func download(_ sender: Any) {
        print("download tapped")
    }
    
    @objc func handleTap(_ gestureRecognizer: NSClickGestureRecognizer) {
        if let window = self.view.window {
            player.pause()
            window.close()
        }
    }
}

// Conform to NSSharingServicePickerDelegate to handle sharing completion
extension ViewController: NSSharingServicePickerDelegate {
    func sharingServicePicker(_ sharingServicePicker: NSSharingServicePicker, sharingServicesForItems items: [Any], proposedSharingServices proposedServices: [NSSharingService]) -> [NSSharingService] {
        // You can customize the sharing services here if needed
        return proposedServices
    }
}

