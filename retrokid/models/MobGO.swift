//
//  MobGO.swift
//  retrokid
//
//  Created by efe ertugrul on 10/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit

class MobGO : SKSpriteNode
{
    // MARK:- CUSTOM VALUES
    
    let movementSpeed : CGFloat = 1
    let animationSpeed = 0.15
    var hp : Int = 8
    var defeated : Bool = false
    
    var randomizer : RandomMovement = RandomMovement()
    
    var hpBar : MobHpBar = MobHpBar()
    
    // MARK:- TEXTURES
    
    var moveNormalTextures : [SKTexture] = []
    var idleNormalTextures : [SKTexture] = []
    var effectSmoke1Textures : [SKTexture] = []
    
    // MARK:- ACTIONS
    
    var moveNormalAnimation : (action: SKAction, key: String) = (SKAction(), "mobMoveNormalAnimation")
    var idleNormalAnimation : (action: SKAction, key: String) = (SKAction(), "mobIdleNormalAnimation")
    var takeDamageAnimation : (action: SKAction, key: String) = (SKAction(), "mobTakeDamageAnimation")
    var randomMoveTranslation : (action: SKAction, key: String) = (SKAction(), "randomMoveTranslation")
    var defeatAnimation : (action: SKAction, key: String) = (SKAction(), "defeatAnimation")
    
    // MARK:- INIT
    
    func activate()
    {
        
        self.setPositionAndSize()
        self.randomizer.activate(withPosition: self.position, maxRange: 100, waitTime: 3)
        self.setPhysicsBody()
        self.setTextures()
        self.setAllTexturesToNearest()
        self.setAnimations()
        self.setName()
        self.hpBar.activate()
        self.setChildObjects()
        // #todo bunun yeri controller
        self.run(.repeatForever(moveNormalAnimation.action), withKey: moveNormalAnimation.key)
    }
    
    // MARK:- SETTERS
    
    // #todo sil name kullanmıycam
    func setName()
    {
        self.name = "mob1"
    }
    
    func setChildObjects()
    {
        self.addChild(self.hpBar)
    }
    
    func setPositionAndSize()
    {
        // #todo size ı yukarda belirtmek daha mantıklı
        self.position = CGPoint(x: -20, y: -238)
        self.size = CGSize(width: 16, height: 12)
    }
    
    func setPhysicsBody()
    {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = false
        
        self.physicsBody?.categoryBitMask = 0
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.fieldBitMask = 0
        self.physicsBody?.contactTestBitMask = 1
    }
    
    func setTextures()
    {
        moveNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_1))
        moveNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_2))
        moveNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_3))
        moveNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_4))
        
        idleNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_1))
        idleNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_2))
        idleNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_3))
        idleNormalTextures.append(SKTexture(imageNamed: k_mob_move_normal_4))
        
        effectSmoke1Textures.append(SKTexture(imageNamed: k_effect_smoke_1_1))
        effectSmoke1Textures.append(SKTexture(imageNamed: k_effect_smoke_1_2))
        effectSmoke1Textures.append(SKTexture(imageNamed: k_effect_smoke_1_3))
    }
    
    func setAnimations()
    {
        moveNormalAnimation.action = SKAction.animate(with: moveNormalTextures, timePerFrame: animationSpeed)
        idleNormalAnimation.action = SKAction.animate(with: idleNormalTextures, timePerFrame: animationSpeed)
        takeDamageAnimation.action = self.makeTakeDamageAnimation()
        
        defeatAnimation.action = SKAction.animate(with: effectSmoke1Textures, timePerFrame: 0.3)
    }
    
    func setAllTexturesToNearest()
    {
        for texture in moveNormalTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in idleNormalTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in effectSmoke1Textures
        {
            texture.filteringMode = .nearest
        }
    }
    
    // MARK:- FUNCTIONS
    
    func makeRandomMoveTranslation()
    {
        let randomPosition = randomizer.randomPosition()
        let randomWaitTime = Double(randomizer.randomTime())
        let move = SKAction.move(to: randomPosition, duration: 2)
        let wait = SKAction.customAction(withDuration: randomWaitTime, actionBlock: { _,_ in
            
        })
        
        let actionSequence = SKAction.sequence([move, wait])
        
        randomMoveTranslation.action = actionSequence
    }
    
    func randomMove()
    {
        self.run(randomMoveTranslation.action, withKey: randomMoveTranslation.key)
    }
    
    func takeDamage()
    {
        guard hp >= 0  else { return }
        self.run(takeDamageAnimation.action, withKey: takeDamageAnimation.key)
        self.hp -= 1
        self.setHpBar(to: hp)
    }
    
    func setHpBar(to hp: Int)
    {
        guard hp >= 0  else { return }
        self.hpBar.setHp(to: hp)
    }
    
    func defeat()
    {
        self.run(defeatAnimation.action) { 
            self.defeated = true
        }
    }
    
    func makeTakeDamageAnimation() -> SKAction
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.05)
        let fadeIn = fadeOut.reversed()
        let seq = SKAction.sequence([fadeOut, fadeIn])
        return seq
    }
}















