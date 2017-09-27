//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var menuBackboard: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "highScore") != nil {
            let highScore = UserDefaults.standard.object(forKey: "highScore") as! Int
                highScoreLabel.text = "\(highScore) points"
        } else {
            UserDefaults.standard.set(0, forKey: "highScore")
            highScoreLabel.text = "0 points"
        }
        SoundBase.sharedInstance().playBackground(filename: "bonja.mp3")
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        SoundBase.sharedInstance().playSoundEffect(filename: "button_press.wav")
        SoundBase.sharedInstance().pauseBackground()
        if let storyboard = storyboard {
            let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            navigationController?.pushViewController(gameViewController, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        SoundBase.sharedInstance().playSoundEffect(filename: "button_press.wav")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
