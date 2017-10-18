//
//  GameViewController.swift
//  Bubble Touch
//
//  Created by Core on 22.09.17.
//  Copyright © 2017 Cornelius. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameTimer: UILabel!
    @IBOutlet weak var woodenImage4: UIImageView!
    @IBOutlet weak var woodenImage3: UIImageView!
    @IBOutlet weak var backboard: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var timesUpLabel: UILabel!
    @IBOutlet weak var woodenImage1: UIImageView!
    @IBOutlet weak var woodenImage2: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let scene = GameScene(size: CGSize(width: 1024, height: 768))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene.scaleMode = .resizeFill
        
        let view = self.view as! SKView
        view.presentScene(scene)
        view.showsNodeCount = true
        view.ignoresSiblingOrder = true
        scene.gameViewControllerBridge = self
        
        woodenImage4.isHidden = false
        woodenImage3.isHidden = false
        scoreLabel.isHidden = false
        gameTimer.isHidden = false
        woodenImage1.isHidden = true
        woodenImage2.isHidden = true
        reloadButton.isHidden = true
        finalScoreLabel.isHidden = true
        timesUpLabel.isHidden = true
        backboard.isHidden = true
    }
    
    @IBAction func reloadGame(_ sender: UIButton) {
        SoundBase.sharedInstance.playSoundEffect(filename: "button_press.wav")
        scene.score = 0
        if let storyboard = storyboard {
            let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            navigationController?.pushViewController(menuViewController, animated: false)
        }
    }
    
    func endGame() {
        finalScoreLabel.text = "score: \(scene.score) points"
        if scene.score > UserDefaults.standard.object(forKey: "highScore") as! Int {
            UserDefaults.standard.set(scene.score, forKey: "highScore")
        }
        SoundBase.sharedInstance.playBackground(filename: "bonja.mp3")
        woodenImage4.isHidden = true
        woodenImage3.isHidden = true
        scoreLabel.isHidden = true
        gameTimer.isHidden = true
        woodenImage1.isHidden = false
        woodenImage2.isHidden = false
        reloadButton.isHidden = false
        finalScoreLabel.isHidden = false
        timesUpLabel.isHidden = false
        backboard.isHidden = false
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
