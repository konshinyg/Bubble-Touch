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
        view.ignoresSiblingOrder = true
        scene.gameViewControllerBridge = self
        
        woodenImage1.isHidden = true
        woodenImage2.isHidden = true
        woodenImage3.isHidden = false
        scoreLabel.isHidden = false
        reloadButton.isHidden = true
        finalScoreLabel.isHidden = true
        timesUpLabel.isHidden = true
        backboard.isHidden = true
    }
    
    @IBAction func reloadGame(_ sender: UIButton) {
        SoundBase.sharedInstance().startPlay(filename: "button_press.wav")
        scene.score = 0
        if let storyboard = storyboard {
            let menuViewController = storyboard.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
            navigationController?.pushViewController(menuViewController, animated: true)
        }
    }
    
    func endGame() {
        finalScoreLabel.text = "score: \(scene.score) points"
        woodenImage1.isHidden = false
        woodenImage2.isHidden = false
        woodenImage3.isHidden = true
        scoreLabel.isHidden = true
        reloadButton.isHidden = false
        finalScoreLabel.isHidden = false
        timesUpLabel.isHidden = false
        backboard.isHidden = false
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
