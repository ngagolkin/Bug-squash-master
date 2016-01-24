//
//  GameScene.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright (c) 2016 Darvydas. All rights reserved.
//

import SpriteKit
import Social

class GameScene: SKScene {
    
    var healthBar: HealthBar!
    var scoreLabel: ScoreLabel!
    
    var gameSpeed: NSTimeInterval = kStartingGameSpeed
    
    var gameOver: Bool = false
    
    override func didMoveToView(view: SKView) {
        
        AppDelegate().resumeBackgroundMusic()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotification:", name: "pause", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotification:", name: "unPause", object: nil)
        
        createInitialScene()
        bugSpawner()
    }
    
    func handleNotification(notification: NSNotification) {
        
        if (notification.name == "pause") {
            
            let button = childNodeWithName("pause") as! Button
            button.changeImage()
            
            paused = true
        }
        else if (notification.name == "unPause") {
            
            paused = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodes: [AnyObject] = self.nodesAtPoint(touch.locationInNode(self))
            
            if touchedNode.isKindOfClass(Button) {
                
                let button = touchedNode as! Button
                button.changeImage()
                
                if button.name == "pause" {
                    
                    if paused == true {
                        
                        paused = false
                    } else {
                        
                        paused = true
                    }
                }
            } else if paused == false {
                
                if gameOver == false {
                    
                    for var i = 0; i < nodes.count; i++ {
                        
                        if nodes[i].isKindOfClass(Bug) {
                            
                            let bug = nodes[i] as! Bug
                            
                            let isBugDead = bug.checkIfDead()
                            
                            if isBugDead == true && bug.isSplashed == false{
                                
                                bug.isSplashed = true
                                
                                if NSUserDefaults.standardUserDefaults().boolForKey("SoundButtonIsPressed") == false {
                                    
                                    runAction(SKAction.playSoundFileNamed("Squash.wav", waitForCompletion: false))
                                }
                                
                                scoreLabel.incrementScore()
                            }
                        }
                    }
                }
            }
            if touchedNode.isKindOfClass(CustomButton) {
                
                let button = touchedNode as! CustomButton
                
                if button.name == "fb" {

                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")
                    
                    facebookShare()
                    
                } else if button.name == "twitter" {
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")

                    showTweetSheet()
                    
                } else if button.name == "mainmenu_on_btn" {
                    
                    button.changeImage()
                    
                    gameOver = true
                    
                    AppDelegate().playMusicOnetime("Button", withExtension: "wav")
                    
                    let gameOverScene = childNodeWithName("GAMEOVERSCREEN") as! GameOverScreen
                    gameOverScene.removeFromParent()
                    
                    let transition = SKTransition.fadeWithDuration(0.5)
                    let nextScene = MainMenuScene(size: scene!.size)
                    scene?.view?.presentScene(nextScene, transition: transition)
                } else if button.name == "playagain_on_btn" {
                    
                    button.changeImage()
                    
                    gameOver = true
                    
                    runAction(SKAction.playSoundFileNamed("Button.wav", waitForCompletion: false))
                    
                    let gameOverScene = childNodeWithName("GAMEOVERSCREEN") as! GameOverScreen
                    gameOverScene.removeFromParent()
                    
                    let transition = SKTransition.fadeWithDuration(0.5)
                    let nextScene = GameScene(size: scene!.size)
                    scene?.view?.presentScene(nextScene, transition: transition)
                }
            }
        }
    }
    
    func showTweetSheet() {
        let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tweetSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                break
            case SLComposeViewControllerResult.Done:
                break
            }
        }
        
        tweetSheet.setInitialText("I just earned \(scoreLabel.score) score and smashed \(scoreLabel.score / 10) bugs")
        tweetSheet.addImage(UIImage(named: "main_screen"))
        tweetSheet.addURL(NSURL(string: "https://twitter.com/\(kTwitterPageName)"))
        
        view?.window?.rootViewController?.presentViewController(tweetSheet, animated: false, completion: {
        })
    }
    
    func facebookShare() {
        
        let facebookSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                break
            case SLComposeViewControllerResult.Done:
                break
            }
        }
        
        facebookSheet.setInitialText("I just earned \(scoreLabel.score) score and smashed \(scoreLabel.score / 10) bugs")
        facebookSheet.addImage(UIImage(named: "main_screen"))
        facebookSheet.addURL(NSURL(string: kFacebookPageUrl))
        
        view?.window?.rootViewController?.presentViewController(facebookSheet, animated: false, completion: {
        })
    }
    
    func bugSpawner() {
        
        let bug = Bug.init(mainScene: self, score: scoreLabel.score)
        addChild(bug)
        
        if arc4random_uniform(100) < 66 {
            
            let bug = Bug.init(mainScene: self, score: scoreLabel.score)
            addChild(bug)
        }
        if arc4random_uniform(100) < 33 {
            let bug = Bug.init(mainScene: self, score: scoreLabel.score)
            addChild(bug)
        }
        if arc4random_uniform(100) < 17  {
            let bug = Bug.init(mainScene: self, score: scoreLabel.score)
            addChild(bug)
        }
        if Int(arc4random_uniform(100)) < scoreLabel.score  {
            let bug = Bug.init(mainScene: self, score: scoreLabel.score)
            addChild(bug)
        }
        if Int(arc4random_uniform(100)) < scoreLabel.score - 100  {
            let bug = Bug.init(mainScene: self, score: scoreLabel.score)
            addChild(bug)
        }
        
        changeGameSpeed()
        
        runAction(SKAction.sequence([
            SKAction.waitForDuration(gameSpeed),
            SKAction.performSelector("bugSpawner", onTarget: self),
            ]))
    }
    
    func changeGameSpeed() {
        
        gameSpeed = kStartingGameSpeed
        
        if scoreLabel.score < 1 {
            gameSpeed *= 0.97
        } else if scoreLabel.score < 30{
            gameSpeed *= 0.94
        } else if scoreLabel.score < 50{
            gameSpeed *= 0.9
        } else if scoreLabel.score < 100{
            gameSpeed *= 0.87
        } else if scoreLabel.score < 200{
            gameSpeed *= 0.84
        } else if scoreLabel.score < 500{
            gameSpeed *= 0.8
        } else if scoreLabel.score < 1000{
            gameSpeed *= 0.77
        } else if scoreLabel.score < 1500{
            gameSpeed *= 0.74
        } else if scoreLabel.score < 2000{
            gameSpeed *= 0.70
        } else if scoreLabel.score < 3000{
            gameSpeed *= 0.68
        }else if scoreLabel.score < 4000{
            gameSpeed *= 0.66
        } else if scoreLabel.score < 5000{
            gameSpeed *= 0.63
        } else if scoreLabel.score < 6000{
            gameSpeed *= 0.60
        } else if scoreLabel.score < 7000{
            gameSpeed *= 0.57
        } else if scoreLabel.score < 8000{
            gameSpeed *= 0.54
        } else if scoreLabel.score < 10000{
            gameSpeed *= 0.51
        } else if scoreLabel.score < 15000{
            gameSpeed *= 0.47
        } else if scoreLabel.score < 20000{
            gameSpeed *= 0.43
        } else if scoreLabel.score < 25000{
            gameSpeed *= 0.4
        } else if scoreLabel.score < 30000{
            gameSpeed *= 0.35
        } else if scoreLabel.score < 50000{
            gameSpeed *= 0.3
        } else {
            gameSpeed *= 0.25
        }
    }
    
    func createInitialScene() {
        
        let bg = Background.init(mainScene: self)
        addChild(bg)
        
        let web = Web.init(mainScene: self)
        addChild(web)
        
//        let handFlashLight = FlashLight.init(mainScene: self)
//        addChild(handFlashLight)
        
        scoreLabel = ScoreLabel.init(mainScene: self)
        addChild(scoreLabel)
        
        healthBar = HealthBar.init(mainScene: self, sl: scoreLabel, gs: self)
        addChild(healthBar)
        
        let pauseButton = Button.init(mainScene: self, buttonPosition: CGPointMake(frame.size.width / 18 * 16, frame.size.height / 32 * 30.5), buttonName: "pause")
        addChild(pauseButton)
        
        let musicButton = Button.init(mainScene: self, buttonPosition: CGPointMake(frame.size.width / 18 * 14, frame.size.height / 32 * 30.5), buttonName: "music")
        addChild(musicButton)
        
        let soundButton = Button.init(mainScene: self, buttonPosition: CGPointMake(frame.size.width / 18 * 12, frame.size.height / 32 * 30.5), buttonName: "sound")
        addChild(soundButton)

    }
}
