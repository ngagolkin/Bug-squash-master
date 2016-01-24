//
//  GameCenter.swift
//  Alien runner in two parallel galaxies
//
//  Created by Darvydas on 9/30/15.
//  Copyright © 2015 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class GameCenter: NSObject, GKGameCenterControllerDelegate{
    
    var gameCenterEnabled: Bool!
    var lastError: NSError!
    var vController: UIViewController!
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
                
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        gameCenterViewController.gameCenterDelegate = nil
    }
    
    func getRootViewController() -> UIViewController {
        
        return (UIApplication.sharedApplication().keyWindow?.rootViewController)!
    }
    
    func presentViewController(vc: UIViewController) {
        
        let rootVC = getRootViewController()
        rootVC.presentViewController(vc, animated: true, completion: nil)
    }
    
    func authenticateLocalPlayer() {
                
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { (viewController : UIViewController?, error : NSError?) -> Void in
            
            if (error == true) {
                
                print("GameKitHelper ERROR" + error!.userInfo.description)
            }
            
            if localPlayer.authenticated == true {
                
                self.gameCenterEnabled = true
            } else if (viewController != nil) {
                
                self.presentViewController(viewController!)
            } else {
                
                self.gameCenterEnabled = false
            }
        }
    }
    
    /* REPORT HIGHSCORE */
    
    func reportHighScore(highScore: Int) {
        if GKLocalPlayer.localPlayer().authenticated == true {
            
            let score: GKScore = GKScore(leaderboardIdentifier: kLeaderBoardId)
            score.value = Int64(highScore)
            
            GKScore.reportScores([score], withCompletionHandler: { (error) -> Void in
                
            })
        }
    }
    
    /* REPORT ACHIEVEMENTS */
    
    func reportAchievementIdentifier(identifier: String, percentComplete percent: Float) {
        
        let achievement: GKAchievement = GKAchievement(identifier: identifier)
        
        if achievement.completed == false {
                        
            achievement.percentComplete = Double(percent)
            
            achievement.showsCompletionBanner = true
            
            GKAchievement.reportAchievements([achievement], withCompletionHandler: { (error) -> Void in
                
            })
        }
    }
}