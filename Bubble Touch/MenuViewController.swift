//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundBase.sharedInstance().startPlayBackground(filename: "bonja.mp3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    @IBAction func startButtonPressed(_ sender: UIButton) {
        SoundBase.sharedInstance().startPlay(filename: "button_press.wav")
        if let storyboard = storyboard {
            let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            navigationController?.pushViewController(gameViewController, animated: false)
        }
    }
}
