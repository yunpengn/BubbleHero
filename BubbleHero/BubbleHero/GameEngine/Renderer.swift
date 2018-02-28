//
//  Render.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Any object that conforms to `Renderer` protocol can act as the rendering engine for
 a game engine.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
protocol Renderer {
    /// Render a `GameObject`, such as updating its location and shape in the view.
    func render(for object: GameObject)

    /// Makes a `GameObject` disappear by removing its associated `UIView` object from
    /// its `superview`.
    func disappear(_ object: GameObject)
}
