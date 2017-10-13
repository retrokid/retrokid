//
//  UIGo.swift
//  retrokid
//
//  Created by efe ertugrul on 18/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerHpBar : SKSpriteNode
{
    // MARK:- TEXTURES
    
    var playerHpBarTextures : [SKTexture] = [SKTexture]()
    let nodeName = "player-hp-bar"
    
    // MARK:- INIT
    
    func activate()
    {
        self.setTextures()
        self.setAllTexturesToNearest()
        self.setDefaultTexture()
        self.setPositionAndSize()
        self.setName()
    }
    
    // MARK:- SETTERS
    
    func setPositionAndSize()
    {
        self.position = CGPoint(x:-416, y:360)
        self.size = CGSize(width: 190, height: 45)
    }
    
    func setTextures()
    {
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_0))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_1))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_2))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_3))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_4))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_5))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_6))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_7))
        self.playerHpBarTextures.append(SKTexture(imageNamed: k_ui_world_menu_top_left_8))
    }
    
    func setAllTexturesToNearest()
    {
        for texture in playerHpBarTextures
        {
            texture.filteringMode = .nearest
        }
    }
    
    func setDefaultTexture()
    {
        self.texture = playerHpBarTextures.first
    }
    
    func setName()
    {
        self.name = nodeName
    }
    
    // MARK:- FUNCTIONS
    
    func setHp(to hp: Int)
    {
        guard (hp >= 0 && hp <= 8) else
        {
            fatalError("hp bar 0 ile 8 arasında olmalıdır")
        }
        
        self.texture = playerHpBarTextures[hp]
    }
}














