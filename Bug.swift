//
//  File.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class Bug: SKSpriteNode {
    
    var world: SKNode!
    var bugType: Int = 0
    
    var pointToMove: CGPoint!
    
    var isDead: Bool = false
    var isSplashed: Bool = false
    
    var health: Int = 1
    
    var textureName1: [String] = [
        "ant_1",
        "cockcroach_1",
        "ladyBug_1",
        "spider_1",
    ]
    
    var textureName2: [String] = [
        "ant_2",
        "cockcroach_2",
        "ladyBug_2",
        "spider_2",
    ]
    
    var textureName3: [String] = [
        "ant_3",
        "cockcroach_3",
        "ladyBug_3",
        "spider_3",
    ]
    
    var textureName4: [String] = [
        "ant_4",
        "cockcroach_4",
        "ladyBug_4",
        "spider_4",
    ]
    
    var textureName5: [String] = [
        "ant_5",
        "cockcroach_5",
        "ladyBug_5",
        "spider_5",
    ]
    
    var textureName6: [String] = [
        "ant_6",
        "cockcroach_6",
        "ladyBug_6",
        "spider_6",
    ]
    
    var textureName7: [String] = [
        "ant_7",
        "cockcroach_7",
        "ladyBug_7",
        "spider_7",
    ]
    
    var textureName8: [String] = [
        "ant_8",
        "cockcroach_8",
        "ladyBug_8",
        "spider_8",
    ]
    
    var texutureNameSplash: [String] = [
        "ant_squash",
        "cockroach_squash",
        "ladyBug_squash",
        "spider_squash",
    ]
    
    
    init(mainScene: SKNode, score: Int) {
        
        world = mainScene
        
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(world.frame.size.height / 10, world.frame.size.height / 8))
        position = getRandomPosition()
        zPosition = 500
        
        bugType = getBugType(score)
        
        pointToMove = CGPointMake(position.x, -frame.size.height / 2)
        
        if bugType == 3 {
            health = 2 // set health to 2 if type is spider
        }
        
        runAction(SKAction.sequence([
            SKAction.moveTo( pointToMove, duration: kBugCrawlTimeToReachDestination),
            SKAction.performSelector("dealDamage", onTarget: self),
            SKAction.removeFromParent()
            ]))
        
        let xDistance = -position.x + pointToMove.x
        let yDistance = -position.y + pointToMove.y
        
        let angle = CGFloat(atan2f(Float(yDistance), Float(xDistance))) + CGFloat(-M_PI / 2)
        
        runAction(SKAction.rotateToAngle(angle, duration: 0.0))
        
        bugCrawling()
    }
    
    func getBugType(gameScore: Int) -> Int{
        
        if gameScore < 50 {
            
            return 0
        } else if gameScore < 100 {
            
            if arc4random_uniform(100) < 33{
                
                return 1
            }
            return 0
        } else if gameScore < 200 {
            
            if arc4random_uniform(100) < 20{
                
                return 1
            }
            if arc4random_uniform(100) < 20{
                
                return 2
            }
            return 0
        } else if gameScore < 500 {
            
            if arc4random_uniform(100) < 33{
                
                return 1
            }
            if arc4random_uniform(100) < 33{
                
                return 2
            }
            return 0
        } else if gameScore < 2000 {
            
            if arc4random_uniform(100) < 25{
                
                return 1
            }
            if arc4random_uniform(100) < 25{
                
                return 2
            }
            if arc4random_uniform(100) < 10{
                
                return 3
            }
            return 0
        } else if gameScore < 5000 {
            
            if arc4random_uniform(100) < 25{
                
                return 1
            }
            if arc4random_uniform(100) < 25{
                
                return 2
            }
            if arc4random_uniform(100) < 25{
                
                return 3
            }
            return 0
        } else {
            
            if arc4random_uniform(100) < 20{
                
                return 1
            }
            if arc4random_uniform(100) < 20{
                
                return 2
            }
            if arc4random_uniform(100) < 35{
                
                return 3
            }
            return 0
        }
    }
    
    func dealDamage() {
        
        world.runAction(SKAction.playSoundFileNamed("Bite.wav", waitForCompletion: false))
        
        world.enumerateChildNodesWithName("HealthBar", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            
            let healthBar = node as! HealthBar
            
            if self.bugType == 3 {
                
                healthBar.dealDamage()
            }
            
            healthBar.dealDamage()
            
        })
    }

    
    func checkIfDead() -> Bool {
        
        if isDead == false {
            
            health--
            
            if health <= 0 {
                
                splash()
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func splash() {
        
        removeAllActions()
        
        runAction(SKAction.sequence([
            SKAction.setTexture(SKTexture(imageNamed: texutureNameSplash[bugType])),
            SKAction.fadeAlphaTo(0, duration: 1.0),
            SKAction.removeFromParent(),
            ]))
        
        runAction(SKAction.repeatAction(SKAction.sequence([
            SKAction.fadeAlphaBy(-0.2, duration: 0.1),
            SKAction.fadeAlphaBy(0.2, duration: 0.1),
            ]), count: 5))
    }
    
    func bugCrawling() {
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.setTexture(SKTexture(imageNamed: textureName1[bugType])),
            SKAction.waitForDuration(0.025),
            SKAction.setTexture(SKTexture(imageNamed: textureName2[bugType])),
            SKAction.waitForDuration(0.025),
            SKAction.setTexture(SKTexture(imageNamed: textureName3[bugType])),
            SKAction.waitForDuration(0.025),
            SKAction.setTexture(SKTexture(imageNamed: textureName4[bugType])),
            SKAction.waitForDuration(0.025),
            SKAction.setTexture(SKTexture(imageNamed: textureName5[bugType])),
            SKAction.waitForDuration(0.025),
            SKAction.setTexture(SKTexture(imageNamed: textureName6[bugType])),
            SKAction.waitForDuration(0.025),
            SKAction.setTexture(SKTexture(imageNamed: textureName7[bugType])),
            SKAction.waitForDuration(0.025),
            SKAction.setTexture(SKTexture(imageNamed: textureName8[bugType])),
            SKAction.waitForDuration(0.025),
            ])))
    }
    
    func getRandomPosition() -> CGPoint {
        
        let xPosition: CGFloat = CGFloat(arc4random_uniform(100)) / 100 * (world.frame.size.width - frame.size.width) + frame.size.width / 2
        let yPosition: CGFloat = world.frame.size.height + frame.size.height / 2
        
        return CGPointMake(xPosition, yPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
