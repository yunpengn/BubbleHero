//
//  SoundEffectController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import AVFoundation

/**
 Controller for sound effects.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class SoundEffectController {
    /// The player for background music.
    private var player: AVAudioPlayer?

    /// Plays a certain sound effect once.
    /// - Parameter effect: The sound effect played.
    func play(_ effect: SoundEffect) {
        let fileName = effect.rawValue
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            return
        }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }
}

/**
 An enum for all possible sound effects.
 */
enum SoundEffect: String {
    case thunder = "thunder.mp3"
    case bomb = "bomb.mp3"
    case timeup = "doorbell.mp3"
}
