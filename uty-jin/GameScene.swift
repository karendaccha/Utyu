//
//  Game Scene.swift
//  uty-jin
//
//  Created by KAREN on 2015/11/13.
//  Copyright © 2015年 KAREN. All rights reserved.
//

import SpriteKit
import CoreMotion

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
    
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    
    var clearSquare = SKSpriteNode()
    var tikyu = SKSpriteNode()
    var hosi = SKSpriteNode()
    var hosia = SKSpriteNode()
    
    let ballCategory: UInt32 = 0x1 << 0
    let tikyuCategory: UInt32 = 0x1 << 1
    
    override func didMoveToView(view: SKView) {
        
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
        
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
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
        
        ball = SKSpriteNode(imageNamed:"utyujin1.PNG")
        ball.xScale = 0.1
        ball.yScale = 0.1
        ball.position = CGPoint(x:150, y:500)
        ball.physicsBody?.mass = 3.0
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = ballCategory
        tikyu.physicsBody?.contactTestBitMask = tikyuCategory
        self.addChild(ball)
        
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
        
        NSTimer .scheduledTimerWithTimeInterval(3.5,target: self,
            selector: Selector("destorySquare"),
            userInfo: nil,
            repeats: false)
        
        //下のゴミ箱の部分
        tikyu = SKSpriteNode(imageNamed: "tikyu.jpg")
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
        
        hosi = SKSpriteNode(imageNamed:"hoshi1.jpg")
        hosi.xScale = 0.2
        hosi.yScale = 0.2
        hosi.position = CGPoint(x: 50,y: 500)
        hosi.physicsBody = SKPhysicsBody(rectangleOfSize: hosi.frame.size)
        hosi.physicsBody!.affectedByGravity = false
        hosi.physicsBody!.dynamic = false
        hosi.physicsBody?.categoryBitMask = tikyuCategory
        hosi.physicsBody?.contactTestBitMask = ballCategory
        hosi.name = "hosi"
        self.addChild(hosi)
        
        hosia = SKSpriteNode(imageNamed: "hoshi2.jpg")
        hosia.xScale = 0.17
        hosia.yScale = 0.17
        hosia.position = CGPoint(x: 300,y: 500)
        hosia.physicsBody = SKPhysicsBody(rectangleOfSize: hosi.frame.size)
        hosia.physicsBody!.affectedByGravity = false
        hosia.physicsBody!.dynamic = false
        hosia.physicsBody?.categoryBitMask = tikyuCategory
        hosia.physicsBody?.contactTestBitMask = ballCategory
        hosia.name = "hosa"
        self.addChild(hosia)


        
        
        
        //ボールが当たった時に作られる！
    }
    func destorySquare(){
        clearSquare.removeFromParent() //消える
    }
   
    func didBeginContact(contact: SKPhysicsContact) {
        print(contact.bodyA.node!.name!)
        if let col = contact.bodyA.node {
            if col.name == "tikyu" {
                // 地球との衝突
                ball.removeFromParent()
                fallUtyujin()
            }
            func didBeginContact(contact: SKPhysicsContact) {
                print(contact.bodyA.node!.name!)
                if let col = contact.bodyA.node {
                    if col.name == "hosi" {
                        // 星との衝突
                        ball.removeFromParent()
                        fallUtyujin()

            
            }
            
            
        }
    }



        }}}

