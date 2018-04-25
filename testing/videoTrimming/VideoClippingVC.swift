//
//  VideoClippingVC.swift
//  testing
//
//  Created by admin on 4/25/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import PryntTrimmerView
import AVKit

/// A view controller to demonstrate the trimming of a video. Make sure the scene is selected as the initial
// view controller in the storyboard

class VideoClippingVC: AssetSelectionViewController {
  
  @IBOutlet weak var trimmerView: TrimmerView!
  @IBOutlet weak var playerView: UIView!
  
  @IBOutlet weak var btnPlay: UIButton!
  var player: AVPlayer?
  var playbackTimeCheckerTimer: Timer?
  var trimmerPositionChangedTimer: Timer?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //trimmerView.delegate = self
    trimmerView.handleColor = UIColor.white
    trimmerView.mainColor = UIColor.darkGray
    //trimmerView.ass
    
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  private func addVideoPlayer(with asset: AVAsset, playerView: UIView) {
    let playerItem = AVPlayerItem(asset: asset)
    player = AVPlayer(playerItem: playerItem)
    
    NotificationCenter.default.addObserver(self, selector: #selector(VideoClippingVC.itemDidFinishPlaying(_:)),
                                           name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    
    let layer: AVPlayerLayer = AVPlayerLayer(player: player)
    layer.backgroundColor = UIColor.white.cgColor
    layer.frame = CGRect(x: 0, y: 0, width: playerView.frame.width, height: playerView.frame.height)
    layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    playerView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
    playerView.layer.addSublayer(layer)
  }
  
  @objc func itemDidFinishPlaying(_ notification: Notification) {
    if let startTime = trimmerView.startTime {
      player?.seek(to: startTime)
      
    }
  }
  
  func startPlaybackTimeChecker() {
    
    stopPlaybackTimeChecker()
    playbackTimeCheckerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                                    selector:
      #selector(VideoClippingVC.onPlaybackTimeChecker), userInfo: nil, repeats: true)
  }
  
  func stopPlaybackTimeChecker() {
    
    playbackTimeCheckerTimer?.invalidate()
    playbackTimeCheckerTimer = nil
  }
  
  @objc func onPlaybackTimeChecker() {
    
    guard let startTime = trimmerView.startTime, let endTime = trimmerView.endTime, let player = player else {
      return
    }
    
    let playBackTime = player.currentTime()
    trimmerView.seek(to: playBackTime)
    
    if playBackTime >= endTime {
      player.seek(to: startTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
      trimmerView.seek(to: startTime)
    }
  }
  
  //MARK:- Actions
  @IBAction func play(_ sender: Any) {
    
    guard let player = player else { return }
    
    if !player.isPlaying {
      player.play()
      startPlaybackTimeChecker()
    } else {
      player.pause()
      
      stopPlaybackTimeChecker()
    }
  }
  
  @IBAction func selectAsset(_ sender: Any) {
    loadAssetRandomly()
    
  }
  
  override func loadAsset(_ asset: AVAsset) {
    
    trimmerView.asset = asset
    trimmerView.delegate = self
    addVideoPlayer(with: asset, playerView: playerView)
  }
  
}

extension VideoClippingVC: TrimmerViewDelegate {
  func positionBarStoppedMoving(_ playerTime: CMTime) {
    player?.seek(to: playerTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    player?.play()
    startPlaybackTimeChecker()
  }
  
  func didChangePositionBar(_ playerTime: CMTime) {
    stopPlaybackTimeChecker()
    player?.pause()
    player?.seek(to: playerTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    let duration = (trimmerView.endTime! - trimmerView.startTime!).seconds
    print(duration)
  }
}

extension AVPlayer {
  
  var isPlaying: Bool {
    return self.rate != 0 && self.error == nil
  }
}
