//
//  GameViewTimerController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 03/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the timer in the game view.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewTimerController {
    /// The label in view for the timer.
    private let label: UILabel
    /// The actual timer object.
    private var timer: Timer?
    /// The time in seconds left.
    private var seconds = Settings.timePerGame
    /// The current status of the time.
    private var status = TimerStatus.normal
    /// The delegate for `GameViewController`.
    weak var controllerDelegate: GameViewControllerDelegate?
    /// The controller for playing sound effects.
    let soundEffectController = SoundEffectController()

    /// Creates a new timer by associating with a label.
    /// - Parameter label: The label in view associated.
    init(label: UILabel) {
        self.label = label
    }

    /// Begins the timer.
    func begin() {
        seconds = Settings.timePerGame
        status = .normal
        updateLabel()
        timer = Timer.scheduledTimer(timeInterval: 1,
                      target: self,
                      selector: #selector(updateLabel),
                      userInfo: nil,
                      repeats: true)
    }

    /// A step function for updating the label.
    @objc
    private func updateLabel() {
        let newStatus = TimerStatus.getStatus(by: seconds)
        if status != newStatus {
            label.textColor = newStatus.toColor()
            status = newStatus
        }

        label.text = String(format: Settings.timerLabelFormat,
                            seconds / Settings.secondPerMinute,
                            seconds % Settings.secondPerMinute)
        seconds -= 1

        if seconds < 0 {
            timer?.invalidate()
            controllerDelegate?.stopGame()
            soundEffectController.play(.timeup)
        }
    }
}

/**
 Defines the status of timer according to the time left.
 */
enum TimerStatus {
    case normal
    case warn
    case danger

    /// Converts to the color used in the timer label.
    /// - Returns: The color for the timer label.
    func toColor() -> UIColor {
        switch self {
        case .normal:
            return UIColor.white
        case .warn:
            return UIColor.yellow
        case .danger:
            return UIColor.red
        }
    }

    /// Converts the time left to the corresponding status.
    /// - Parameter seconds: The time left in seconds.
    /// - Returns: The corresonding status.
    static func getStatus(by seconds: Int) -> TimerStatus {
        if seconds > Settings.secondPerMinute {
            return .normal
        } else if seconds > Settings.secondPerMinute / 2 {
            return .warn
        } else {
            return .danger
        }
    }
}
