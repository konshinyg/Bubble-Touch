//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuBackboard: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
