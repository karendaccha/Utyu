//
//  GameViewController1.swift
//  uty-jin
//
//  Created by KAREN on 2016/04/03.
//  Copyright © 2016年 KAREN. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hoe1")
        // シーンの作成9
        let scene1 = GameScene1()
        
        // View ControllerのViewをSKView型として取り出す
        let view = self.view as! SKView
        
        // FPSの表示
        view.showsFPS = true
        
        // ノード数の表示
        view.showsNodeCount = true
        
        // シーンのサイズをビューに合わせる
        scene1.size = view.frame.size
        
        // ビュー上にシーンを表示
        view.presentScene(scene1)
        
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