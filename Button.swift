//
//  Button.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode {
    
    var isPressed: Bool = false
    
    var textureNamePause: [String] = [
        "pause_btn",
        "play_btn"
    ]
    
    var textureNameSound: [String] = [
        "sound_on_btn",
        "sound_off_btn",
    ]
    
    var textureNameMusic: [String] = [
        "music_on_btn",
        "music_off_btn",
    ]
    
    init(mainScene: SKNode, buttonPosition: CGPoint, buttonName: String) {
        
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.height / 24, mainScene.frame.size.height / 24))
        position = buttonPosition
        zPosition = 950
        name = buttonName
        
        setButtonTexture(buttonName)
    }
    
    func changeImage() {
        
        if name == "pause" {
            if isPressed == false {
                
                isPressed = true
                texture = SKTexture(imageNamed: textureNamePause[1])
            } else {
                
                isPressed = false
                texture = SKTexture(imageNamed: textureNamePause[0])
            }
        } else if name == "music" {
            
            if isPressed == false {
                
                texture = SKTexture(imageNamed: textureNameMusic[0])
                isPressed = true
                AppDelegate().resumeBackgroundMusic()
            } else {
                
                texture = SKTexture(imageNamed: textureNameMusic[1])
                isPressed = false
                AppDelegate().pauseBackgroundMusic()
            }
            
        } else if name == "sound" {
            
            if isPressed == false {
                
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "SoundButtonIsPressed")
                isPressed = true
                texture = SKTexture(imageNamed: textureNameSound[0])
            } else {
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "SoundButtonIsPressed")
                isPressed = false
                texture = SKTexture(imageNamed: textureNameSound[1])
            }
            
            AppDelegate().changeSoundsOn()
        }
        
    }
    
    func setButtonTexture(buttonName: String) {
        
        let textureName: String
        
        if buttonName == "pause" {
            
            isPressed = false
            textureName = textureNamePause[0]
        } else if buttonName == "music" {
            
            if AppDelegate().getMusicPlaying() == false {
                
                isPressed = false
                textureName = textureNameMusic[1]
            } else {
                
                isPressed = true
                textureName = textureNameMusic[0]
            }
            
        } else {
            
            
            if NSUserDefaults.standardUserDefaults().boolForKey("SoundButtonIsPressed") == false {
                
                isPressed = true
                textureName = textureNameSound[0]
                
            } else {
                
                isPressed = false
                textureName = textureNameSound[1]
            }
        }
        
        texture = SKTexture(imageNamed: textureName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
