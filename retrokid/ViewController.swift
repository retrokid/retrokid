//
//  ViewController.swift
//  retrokid
//
//  Created by efe ertugrul on 21/07/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController
{

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        if let scene = GKScene(fileNamed: "BattleScene")
//        {
//            if let sceneNode = scene.rootNode as! BattleScene?
//            {
//                sceneNode.scaleMode = .aspectFill
//                if let view = self.skView
//                {
//                    view.presentScene(sceneNode)
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                }
//            }
//        }
        
        if let scene = GKScene(fileNamed: k_cave_scene)
        {
            if let sceneNode = scene.rootNode as! CaveScene?
            {
                sceneNode.scaleMode = .aspectFit
                if let view = self.skView
                {
                    view.presentScene(sceneNode)
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
}

