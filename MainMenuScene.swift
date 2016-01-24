//
//  MainMenuScene.swift
//  Bug squash
//
//  Created by Darvydas on 05/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit
import StoreKit

class MainMenuScene: SKScene, GKGameCenterControllerDelegate {
    
    
    override func didMoveToView(view: SKView) {
        
        createInitialScene()
        
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        
        AppDelegate().pauseBackgroundMusic()
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            if touchedNode.isKindOfClass(CustomButton) {
                
                let button = touchedNode as! CustomButton
                
                
                if button.name == "playgame_off_btn" {
                    
                    button.changeImage()
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    let nextScene = GameScene(size: scene!.size)
                    scene?.view?.presentScene(nextScene, transition: transition)
                } else if button.name == "store_off_btn" {
                    
                    button.changeImage()
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")

                    let store = Store.init(mainScene: self)
                    addChild(store)
                    
                } else if button.name == "instruction_off_btn" {
                    
                    button.changeImage()
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")

                    let instructions = Instructions.init(mainScene: self)
                    addChild(instructions)
                    
                } else if button.name == "twitter_btn" {
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")

                    let appURL = NSURL(string: "twitter://user?screen_name=\(kTwitterPageName)")!
                    let webURL = NSURL(string: "https://twitter.com/\(kTwitterPageName)")!
                    
                    let application = UIApplication.sharedApplication()
                    
                    if application.canOpenURL(appURL) {
                        application.openURL(appURL)
                    } else {
                        application.openURL(webURL)
                    }
                    
                } else if button.name == "facebook_btn" {
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")

                    let facebookURL: NSURL = NSURL(string: "fb://profile/\(kFacebookPageId)")!
                    if UIApplication.sharedApplication().canOpenURL(facebookURL) {
                        UIApplication.sharedApplication().openURL(facebookURL)
                    }
                    else {
                        UIApplication.sharedApplication().openURL(NSURL(string: kFacebookPageUrl)!)
                    }
                } else if button.name == "mail_btn" {
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")

                    NSNotificationCenter.defaultCenter().postNotificationName("showMailComposer", object: nil)
                } else if button.name == "gameCenter" {
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")

                    let gcViewController: GKGameCenterViewController = GKGameCenterViewController()
                    gcViewController.gameCenterDelegate = self
                    
                    gcViewController.leaderboardIdentifier = kLeaderBoardId
                    
                    gcViewController.viewState = GKGameCenterViewControllerState.Leaderboards
                    let vc: UIViewController = self.view!.window!.rootViewController!
                    vc.presentViewController(gcViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func createInitialScene() {
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "main_screen"), color: UIColor.clearColor(), size: CGSizeMake(frame.size.width, frame.size.height))
        background.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
        
        addChild(background)
        
        let playGameButton = CustomButton.init(mainScene: self, buttonName: "playgame_off_btn", buttonSize: CGSizeMake(frame.size.width / 2, frame.size.height / 16), buttonPosition: CGPointMake(frame.size.width / 2, frame.size.height / 32 * 12))
        addChild(playGameButton)
        
        let storeButton = CustomButton.init(mainScene: self, buttonName: "store_off_btn", buttonSize: CGSizeMake(frame.size.width / 3.3, frame.size.height / 16), buttonPosition: CGPointMake(frame.size.width / 2, frame.size.height / 32 * 10))
        addChild(storeButton)
        
        let instructionButton = CustomButton.init(mainScene: self, buttonName: "instruction_off_btn", buttonSize: CGSizeMake(frame.size.width / 1.65, frame.size.height / 16), buttonPosition: CGPointMake(frame.size.width / 2, frame.size.height / 32 * 8))
        addChild(instructionButton)
        
        let twitterButton = CustomButton.init(mainScene: self, buttonName: "twitter_btn", buttonSize: CGSizeMake(frame.size.height / 16, frame.size.height / 16), buttonPosition: CGPointMake(frame.size.width / 18 * 1.5, frame.size.height / 32 * 4))
        addChild(twitterButton)
        
        let facebookButton = CustomButton.init(mainScene: self, buttonName: "facebook_btn", buttonSize: CGSizeMake(frame.size.height / 16, frame.size.height / 16), buttonPosition: CGPointMake(frame.size.width / 18 * 4, frame.size.height / 32 * 4))
        addChild(facebookButton)
        
        let mailButton = CustomButton.init(mainScene: self, buttonName: "mail_btn", buttonSize: CGSizeMake(frame.size.height / 16, frame.size.height / 16), buttonPosition: CGPointMake(frame.size.width / 18 * 6.5, frame.size.height / 32 * 4))
        addChild(mailButton)
        
        let gameCenterButton = CustomButton.init(mainScene: self, buttonName: "gameCenter", buttonSize: CGSizeMake(frame.size.height / 16, frame.size.height / 16), buttonPosition: CGPointMake(frame.size.width / 18 * 16.5, frame.size.height / 32 * 4))
        addChild(gameCenterButton)
    }
    
}
