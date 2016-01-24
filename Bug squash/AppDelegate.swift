//
//  AppDelegate.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import UIKit
import AVFoundation
import iAd
import GoogleMobileAds

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate  {

    /* ADS */
    var window: UIWindow?
    var iAdBannerAdView: ADBannerView!
    var adMobBannerAdView: GADBannerView!
    
    /* Music */
    var musicIsPlaying: Bool = false
    var bgMusicLoop: AVAudioPlayer!
    var music: AVAudioPlayer!
    var soundsOn: Bool = true

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        ALSdk.initializeSdk()
        
        GameCenter().authenticateLocalPlayer()
        
        playBackgroundMusic("Main_level", withExtension: "wav")
        pauseBackgroundMusic()
        
        // Override point for customization after application launch.
        return true
    }
    
    func adService(adService: ALAdService, didLoadAd ad: ALAd) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("pause", object: nil)
    }
    
    func adService(adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        Chartboost.startWithAppId(kChartBoost_APPID, appSignature: kChartBoost_APPSIGNATURE, delegate: self)
        self.showChartboostAds()
        
        ALInterstitialAd.show()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func showChartboostAds() {

        Chartboost.showInterstitial(CBLocationHomeScreen)
        
        NSNotificationCenter.defaultCenter().postNotificationName("pause", object: nil)

    }
    
    func didDismissInterstitial(location: String!) {
        Chartboost.cacheInterstitial(CBLocationHomeScreen)
        
        NSNotificationCenter.defaultCenter().postNotificationName("unPause", object: nil)
    }
    
    func didFailToLoadInterstitial(location: String!, withError error: CBLoadError) {
        
    }
    
    
    
    
    /* MUSIC */
    
    func playMusicOnetime(fileName: String, withExtension fileExtension: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let filePath: String = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)!
        
        do {
            
            appDelegate.music = try AVAudioPlayer(contentsOfURL: NSURL.fileURLWithPath(filePath))
        } catch {
            print(error)
        }
        
        if appDelegate.soundsOn == true {
            
            appDelegate.music.numberOfLoops = 0
            appDelegate.music.prepareToPlay()
            appDelegate.music.play()
        }
    }
    
    func changeSoundsOn() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.soundsOn == true {
            appDelegate.soundsOn = false
        } else {
            appDelegate.soundsOn = true
        }
        
        print(appDelegate.soundsOn)
    }
    
    func getSoundsOn() -> Bool {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.soundsOn
    }
    
    func getMusicPlaying() -> Bool {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.musicIsPlaying
    }
    
    func playBackgroundMusic(fileName: String, withExtension fileExtension: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        stopBackgroundMusic()
        
        if appDelegate.musicIsPlaying == false {
            
            appDelegate.musicIsPlaying = true
            
            let filePath: String = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)!
            
            if (appDelegate.bgMusicLoop != nil) {
                appDelegate.bgMusicLoop.stop()
            }
            appDelegate.bgMusicLoop = nil
            
            do {
                
                appDelegate.bgMusicLoop = try AVAudioPlayer(contentsOfURL: NSURL.fileURLWithPath(filePath))
                
            } catch {
                print(error)
            }
            
            //A negative means it loops forever
            appDelegate.musicIsPlaying = true
            appDelegate.bgMusicLoop.numberOfLoops = -1
            appDelegate.bgMusicLoop.prepareToPlay()
            appDelegate.bgMusicLoop.play()
            appDelegate.bgMusicLoop.volume = 0.05
        }
    }
    
    func stopBackgroundMusic() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if appDelegate.bgMusicLoop != nil {
            
            appDelegate.musicIsPlaying = false
            appDelegate.bgMusicLoop.stop()
        }
    }
    
    func pauseBackgroundMusic() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if  appDelegate.musicIsPlaying == true {
            appDelegate.musicIsPlaying = false
            appDelegate.bgMusicLoop.pause()
        }
    }
    
    func resumeBackgroundMusic() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if  appDelegate.musicIsPlaying == false {
            
            appDelegate.musicIsPlaying = true
            appDelegate.bgMusicLoop.play()
        }
    }
}

