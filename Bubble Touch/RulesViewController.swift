//
//  rulesViewController.swift
//  Bubble Touch
//
//  Created by Core on 27.09.17.
//  Copyright © 2017 Cornelius. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("burp")
        SoundBase.sharedInstance().playSoundEffect(filename: "button_press.wav")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
