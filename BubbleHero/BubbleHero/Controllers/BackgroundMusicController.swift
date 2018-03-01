//
//  BackgroundMusicController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import AVFoundation

/**
 Controller for playing background music.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class BackgroundMusicController {
    /// The player for background music.
    private var player: AVAudioPlayer?

    /// Creates a background music controller by giving the name of the music file.
    /// - Parameter fileName: The name of the music file.
    init(for fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            return
        }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.numberOfLoops = Settings.musicInfiniteLoop
        player?.prepareToPlay()
        player?.play()
    }
}
