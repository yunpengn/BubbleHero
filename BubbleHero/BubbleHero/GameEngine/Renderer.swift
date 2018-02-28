//
//  Render.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 28/02/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

protocol Renderer {
    /// Render a `GameObject` 
    func render(for object: GameObject)

    /// Makes a `GameObject` disappear by removing its associated `UIView` object from
    /// its `superview`.
    func disappear(_ object: GameObject)
}
