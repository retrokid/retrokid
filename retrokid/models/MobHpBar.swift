//
//  MobHpBar.swift
//  retrokid
//
//  Created by efe ertugrul on 24/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit

class MobHpBar : SKSpriteNode
{
    // MARK:- TEXTURES
    
    var mobHpBarTextures : [SKTexture] = [SKTexture]()
    
    // MARK:- INIT
    
    func activate()
    {
        self.setTextures()
        self.setAllTexturesToNearest()
        self.setDefaultTexture()
        self.setPositionAndSize()
    }
    
    // MARK:- SETTERS
    
    func setPositionAndSize()
    {
        self.position = CGPoint(x: 0, y: -8)
        self.size = CGSize(width: 17, height: 2)
    }
    
    func setTextures()
    {
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_1))
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_2))
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_3))
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_4))
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_5))
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_6))
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_7))
        self.mobHpBarTextures.append(SKTexture(imageNamed: k_ui_mob_hp_bar_8))
    }
    
    func setAllTexturesToNearest()
    {
        for texture in mobHpBarTextures
        {
            texture.filteringMode = .nearest
        }
    }
    
    func setDefaultTexture()
    {
        self.texture = mobHpBarTextures.last
    }
    
    // MARK:- FUNCTIONS
    
    func setHp(to hp: Int)
    {
        guard (hp >= 0 && hp <= 8) else
        {
            fatalError("hp bar 0 ile 8 arasında olmalıdır")
        }

        self.texture = mobHpBarTextures[hp]
    }
}














