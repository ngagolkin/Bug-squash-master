//
//  GameOverScreen.swift
//  Bug squash
//
//  Created by Darvydas on 05/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScreen: SKSpriteNode {
    
    init(mainScene: SKNode, score: Int) {
        
        let highscore = NSUserDefaults.standardUserDefaults().integerForKey("HIGHSCORE")
        if score > highscore {
            
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "HIGHSCORE")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            GameCenter().reportHighScore(score)
        }
        
        super.init(texture: SKTexture(imageNamed: "gameover_screen"), color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.width , mainScene.frame.size.height))
        position = CGPointMake(mainScene.frame.size.width / 2, mainScene.frame.size.height / 2)
        name = "GAMEOVERSCREEN"
        zPosition = 990
        
        AppDelegate().playMusicOnetime("Loose_screen", withExtension: "wav")
        
        let fbButton = CustomButton.init(mainScene: self, buttonName: "fb", buttonSize: CGSizeMake(frame.size.width / 18 * 9, frame.size.height / 24), buttonPosition: CGPointMake(0, frame.size.height / 32 * 10.3 - frame.size.height / 2))
        addChild(fbButton)
        
        let twitterButton = CustomButton.init(mainScene: self, buttonName: "twitter", buttonSize: CGSizeMake(frame.size.width / 18 * 9, frame.size.height / 24), buttonPosition: CGPointMake(0, frame.size.height / 32 * 8 - frame.size.height / 2))
        addChild(twitterButton)
        
        let mainMenuButton = CustomButton.init(mainScene: self, buttonName: "mainmenu_on_btn", buttonSize: CGSizeMake(frame.size.width / 18 * 8, frame.size.height / 24), buttonPosition: CGPointMake(0, frame.size.height / 32 * 12.7 - frame.size.height / 2))
        addChild(mainMenuButton)
        
        let playAgainButton = CustomButton.init(mainScene: self, buttonName: "playagain_on_btn", buttonSize: CGSizeMake(frame.size.width / 18 * 8, frame.size.height / 24), buttonPosition: CGPointMake(0, frame.size.height / 32 * 14.8 - frame.size.height / 2))
        addChild(playAgainButton)
        
        createLabel(CGPointMake(0, frame.size.height / 32 * 1.0), labelText: "\(score)")
        createLabel(CGPointMake( -frame.size.width / 5 , frame.size.height / 32 * 5.2), labelText: "\(score / 10)")
        
    }
    
    func createLabel(labelPosition: CGPoint, labelText: String) {
        
        let label = SKLabelNode(fontNamed: kFontName)
        label.position = labelPosition
        label.fontSize = frame.size.height / 16
        label.fontColor = UIColor.whiteColor()
        label.zPosition = 999
        label.text = labelText
        
        print(label)
        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
