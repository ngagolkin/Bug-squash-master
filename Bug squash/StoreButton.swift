//
//  StoreButton.swift
//  Bug squash
//
//  Created by Darvydas on 09/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit

class StoreButton: SKSpriteNode {
    
    var purchased: Bool = false
    var selected: Bool = false
    var world: SKNode!
    
    init(mainScene: SKNode, buttonPosition: CGPoint, buttonName: String) {
        
        world = mainScene
        
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.width / 3, mainScene.frame.size.height / 12))
        position = buttonPosition
        name = buttonName
        
        if name == "wood" {
            purchased = true
        } else if name == "concrete" && NSUserDefaults.standardUserDefaults().boolForKey(name!) == true{
            
            purchased = true
        } else if name == "metal" && NSUserDefaults.standardUserDefaults().boolForKey(name!) == true{
            
            purchased = true
        } else if name == "rocky" && NSUserDefaults.standardUserDefaults().boolForKey(name!) == true{
            
            purchased = true
        }
        
        let selectedButton: Int = NSUserDefaults.standardUserDefaults().integerForKey("SelectedStoreButton")
        
        print("SELECTED BUTTON: \(selectedButton)")
        
        if selectedButton == 1 && name == "concrete" {
            
            selected = true
        } else if selectedButton == 2 && name == "metal" {
            
            selected = true
        } else if selectedButton == 3 && name == "rocky" {
            
            selected = true
        } else if name == "wood" && selectedButton == 0{
        
            selected = true
        }
        
        if selected == true && purchased == false {
            
            /* If button selected but not purchased */
            
            selected = false
            
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "SelectedStoreButton")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            for child in world.children as [SKNode] {
                
                if child.isKindOfClass(StoreButton) {
                    
                    let button = child as! StoreButton
                    
                    if button.name == "wood" {
                        
                        button.selected = true
                        button.texture = SKTexture(imageNamed: "selected_on")
                    }
                }
            }
            
        }
        
        setTexture()
    }
    
    func buttonPress() {
        
        if selected == true {
            
            /* Pressing selected button - DO NOTHING*/
        } else if selected == false && purchased == true {
            
            /* Pressing purchased but not selected button */
            
            for child in world.children as [SKNode] {
                
                if child.isKindOfClass(StoreButton) {
                    
                    let button = child as! StoreButton
                    
                    if button.purchased == true {
                        
                        button.selected = false
                        button.texture = SKTexture(imageNamed: "change_on")
                    }
                }
            }
            
            selected = true
            self.texture = SKTexture(imageNamed: "selected_off")
            
            if name == "wood" {
                
                NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "SelectedStoreButton")
            } else if name == "concrete" {
                
                NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "SelectedStoreButton")
            } else if name == "metal" {
                
                NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "SelectedStoreButton")
            } else if name == "rocky" {
                
                NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "SelectedStoreButton")
            }
        }
        
        print("Name: \(name), selected: \(selected), purchased: \(purchased)")
    }
    
    func setTexture() {
        
        if purchased == true {
            
            if selected == true {
                
                self.texture = SKTexture(imageNamed: "selected_off")
                
            } else {
                
                self.texture = SKTexture(imageNamed: "change_on")
            }
        } else {
            
            self.texture = SKTexture(imageNamed: "0_99_on")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
