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
class GameEngine {
    /// The rendering engine for this game engine.
    private let renderer: Renderer
    /// The 2D physics engine for this game engine.
    private let physics = PhysicsEngine2D()
    /// The area for this game engine, in which all `GameObject`s should reside.
    private let area: CGRect
    /// A list of all `GameObject`s controlled by this `GameEngine`.
    private var gameObjects: [GameObject] = []

    /// Creates a new game engine by attaching a rending engine to it.
    init(renderer: Renderer, area: CGRect) {
        self.renderer = renderer
        self.area = area
    }

    /// Registers a new `GameObject` into this `GameEngine`, which will be managed
    /// by the game engine from now on. The `GameObject` must be deregistered if
    /// it has been registered into any `GameEngine` before.
    /// - Parameter toRegister: The `GameObject` being registered.
    func registerGameObject(_ toRegister: GameObject) {
        gameObjects.append(toRegister)
    }

    /// Deregisters a `GameObject` from this `GameEngine`, which will not be managed
    /// by the game engine anymore. This method will do nothing if the `GameObject`
    /// was not registered with this `GameEngine` before.
    /// - Parameter toDeregister: The `GameObject` being deregistered.
    func deregisterGameObject(_ toDeregister: GameObject) {
        // We have to use identity operator because there is no other possible
        // way to identify the most generic form of a `GameObject`.
        gameObjects = gameObjects.filter { $0 !== toDeregister }
    }
}
