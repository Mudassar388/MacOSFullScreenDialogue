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

    @IBOutlet weak var customView: NSView!
    var playerView: AVPlayerView?
    var overlayWindow: NSWindow?

      override func viewDidLoad() {
          super.viewDidLoad()
        
//
//          // Create a custom window
//                  let customWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 800, height: 600), styleMask: [.borderless], backing: .buffered, defer: false)
//
//                  // Set the window's background to clear (transparent)
//                  customWindow.isOpaque = false
//                  customWindow.backgroundColor = .clear
//
//                  // Set the custom window as the window for the view controller
//          self.vind = customWindow
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

    override func viewDidAppear() {
          super.viewDidAppear()

          // Enter full-screen mode
          if let customWindow = self.view.window {
              customWindow.toggleFullScreen(self)
              customWindow.backgroundColor = NSColor.black.withAlphaComponent(0.6)
          }
      }
    
    @IBAction func close(_ sender: Any) {
        self.view.window?.toggleFullScreen(self)
    }
}


        
