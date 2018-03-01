//
//  GameViewController.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 27/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 Controller for the game view, which is the scene for the player to play the
 actual game.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameViewController: UIViewController {
    /// The body of the cannon used to shoot bubble.
    @IBOutlet private weak var cannonBody: CannonView!
    /// The next bubble to be launched.
    @IBOutlet private weak var nextBubble: BubbleView!
    /// The next second bubble to be launched.
    @IBOutlet private weak var nextSecondBubble: BubbleView!
    /// The controller for bubble launch.
    private var launchController: GameViewLaunchController?
    /// The physics engine for this controller.
    private var physicsEngine: PhysicsEngine2D?
    /// The level to start with.
    var level: Level?

    override func viewDidLoad() {
        super.viewDidLoad()
        physicsEngine = PhysicsEngine2D(renderer: self, area: view.frame)
        launchController = GameViewLaunchController(cannon: cannonBody,
                                                    nextBubble: nextBubble,
                                                    nextSecondBubble: nextSecondBubble)
        launchController?.engine = physicsEngine
        loadLevel()
    }

    /// Always hide the status bar on the top.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// Updates the cannon and launches the bubble when the drag gesture is recognized.
    /// - Parameter sender: The gesture recognizer being triggered.
    @IBAction func handleDragGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)

        // Rotates the angle of the cannon during the duration of the long press gesture.
        if sender.state == .changed {
            launchController?.rotateCannon(to: location)
        }
        // Launches the bubble when the long press gesture is released.
        if sender.state == .ended {
            launchController?.launchBubble(to: location)
        }
    }
    
    /// Loads a level to start the game with.
    private func loadLevel() {
        guard let startLevel = level else {
            return
        }
        let game = Game(from: startLevel)
        game.bubbleObjects.forEach { physicsEngine?.registerPhysicsObject($0) }
    }
}
