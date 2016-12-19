//
//  GameViewController2.swift
//  uty-jin
//
//  Created by KAREN on 2016/04/04.
//  Copyright © 2016年 KAREN. All rights reserved.
//


import UIKit
import SpriteKit

class GameViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hoe1")
        // シーンの作成
        let scene2 = GameScene2()
        
        // View ControllerのViewをSKView型として取り出す
        let view = self.view as! SKView
        
        // FPSの表示
        view.showsFPS = true
        
        // ノード数の表示
        view.showsNodeCount = true
        
        // シーンのサイズをビューに合わせる
        scene2.size = view.frame.size
        
        // ビュー上にシーンを表示
        view.presentScene(scene2)
        
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