//
//  GameViewController.swift
//  Bug squash
//
//  Created by Darvydas on 04/01/16.
//  Copyright (c) 2016 Darvydas. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit
import MessageUI

class GameViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        
        let scene = MainMenuScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        scene.size = skView.bounds.size
        
        /* */

        Ads.sharedInstance.presentingViewController = self
        Ads.sharedInstance.showBannerAd()
        
        /*
        Ads.sharedInstance.showBannerAd()
        Ads.sharedInstance.showBannerAdDelayed() // delay showing banner slightly eg when transitioning to new scene/view
        Ads.sharedInstance.showInterAd(includeCustomAd: true) // if true it will show a customAd every 4th time an ad is shown
        Ads.sharedInstance.showInterAdRandomly(includeCustomAd: true) // 33% chance of showing inter ads, if true it will show a customAd every 4th time an ad is shown. Settings can always be tweaked
        */
        
        /* */
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sendMail", name: "showMailComposer", object: nil)

        
        skView.presentScene(scene);
    }

    func sendMail() {
        
        let mailClass: AnyClass = (NSClassFromString("MFMailComposeViewController"))!
        
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(kEmailSubject)
            mc.setMessageBody(kEmailMessageBody, isHTML: false)
            mc.setToRecipients([""])

        if mailClass.canSendMail() {
            
            self.view.window!.rootViewController!.presentViewController(mc, animated: true, completion: { _ in })
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResultCancelled:
            NSLog("Mail cancelled")
        case MFMailComposeResultSaved:
            NSLog("Mail saved")
        case MFMailComposeResultSent:
            NSLog("Mail sent")
        case MFMailComposeResultFailed:
            NSLog("Mail sent failure: %@", error!.localizedDescription)
        default:
            break
        }
        
        // Close the Mail Interface
        self.dismissViewControllerAnimated(true, completion: { _ in })
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
