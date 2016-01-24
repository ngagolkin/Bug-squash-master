//
//  HealthBar.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class HealthBar: SKSpriteNode {
    
    var world: SKNode!
    var health: Int = kStartingHealth
    var isDead: Bool = false
    var scoreLabel: ScoreLabel!
    var gameScene: GameScene!
    
    init(mainScene: SKNode, sl: ScoreLabel, gs: GameScene) {
        
        world = mainScene
        scoreLabel = sl
        gameScene = gs
        
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(world.frame.size.width / 3, world.frame.size.height / 24))
        position = CGPointMake(world.frame.size.width / 5 * 4, world.frame.size.height / 32 * 4)
        name = "HealthBar"
        zPosition = 850
        
        for var i = 1; i <= kStartingHealth; i++ {
            
            createHeart(CGPointMake(-frame.size.width / 2 + frame.size.width / CGFloat(kStartingHealth + 1) * CGFloat(i), 0))
        }
    }
    
    func dealDamage() {
        
        if isDead == false {
            health--
            
            self.enumerateChildNodesWithName("heart", usingBlock: {
                (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
                
                node.removeFromParent()
            })
            
            if health > 0 {
                
                for var i = 1; i <= health; i++ {
                    
                    createHeart(CGPointMake(-frame.size.width / 2 + frame.size.width / CGFloat(kStartingHealth + 1) * CGFloat(i), 0))
                }
            } else {
                isDead = true
                
                let gameOverScene = GameOverScreen.init(mainScene: world, score: scoreLabel.score)
                world.addChild(gameOverScene)
                
                gameScene.gameOver = true
            }
        }
    }
    
    func createHeart(heartPosition: CGPoint) {
        
        let heart = SKSpriteNode(texture: SKTexture(imageNamed: "heart"), color: UIColor.clearColor(), size: CGSizeMake(frame.size.height, frame.size.height))
        heart.position = heartPosition
        heart.name = "heart"
        
        addChild(heart)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}