//
//  MobController.swift
//  retrokid
//
//  Created by efe ertugrul on 13/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit

class MobController : NSObject
{
    var delegate : MobControllerDelegate?
    
    // MARK:- GOs
    
    var mobs : [MobGO] = [MobGO]()
    
    // MARK:- INIT
    
    func addMob(mob: MobGO)
    {
        mobs.append(mob)
    }
    
    func addAllMobs(mobs: [MobGO])
    {
        self.mobs = mobs
    }
    
    func removeMob(mob: MobGO)
    {
        for i in 0..<mobs.count
        {
            if mobs[i] == mob
            {
                mobs.remove(at:i)
            }
        }
    }
    
    // MARK:- UPDATE
    
    func refresh()
    {
        for mob in mobs
        {
            if mob.defeated
            {
                delegate?.mobDefeated(mob: mob)
            }
            
            if mob.hp == 0
            {
                mob.hp = -1
                if mob.action(forKey: mob.defeatAnimation.key) == nil
                {
                    mob.defeat()
                }
            }
            
            if mob.action(forKey: mob.randomMoveTranslation.key) == nil && mob.hp > 0
            {
                mob.makeRandomMoveTranslation()
                mob.randomMove()
            }
        }
    }
    
    func takeDamage(mob: MobGO)
    {
        mob.takeDamage()
    }
}

protocol MobControllerDelegate
{
    func mobDefeated(mob: MobGO)
}















