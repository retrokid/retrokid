//
//  CameraGO.swift
//  retrokid
//
//  Created by efe ertugrul on 28/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit

class CameraGO : SKCameraNode
{
    var playerHpBar : PlayerHpBar = PlayerHpBar()
    
    // MARK:- INIT
    
    override init()
    {
        super.init()
        self.setZPosition()
        self.setChildObjects()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init()
    }
    
    // MARK:- SETTERS
    
    func setZPosition()
    {
        self.zPosition = 5
    }
    
    func setChildObjects()
    {
        self.playerHpBar.activate()
        self.addChild(playerHpBar)
    }
}






