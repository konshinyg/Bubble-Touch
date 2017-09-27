//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuBackboard: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundBase.sharedInstance().startPlayBackground(filename: "bonja.mp3")
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        SoundBase.sharedInstance().startPlay(filename: "button_press.wav")
        if let storyboard = storyboard {
            let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            navigationController?.pushViewController(gameViewController, animated: false)
        }
    }
}
