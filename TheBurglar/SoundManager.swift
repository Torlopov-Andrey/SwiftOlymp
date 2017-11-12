import Foundation
import AVFoundation

class SoundManager {
    
    static private let shared = SoundManager()
    static private let names = ["click_1", "click_2", "click_3", "click_4", "click_5", "click_6"]
    static private let successSuffix = "_success"
    static private let fileExtension = "mp3"
    static private let volume: Float = 0.5
    
    private var currentSoundNum: Int = 0
    
    private lazy var soundPlayer: AVAudioPlayer = {
        return try! AVAudioPlayer(contentsOf: SoundManager.shared.sounds[SoundManager.shared.currentSoundNum].click)
    }()
    
    private var sounds = [(click: URL, successClick: URL)]()
    
    private init() {
        SoundManager.names.forEach({ (name) in
            let url: URL = Bundle.main.url(forResource: name, withExtension: SoundManager.fileExtension)!
            let successUrl: URL = Bundle.main.url(forResource: "\(name)\(SoundManager.successSuffix)", withExtension: SoundManager.fileExtension)!
            sounds.append((click: url, successClick: successUrl))
        })
    }

    //MARK: - Public API
    
    class func setupSound(num: Int) {
        guard num < SoundManager.shared.sounds.count && num >= 0 else {
            preconditionFailure( "Expected num in range 0...\(SoundManager.shared.sounds.count-1). Fetched unexpected num \(num)")
        }
        
        SoundManager.shared.currentSoundNum = num
    }
    
    class func playSound(success: Bool = false) {
        SoundManager.shared.soundPlayer.volume = SoundManager.volume
        if success {
            SoundManager.shared.soundPlayer = try! AVAudioPlayer(contentsOf: SoundManager.shared.sounds[SoundManager.shared.currentSoundNum].successClick)
        }
        else {
            SoundManager.shared.soundPlayer = try! AVAudioPlayer(contentsOf: SoundManager.shared.sounds[SoundManager.shared.currentSoundNum].click)
        }
        SoundManager.shared.soundPlayer.play()
    }
    
    class func stopSound() {
        SoundManager.shared.soundPlayer.stop()
    }
    
    class func count() -> Int {
        return SoundManager.shared.sounds.count
    }
    
    class func currentSoundNumber() -> Int {
        return SoundManager.shared.currentSoundNum
    }
    
    class func nextSoundNumber() -> Int {
        let number = SoundManager.currentSoundNumber() >= SoundManager.count() - 1 ? 0: SoundManager.currentSoundNumber() + 1
        return number
    }
}
