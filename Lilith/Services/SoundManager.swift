//
//  SoundManager.swift
//  Lilith
//
//  Created by GE-Developer
//

import AVFoundation

@MainActor
final class SoundManager {
    
    var isSoundOff: Bool {
        didSet { defaults.set(isSoundOff, forKey: key) }
    }
    
    static let shared = SoundManager()
    
    private let defaults = UserDefaults.standard
    private let key = AppStorageKey.sound.key
    private var player: AVAudioPlayer?
    
    private init() {
        isSoundOff = defaults.bool(forKey: key)
        configureAudioSession()
    }
    
    func playSound() {
        guard !isSoundOff else { return }
        
        guard let url = Bundle.main.url(forResource: "tapSound", withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch { }
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }
    }
}
