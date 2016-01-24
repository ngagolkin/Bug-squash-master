//
//  BackgroundImage.swift
//  Bug squash
//
//  Created by Darvydas on 09/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class BackgroundImage: SKSpriteNode {
    
    init(mainScene: SKNode, imagePosition: CGPoint, imageName: String) {
        
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.height / 10, mainScene.frame.size.height / 10))
        position = imagePosition
        name = imageName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
