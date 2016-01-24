//
//  Store.swift
//  Bug squash
//
//  Created by Darvydas on 06/01/16.
//  Copyright © 2016 Darvydas. All rights reserved.
//

import Foundation
import SpriteKit
import StoreKit

class Store: SKSpriteNode, SKProductsRequestDelegate, SKPaymentTransactionObserver  {

    var buttonWood: StoreButton!
    var buttonConcrete: StoreButton!
    var buttonMetal: StoreButton!
    var buttonRocky: StoreButton!
    
    init(mainScene: SKNode) {
        
        super.init(texture: SKTexture(imageNamed: "store"), color: UIColor.clearColor(), size: CGSizeMake(mainScene.frame.size.width, mainScene.frame.size.height))
        position = CGPointMake(mainScene.frame.size.width / 2, mainScene.frame.size.height / 2)
        userInteractionEnabled = true
        zPosition = 900
        
        createInitialScene()
        
        // Set IN APP PURCHASE
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            let productID:NSSet = NSSet(objects: kIAPConcrete, kIAPMetal, kIAPRocky)
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            if touchedNode.isKindOfClass(StoreButton) {
                
                let button = touchedNode as! StoreButton
                
                button.buttonPress()
                
                if button.name == "concrete" {
                    
                    btnBuyConcrete()
                } else if button.name == "metal" {
                    
                    btnBuyMetal()
                } else if button.name == "rocky" {
                    
                    btnBuyRocky()
                }
            } else if touchedNode.name == "Restore Purchases" {
                
                print("Restore purchases")
                RestorePurchases()
            } else if touchedNode.name == "close_btn" {
                
                removeFromParent()
            }
        }
    }
    
    func btnBuyConcrete() {
        
        print("CONCRETE")
        
        for product in list {
            
            let prodID = product.productIdentifier
            if(prodID == kIAPConcrete) {
                
                p = product
                buyProduct()
                break;
            }
        }
    }
    
    func btnBuyMetal() {
        
        print("METAL")
        
        for product in list {
            let prodID = product.productIdentifier
            if(prodID == kIAPMetal) {
                p = product
                buyProduct()
                break;
            }
        }
    }
    
    func btnBuyRocky() {
        
        print("ROCKY")

        for product in list {
            let prodID = product.productIdentifier
            if(prodID == kIAPRocky) {
                p = product
                buyProduct()
                break;
            }
        }
    }
    
    func RestorePurchases() {
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
    
    var list = [SKProduct]()
    var p = SKProduct()
    
    func buyProduct() {
        print("buy " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().addPayment(pay as SKPayment)
    }
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product as SKProduct)
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        
        print("transactions restored")
        
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction as SKPaymentTransaction
            
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
                
            case kIAPConcrete:
                print("BUY Concrete floor")
                buyConcreteFloor()
                
            case kIAPMetal:
                print("BUY Metal floor")
                buyMetalFloor()
                
            case kIAPRocky:
                print("BUY Rocky floor")
                buyRockyFloor()
                
            default:
                print("IAP not setup")
            }
            
        }
    }
    
    func buyConcreteFloor() {
        
    }
    
    func buyMetalFloor() {
        
    }
    
    func buyRockyFloor() {
        
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        print("add paymnet")
        
        for transaction:AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            print(trans.error)
            
            switch trans.transactionState {
                
            case .Purchased:
                print("buy, ok unlock iap here")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier as String
                
                switch prodID {
                    
                case kIAPConcrete:
                    print("BUY Concrete floor")
                    buyConcreteFloor()
                    
                case kIAPMetal:
                    print("BUY Metal floor")
                    buyMetalFloor()
                    
                case kIAPRocky:
                    print("BUY Rocky floor")
                    buyRockyFloor()
                    
                default:
                    print("IAP not setup")
                }
                
                queue.finishTransaction(trans)
                break;
            case .Failed:
                print("buy error")
                queue.finishTransaction(trans)
                break;
            default:
                print("default")
                break;
                
            }
        }
    }
    
    func paymentQueue(queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: NSError) {
        
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {
        
    }
    
    func finishTransaction(trans:SKPaymentTransaction) {
        
        print("finish trans")
    }
    
    func createInitialScene() {
        
        let image1 = BackgroundImage.init(mainScene: self, imagePosition: CGPointMake( -frame.size.width / 4, frame.size.height / 32 * 20 - frame.size.height / 2), imageName: "wood")
        addChild(image1)
        
        let image2 = BackgroundImage.init(mainScene: self, imagePosition: CGPointMake( -frame.size.width / 4, frame.size.height / 32 * 15.5 - frame.size.height / 2), imageName: "concrete")
        addChild(image2)
        
        let image3 = BackgroundImage.init(mainScene: self, imagePosition: CGPointMake( -frame.size.width / 4, frame.size.height / 32 * 11 - frame.size.height / 2), imageName: "metal")
        addChild(image3)
        
        let image4 = BackgroundImage.init(mainScene: self, imagePosition: CGPointMake( -frame.size.width / 4, frame.size.height / 32 * 6.5 - frame.size.height / 2), imageName: "rocky")
        addChild(image4)
        
        buttonWood = StoreButton.init(mainScene: self, buttonPosition: CGPointMake(frame.size.width / 5, frame.size.height / 32 * 20 - frame.size.height / 2), buttonName: "wood")
        addChild(buttonWood)
        
        buttonConcrete = StoreButton.init(mainScene: self, buttonPosition: CGPointMake(frame.size.width / 5, frame.size.height / 32 * 15.5 - frame.size.height / 2), buttonName: "concrete")
        addChild(buttonConcrete)
        
        buttonMetal = StoreButton.init(mainScene: self, buttonPosition: CGPointMake(frame.size.width / 5, frame.size.height / 32 * 11 - frame.size.height / 2), buttonName: "metal")
        addChild(buttonMetal)
        
        buttonRocky = StoreButton.init(mainScene: self, buttonPosition: CGPointMake(frame.size.width / 5, frame.size.height / 32 * 6.5 - frame.size.height / 2), buttonName: "rocky")
        addChild(buttonRocky)
        
        let closeButton = CustomButton.init(mainScene: self, buttonName: "close_btn", buttonSize: CGSizeMake(frame.size.height / 12, frame.size.height / 12), buttonPosition: CGPointMake( -frame.size.width / 2 + frame.size.height / 32 * 2, frame.size.height / 32 * 14))
        addChild(closeButton)
        
        let label = SKLabelNode(fontNamed: kFontName)
        label.fontColor = UIColor.whiteColor()
        label.fontSize = frame.size.height / 48
        label.position = CGPointMake(frame.size.width / 4, -frame.size.height / 32 * 12.5)
        label.name = "Restore Purchases"
        label.text = "Restore Purchases"
        
        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
