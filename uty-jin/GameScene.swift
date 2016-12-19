//
//  Game Scene.swift
//  uty-jin
//
//  Created by KAREN on 2015/11/13.
//  Copyright © 2015年 KAREN. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation
import AVFoundation

enum GameStatus:Int{
    case kDragNone=0,  //初期値
    kDragStart, //Drag開始
    kDragEnd   //Drag終了
}
//enumをclassの中に入れない！



class GameScene : SKScene, SKPhysicsContactDelegate {
    
    var ballCollection: [SKShapeNode] = []
    var last:CFTimeInterval!
    var gameStatus:Int = 0;
    var startPos:CGPoint!;
    var ball:SKSpriteNode!;
    var ball1:SKSpriteNode!;
    var haikei:SKSpriteNode!;
    
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    
    var clearSquare = SKSpriteNode()
    var tikyu = SKSpriteNode()
    var hosi = SKSpriteNode()
    var hosia = SKSpriteNode()
    
    var point:Int = 0
    
    var score:Int = 0
    
    let ImageViewa = UIImage(named:"haikei.png")
    
    let gameoverSpriteKit = SKSpriteNode(imageNamed: "gameover.png")
    var gameFlg = false
    
    //var imageView = UIImageView(frame: CGRectMake(40,600,0.1,0.1))
    /*var imageViewa = UIImageView(frame: CGRectMake(30,200,20,20))
     var imageViewb = UIImageView(frame: CGRectMake(30,200,20,20))*/
    var heartArray : [SKSpriteNode] = [SKSpriteNode(imageNamed: "ha-to.png"),SKSpriteNode(imageNamed: "ha-to.png"),SKSpriteNode(imageNamed: "ha-to.png")]
    
    
    var audio:AVPlayer!
    
    let ballCategory: UInt32 = 0x1 << 0
    let tikyuCategory: UInt32 = 0x1 << 1
    
    override func didMoveToView(view: SKView) {
        
        
        
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("by_chance", ofType: "mp3")!)
        
        audio = AVPlayer(URL:audioPath)
        
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height
        
