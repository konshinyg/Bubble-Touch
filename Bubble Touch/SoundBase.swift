
import AVFoundation
import SpriteKit

public class SoundBase {
    
    public var playerBackground: AVAudioPlayer?
    public var player: AVAudioPlayer?
    var isPlaying = false
    
    static let sharedInstance = SoundBase() // Singleton
    
    let bubbleTouchSound0 = SKAction.playSoundFileNamed("ah", waitForCompletion: false)
    let bubbleTouchSound1 = SKAction.playSoundFileNamed("burp1", waitForCompletion: false)
    let bubbleTouchSound2 = SKAction.playSoundFileNamed("burp2", waitForCompletion: false)
    let bubbleTouchSound3 = SKAction.playSoundFileNamed("burp3", waitForCompletion: false)
    let bubbleTouchSound4 = SKAction.playSoundFileNamed("pu1", waitForCompletion: false)
    let bubbleTouchSound5 = SKAction.playSoundFileNamed("pu2", waitForCompletion: false)
    let bubbleTouchSound6 = SKAction.playSoundFileNamed("pu3", waitForCompletion: false)
    let bubbleTouchSound7 = SKAction.playSoundFileNamed("pu4", waitForCompletion: false)
    let bubbleTouchSound8 = SKAction.playSoundFileNamed("pu5", waitForCompletion: false)
    let bubbleTouchSound9 = SKAction.playSoundFileNamed("pu6", waitForCompletion: false)
    let bubbleTouchSound10 = SKAction.playSoundFileNamed("pu7", waitForCompletion: false)
    let bubbleTouchSound11 = SKAction.playSoundFileNamed("BOING2", waitForCompletion: false)
    let bubbleTouchSound12 = SKAction.playSoundFileNamed("OORR", waitForCompletion: false)
    let bubbleTouchSound13 = SKAction.playSoundFileNamed("NASTY_CO", waitForCompletion: false)
    let bubbleTouchSound14 = SKAction.playSoundFileNamed("SHATTER", waitForCompletion: false)
    let bubbleTouchSound15 = SKAction.playSoundFileNamed("RIFLE", waitForCompletion: false)
    let bubbleTouchSound16 = SKAction.playSoundFileNamed("BOO", waitForCompletion: false)
    let bubbleTouchSound17 = SKAction.playSoundFileNamed("GFY_HAHA", waitForCompletion: false)
    let bubbleTouchSound18 = SKAction.playSoundFileNamed("CL_THRTS", waitForCompletion: false)
    let bubbleTouchSound19 = SKAction.playSoundFileNamed("BULLFROG", waitForCompletion: false)
    let bubbleTouchSound20 = SKAction.playSoundFileNamed("BROKEN_D", waitForCompletion: false)
    let bubbleTouchSound21 = SKAction.playSoundFileNamed("A_BOING", waitForCompletion: false)
    let bubbleTouchSound22 = SKAction.playSoundFileNamed("BLUUP_2", waitForCompletion: false)
    let bubbleTouchSound23 = SKAction.playSoundFileNamed("UHH-UHH2", waitForCompletion: false)
    let bubbleTouchSound24 = SKAction.playSoundFileNamed("SH_GARGL", waitForCompletion: false)
    let bubbleTouchSound25 = SKAction.playSoundFileNamed("BAAA", waitForCompletion: false)
    let bubbleTouchSound26 = SKAction.playSoundFileNamed("SNAP", waitForCompletion: false)
    let bubbleTouchSound27 = SKAction.playSoundFileNamed("DOG_BARK", waitForCompletion: false)
    let bubbleTouchSound28 = SKAction.playSoundFileNamed("SIN_LAFF", waitForCompletion: false)
    let bubbleTouchSound29 = SKAction.playSoundFileNamed("PLASMAEX", waitForCompletion: false)
    let bubbleTouchSound30 = SKAction.playSoundFileNamed("ACK_2", waitForCompletion: false)
    let bubbleTouchSound31 = SKAction.playSoundFileNamed("burp6", waitForCompletion: false)
    let bubbleTouchSound32 = SKAction.playSoundFileNamed("pu8", waitForCompletion: false)
    let bubbleTouchSound33 = SKAction.playSoundFileNamed("pu9", waitForCompletion: false)
    let bubbleTouchSound34 = SKAction.playSoundFileNamed("pu10", waitForCompletion: false)
    let bubbleTouchSound35 = SKAction.playSoundFileNamed("pu11", waitForCompletion: false)
    let bubbleTouchSound36 = SKAction.playSoundFileNamed("pu12", waitForCompletion: false)
    let bubbleTouchSound37 = SKAction.playSoundFileNamed("pu13", waitForCompletion: false)
    let bubbleTouchSound38 = SKAction.playSoundFileNamed("pu14", waitForCompletion: false)
    let bubbleTouchSound39 = SKAction.playSoundFileNamed("pu15", waitForCompletion: false)
    let bubbleTouchSound40 = SKAction.playSoundFileNamed("burp4", waitForCompletion: false)
    let bubbleTouchSound41 = SKAction.playSoundFileNamed("burp5", waitForCompletion: false)
    let bubbleTouchSound42 = SKAction.playSoundFileNamed("BOY_LAFF", waitForCompletion: false)
    let bubbleTouchSound43 = SKAction.playSoundFileNamed("GFY", waitForCompletion: false)
    let bubbleTouchSound44 = SKAction.playSoundFileNamed("GIGGLEDY", waitForCompletion: false)
    let bubbleTouchSound45 = SKAction.playSoundFileNamed("UHH", waitForCompletion: false)
    
