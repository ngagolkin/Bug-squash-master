//
//  ScoreLabel.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreLabel: SKSpriteNode {
    
    var scoreLabel: SKLabelNode!
    
    var score: Int = 0
    
    init(mainScene: SKNode) {
        
        super.init(texture: SKTexture(imageNamed: "score bar"), color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.width / 3, mainScene.frame.size.height / 20))
        position = CGPointMake(mainScene.frame.size.width / 18 + frame.size.width / 2, mainScene.frame.size.height / 32 * 31 - frame.size.height / 2)
        userInteractionEnabled = true
        zPosition = 850
        
        createScoreLabel()
    }
    
    func incrementScore() {
        
        score+=10
        scoreLabel.text = "\(score)"
    }
    
    func createScoreLabel() {
        
        scoreLabel = SKLabelNode(fontNamed: kFontName)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        scoreLabel.fontColor = UIColor.whiteColor()
        scoreLabel.fontSize = frame.size.height * 0.7
        scoreLabel.position = CGPointMake(0, -scoreLabel.fontSize / 3)
        scoreLabel.text = "\(score)"
        
        addChild(scoreLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}