        view.showsFPS = false
        view.showsNodeCount = false
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: frame.width, height:
            frame.height))
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.friction = 0.0
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.name = "frame"
        
        self.physicsWorld.gravity = CGVector(dx:0.0, dy: -2.0)
        
        self.fallUtyujin()
        
        haikei = SKSpriteNode(imageNamed: "haikei.png")
        haikei.yScale = 2.0
        haikei.xScale = 2.5
        haikei.position = CGPoint(x: 0,y: 0)
        self.addChild(haikei)
        
        
        //下のゴミ箱の部分
        tikyu = SKSpriteNode(imageNamed: "tikyu.png")
        tikyu.xScale = 0.6
        tikyu.yScale = 0.5
        tikyu.position = CGPoint(x: 200,y: 0)
        tikyu.physicsBody = SKPhysicsBody(rectangleOfSize: tikyu.frame.size)
        tikyu.physicsBody!.affectedByGravity = false
        tikyu.physicsBody!.dynamic = false
        tikyu.physicsBody?.categoryBitMask = tikyuCategory
        tikyu.physicsBody?.contactTestBitMask = ballCategory
        tikyu.name = "tikyu"
        self.addChild(tikyu)
        
        hosi = SKSpriteNode(imageNamed:"hoshi1.png")
        hosi.xScale = 0.14
        hosi.yScale = 0.15
        hosi.position = CGPoint(x: 55,y: 400)
        hosi.physicsBody = SKPhysicsBody(rectangleOfSize: hosi.frame.size)
        hosi.physicsBody!.affectedByGravity = false
        hosi.physicsBody!.dynamic = false
        hosi.physicsBody?.categoryBitMask = tikyuCategory
        hosi.physicsBody?.contactTestBitMask = ballCategory
        hosi.name = "hosi"
        self.addChild(hosi)
        
        hosia = SKSpriteNode(imageNamed: "hoshi2.png")
        hosia.xScale = 0.14
        hosia.yScale = 0.14
        hosia.position = CGPoint(x: 300,y: 500)
        hosia.physicsBody = SKPhysicsBody(rectangleOfSize: hosi.frame.size)
        hosia.physicsBody!.affectedByGravity = false
        hosia.physicsBody!.dynamic = false
        hosia.physicsBody?.categoryBitMask = tikyuCategory
        hosia.physicsBody?.contactTestBitMask = ballCategory
        hosia.name = "hosia"
        self.addChild(hosia)
        //---------------------------------------------------------
        
        // UIImageViewを作成する.
        // 画像をUIImageViewに設定する.
        //ImageView.image = Image
        
        // 画像の表示する座標を指定する.
        for var h = 0; h < heartArray.count; h += 1 {
            heartArray[h].position = CGPointMake(CGFloat(40 + (20 * h)),600)
            heartArray[h].xScale = 0.1
            heartArray[h].yScale = 0.1
            self.addChild(heartArray[h])
        }
                
        
        
        
        //ImageView.position = CGPointMake(40,600)
        //ImageView.xScale = 0.1
        //ImageView.yScale = 0.1
        
        
        // UIImageViewをViewに追加する.
        
        
        /*//ハート二つ目---------------------------------------
         
         ImageViewa = UIImageView(frame: CGRectMake(0,0,30,30))
         
         let imagea = UIImage(named: "ha-to.png")
         
         ImageView.image = imagea
         
         imageView.layer.position = CGPoint(x: 60, y: 70)
         
         self.view!.addSubview(imageView)
         
         //ハート３個目
         imageViewb = UIImageView(frame: CGRectMake(0,0,30,30))
         
         let imageb = UIImage(named: "ha-to.png")
         
         imageView.image = imageb
         
         imageView.layer.position = CGPoint(x: 90, y: 70)
         self.view!.addSubview(imageView)
         }
         
         override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
         
         imageb.hidden = !imageb.hidden
         */
        
        
    }
    
    //------------------------------------------------------
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let node:SKNode! = self.nodeAtPoint(location);
            if(node != nil){
                if(node.name=="ball"){
                    //nilじゃなかったら"ball"にする！
                    gameStatus = GameStatus.kDragStart.rawValue;
                    startPos = location;
                }
            }
        }
        
        
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(gameStatus == GameStatus.kDragStart.rawValue ){
            //差を出してfirstで一番はじめの値を入力！touchにlocationを入れる。
            let touch = touches.first
            let touchPos:CGPoint = touch!.locationInNode(self);
            ball.position = touchPos;
        }
    }
    
    func fallUtyujin(){
        audio.play()
        
        ball = SKSpriteNode(imageNamed:"utyujin1.PNG")
        ball.xScale = 0.1
        ball.yScale = 0.1
        ball.position = CGPoint(x:185, y:500)
        ball.physicsBody?.mass = 3
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        tikyu.physicsBody?.contactTestBitMask = tikyuCategory
        self.addChild(ball)
        /*
         //透明の置き台
         clearSquare = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(width, 50))
         clearSquare.position = CGPoint(x: CGRectGetMidX(self.frame),y: 200)
         clearSquare.physicsBody = SKPhysicsBody(rectangleOfSize: clearSquare.frame.size)
         clearSquare.physicsBody!.affectedByGravity = false
         clearSquare.physicsBody!.dynamic = false
         clearSquare.physicsBody!.contactTestBitMask = 1
         clearSquare.physicsBody?.collisionBitMask = 1
         clearSquare.name = "clearSquare"
         self.addChild(clearSquare)
         
         NSTimer .scheduledTimerWithTimeInterval(3.0,target: self,
         selector: Selector("destorySquare"),
         userInfo: nil,
         repeats: false)
         
         }*/
    }
    func destorySquare(){
        clearSquare.removeFromParent() //消える
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if let col = contact.bodyA.node {
            if col.name == "tikyu" {
                // 地球との衝突
                ball.removeFromParent()
                fallUtyujin()
                
                
                
                
                heartArray.last?.removeFromParent()
                heartArray.removeLast()
            }
            if col.name == "hosi"{
                //　星との衝突
                ball.removeFromParent()
                fallUtyujin()
            }
            if col.name == "hosia"{
                // もう一つの星との衝突
                ball.removeFromParent()
                fallUtyujin()
                score = +100
            }
            if heartArray.count == 0 {
                
                let myLabel = SKLabelNode(fontNamed: "Chalkduster")
                
                
                myLabel.text = "gameover"
                
                
                myLabel.fontSize = 40
                
                
                myLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
                
                
                self.addChild(myLabel)
                
                let myButton = UIButton()
                myButton.frame = CGRectMake(0,0,100,400)
                
                myButton.layer.masksToBounds = true
               
                myButton.setTitle("もう1回💦", forState: UIControlState.Normal)
                myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                myButton.setTitle("Done", forState: UIControlState.Highlighted)
                myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
                myButton.layer.cornerRadius = 50.0
                myButton.layer.position = CGPoint(x: self.view!.frame.width/2, y:100)
                myButton.addTarget(self, action: "bViewController", forControlEvents: .TouchUpInside)
                self.view!.addSubview(myButton);
                
                
                
            }
            
            
        }
        if heartArray.count == 0{
            ball.removeFromParent()
            let fallUtyujin = false
        }
        
        
    }
    
    
    func onClickMyButton(sender : UIButton){
        
    }

        
}
















