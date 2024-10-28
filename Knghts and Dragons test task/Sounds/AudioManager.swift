import AVFoundation
import UIKit

class AudioManager {
    static let shared = AudioManager()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var soundEffectsPlayers: [String: AVAudioPlayer] = [:]

    private var musicEnabled = true
    private var soundsEnabled = true
    private var vibrationEnabled = true
    
    private init() {
        loadSettings()
    }
    
    var isSoundsEnabled: Bool {
        return soundsEnabled
    }
    
    var isMusicEnabled: Bool {
        return musicEnabled
    }
    
    var isVibrationEnabled: Bool {
        return vibrationEnabled
    }
    
    func playBackgroundMusic(named filename: String) {
        guard musicEnabled else { return }
        if let url = Bundle.main.url(forResource: filename, withExtension: nil) {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.play()
            } catch {
                print("Failed to play background music: \(error)")
            }
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func playSoundEffect(named filename: String) {
        guard soundsEnabled, let url = Bundle.main.url(forResource: filename, withExtension: nil) else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.play()
            soundEffectsPlayers[filename] = player
        } catch {
            print("Failed to play sound effect: \(error)")
        }
    }
    
    func playVibration() {
        if vibrationEnabled {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
    
    func setMusicEnabled(_ enabled: Bool) {
        musicEnabled = enabled
        if !enabled { stopBackgroundMusic() }
        saveSettings()
    }
  
    func setSoundsEnabled(_ enabled: Bool) {
        soundsEnabled = enabled
        saveSettings()
    }
  
    func setVibrationEnabled(_ enabled: Bool) {
        vibrationEnabled = enabled
        saveSettings()
    }
    
     func loadSettings() {
         let userDefaults = UserDefaults.standard
         musicEnabled = userDefaults.bool(forKey: "musicEnabled")
         soundsEnabled = userDefaults.bool(forKey: "soundsEnabled")
         vibrationEnabled = userDefaults.bool(forKey: "vibrationEnabled")
     }
  
    func saveSettings() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(musicEnabled, forKey: "musicEnabled")
        userDefaults.set(soundsEnabled, forKey: "soundsEnabled")
        userDefaults.set(vibrationEnabled, forKey: "vibrationEnabled")
    }
}