    let blueBallTouchSound = SKAction.playSoundFileNamed("tada", waitForCompletion: false)
    let bombTouchSound = SKAction.playSoundFileNamed("bombRumble", waitForCompletion: false)
    
    var soundsArray = [SKAction]()
    init() {
        soundsArray = [bubbleTouchSound0, bubbleTouchSound1, bubbleTouchSound2, bubbleTouchSound3, bubbleTouchSound4, bubbleTouchSound5, bubbleTouchSound6, bubbleTouchSound7, bubbleTouchSound8, bubbleTouchSound9, bubbleTouchSound10, bubbleTouchSound11, bubbleTouchSound12, bubbleTouchSound13, bubbleTouchSound14, bubbleTouchSound15, bubbleTouchSound16, bubbleTouchSound17, bubbleTouchSound18, bubbleTouchSound19, bubbleTouchSound20, bubbleTouchSound21, bubbleTouchSound22, bubbleTouchSound23, bubbleTouchSound24, bubbleTouchSound25, bubbleTouchSound26, bubbleTouchSound27, bubbleTouchSound28, bubbleTouchSound29, bubbleTouchSound30, bubbleTouchSound31, bubbleTouchSound32, bubbleTouchSound33, bubbleTouchSound34, bubbleTouchSound35, bubbleTouchSound36, bubbleTouchSound37, bubbleTouchSound38, bubbleTouchSound39, bubbleTouchSound40, bubbleTouchSound41, bubbleTouchSound42, bubbleTouchSound43, bubbleTouchSound44, bubbleTouchSound45]
    }
    
    public func playSoundEffect(filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.numberOfLoops = 0
            player?.prepareToPlay()
            player?.play()
        } catch {
            player = nil
        }
    }
    
    public func playBackground(filename: String) {
        if !isPlaying {
            let url = Bundle.main.url(forResource: filename, withExtension: nil)
            do {
                playerBackground = try AVAudioPlayer(contentsOf: url!)
                playerBackground?.numberOfLoops = -1
                playerBackground?.prepareToPlay()
                playerBackground?.play()
                isPlaying = true
            } catch { playerBackground = nil }
        } else { resumeBackground() }
    }
    
    public func pauseBackground() {
        if let player = playerBackground {
            if player.isPlaying {
                player.pause()
            }
        }
    }
    
    public func resumeBackground() {
        if let player = playerBackground {
            if !player.isPlaying {
                player.play()
            }
        }
    }
}
