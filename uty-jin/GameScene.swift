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
    
    override func didMoveToView(view: SKView) {
        
        print("hoge")
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: frame.width, height:
            frame.height))
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.friction = 0.0
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.name = "frame"
        
        self.physicsWorld.gravity = CGVector(dx:0.0, dy: -2.0)
        self.fallUtyujin()
        
        
    }
    
    //ボールが何かに当たったときに呼ばれる
    func didBeginContact(contact: SKPhysicsContact) {
        print(contact.bodyA.node!.name!)
        if let nodeA = contact.bodyA.node {
            if nodeA.name == "frame" {
                // 壁との衝突
            }else if nodeA.name == "redSquare"{
                //　赤い四角との衝突
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if (last == nil) {
            last = currentTime
        }
        
        // 何秒おきに呼ばれるか
        if last + 1 <= currentTime {
            last = currentTime
        }
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
        let radius: CGFloat = 20
        
        
        ball = SKSpriteNode(imageNamed:"utyujin1.PNG")
        ball.position = CGPointMake(0, -20);
        ball.name = "ball";
        ball.physicsBody = SKPhysicsBody(circleOfRadius:ball.size.width/2)
        ball.physicsBody!.dynamic = false;
        ball.position = CGPoint(x:50, y:500)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.restitution = 0.0
        ball.physicsBody?.linearDamping = 0.0
        ball.physicsBody?.mass = 1.0
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.contactTestBitMask = 1
        ball.physicsBody?.collisionBitMask = 1
        ball.name = "ball"
        self.addChild(ball)

    }
    
    
}
