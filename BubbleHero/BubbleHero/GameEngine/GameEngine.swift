//
//  GameEngine.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

import UIKit

/**
 This class implements a simplified game engine that consists of a 2D physics
 engine and a rendering engine. Any object that has been registered in the game
 engine will be managed by the game engine from then on, until it is deregistered
 from the engine.

 All objects registered in the game engine are called `GameObject`s. You should
 register each `GameObject` with only one game engine.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
class GameEngine: GameEngineDelegate {
    /// The rendering engine for this game engine.
    private let renderer: Renderer
    /// The 2D physics engine for this game engine.
    private let physics: PhysicsEngine2D
    /// The area for this game engine, in which all `GameObject`s should reside.
    private let area: CGRect
    /// A list of all `GameObject`s controlled by this `GameEngine`.
    private var gameObjects: [GameObject] = []

    /// Creates a new game engine by attaching a rending engine to it.
    /// - Parameters:
    ///    - renderer: The rendering engine for the game engine.
    ///    - area: The area for the game engine.
    init(renderer: Renderer, area: CGRect) {
        self.renderer = renderer
        self.area = area
        physics = PhysicsEngine2D(area: area)
        physics.gameEngine = self

        let displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: .defaultRunLoopMode)
    }

    /// A "step" that each registered `GameObject` should perform per frame of the
    /// `CADisplayLink`, which will in turn be controlled by the physics engine and
    /// rendering engine.
    /// - Parameter displayLink: The timer object that synchronizes the drawing to
    /// the refresh rate of the display.
    @objc private func step(displayLink: CADisplayLink) {
        // Use the physics engine to update all `PhysicsObject`s.
        physics.update()
        // Use the rendering engine to render all `GameObject`s.
        gameObjects.forEach { renderer.render(for: $0) }
    }

    /// Registers a new `GameObject` into this `GameEngine`, which will be managed
    /// by the game engine from now on. You should deregister this `GameObject`
    /// before you call this method if it has been registered into any `GameEngine`
    /// before.
    ///
    /// Notice: You should call `registerPhysicsObject` if it is a `PhysicsObject`
    /// and you want the physics engine to manage its movement & collision.
    /// - Parameter toRegister: The `GameObject` being registered.
    func registerGameObject(_ toRegister: GameObject) {
        gameObjects.append(toRegister)
    }

    /// Registers a `PhysicsObject` into this `GameEngine` and the associated
    /// `PhysicsEngine`.
    /// - Parameter toRegister: The `PhysicsObject` being registered.
    func registerPhysicsObject(_ toRegister: PhysicsObject) {
        registerGameObject(toRegister)
        physics.registerPhysicsObject(toRegister)
    }

    /// Deregisters a `GameObject` from this `GameEngine`, which will not be managed
    /// by the game engine anymore. This method will do nothing if the `GameObject`
    /// was not registered with this `GameEngine` before.
    ///
    /// Notice: You should call `deregisterPhysicsObject` if it is a `PhysicsObject`
    /// and it is managed by the physics engine.
    /// - Parameter toDeregister: The `GameObject` being deregistered.
    func deregisterGameObject(_ toDeregister: GameObject) {
        gameObjects = gameObjects.filter { $0 !== toDeregister }
        renderer.disappear(toDeregister)
    }

    func deregisterPhysicsObject(_ toDeregister: PhysicsObject) {
        deregisterGameObject(toDeregister)
        physics.deregisterPhysicsObject(toDeregister)
    }
}

/**
 Acts as a delegate for game engine.
 */
protocol GameEngineDelegate {
    /// Deregisters a `PhysicsObject` from this `GameEngine` and the associated
    /// `PhysicsEngine`.
    /// - Parameter toDeregister: The `PhysicsObject` being registered.
    func deregisterPhysicsObject(_ toDeregister: PhysicsObject)
}
