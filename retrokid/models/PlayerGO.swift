//
//  PlayerGO.swift
//  retrokid
//
//  Created by efe ertugrul on 10/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerGO : SKSpriteNode
{
    // MARK:- CUSTOM VALUES
    
    var movementSpeed : CGFloat = 2
    let attackAnimationSpeed = 0.1
    var moveAnimationSpeed = 0.15
    var hp : Int = 8
    var defeated : Bool = false
    
    var camera : CameraGO = CameraGO()
    
    // MARK:- TEXTURES
    
    var moveEastTextures : [SKTexture] = []
    var moveWestTextures : [SKTexture] = []
    var moveSouthTextures : [SKTexture] = []
    var moveNorthTextures : [SKTexture] = []
    
    var idleEastTextures : [SKTexture] = []
    var idleWestTextures : [SKTexture] = []
    var idleSouthTextures : [SKTexture] = []
    var idleNorthTextures : [SKTexture] = []
    
    var attackSouthTextures : [SKTexture] = []
    var attackNorthTextures : [SKTexture] = []
    var attackEastTextures : [SKTexture] = []
    var attackWestTextures : [SKTexture] = []
    
    // MARK:- ACTIONS
    
    var moveNorthAnimation : (action: SKAction, key: String) = (SKAction(), "playerMoveNorthAnimation")
    var moveSouthAnimation : (action: SKAction, key: String) = (SKAction(), "playerMoveSouthAnimation")
    var moveWestAnimation : (action: SKAction, key: String) = (SKAction(), "playerMoveWestAnimation")
    var moveEastAnimation : (action: SKAction, key: String) = (SKAction(), "playerMoveEastAnimation")
    
    var attackSouthAnimation : (action: SKAction, key: String) = (SKAction(), "playerAttackSouthAnimation")
    var attackNorthAnimation : (action: SKAction, key: String) = (SKAction(), "playerAttackNorthAnimation")
    var attackWestAnimation : (action: SKAction, key: String) = (SKAction(), "playerAttackWestAnimation")
    var attackEastAnimation : (action: SKAction, key: String) = (SKAction(), "playerAttackEastAnimation")
    
    var takeDamageAnimation : (action: SKAction, key: String) = (SKAction(), "playerTakeDamageAnimation")
    
    // MARK:- INIT
    
    func activate()
    {
        self.setTextures()
        self.setAllTexturesToNearest()
        self.setAnimations()
        self.setPhysicsBody()
        self.setPositionAndSize()
        self.setName()
        self.setChildObjects()
    }
    
    // MARK:- SETTERS

    func setName()
    {
        self.name = "player"
    }
    
    func setChildObjects()
    {
        self.addChild(self.camera)
    }
    
    func setPositionAndSize()
    {
        // #todo size ı yukarda belirtmek daha mantıklı
        self.position = .zero
        self.size = CGSize(width: 50, height: 42)
    }
    
    func setPhysicsBody()
    {
        // w:15 h:21
        let physicsBodySize : CGSize = CGSize(width: 15.0, height: 21.0)
        let physicsBodyOrigin : CGPoint = .zero
        
        self.physicsBody = SKPhysicsBody(rectangleOf: physicsBodySize, center: physicsBodyOrigin)
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.pinned = false
        
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.fieldBitMask = 1
        
    }
    
    func setTextures()
    {
        moveEastTextures.append(SKTexture(imageNamed: k_player_move_east_1))
        moveEastTextures.append(SKTexture(imageNamed: k_player_move_east_2))
        moveEastTextures.append(SKTexture(imageNamed: k_player_move_east_3))
        moveEastTextures.append(SKTexture(imageNamed: k_player_move_east_4))
        
        moveWestTextures.append(SKTexture(imageNamed: k_player_move_west_1))
        moveWestTextures.append(SKTexture(imageNamed: k_player_move_west_2))
        moveWestTextures.append(SKTexture(imageNamed: k_player_move_west_3))
        moveWestTextures.append(SKTexture(imageNamed: k_player_move_west_4))
        
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_1))
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_2))
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_3))
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_4))
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_5))
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_6))
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_7))
        moveNorthTextures.append(SKTexture(imageNamed: k_player_move_north_8))
        
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_1))
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_2))
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_3))
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_4))
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_5))
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_6))
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_7))
        moveSouthTextures.append(SKTexture(imageNamed: k_player_move_south_8))
        
        idleEastTextures.append(SKTexture(imageNamed: k_player_move_east_1))
        
        idleWestTextures.append(SKTexture(imageNamed: k_player_move_west_1))
        
        idleNorthTextures.append(SKTexture(imageNamed: k_player_move_north_1))
        
        idleSouthTextures.append(SKTexture(imageNamed: k_player_move_south_1))
        
        attackNorthTextures.append(SKTexture(imageNamed: k_player_attack_north_sword_1))
        attackNorthTextures.append(SKTexture(imageNamed: k_player_attack_north_sword_2))
        attackNorthTextures.append(idleNorthTextures.first!)
        
        attackSouthTextures.append(SKTexture(imageNamed: k_player_attack_south_sword_1))
        attackSouthTextures.append(SKTexture(imageNamed: k_player_attack_south_sword_2))
        attackSouthTextures.append(idleSouthTextures.first!)
        
        attackWestTextures.append(SKTexture(imageNamed: k_player_attack_west_sword_1))
        attackWestTextures.append(SKTexture(imageNamed: k_player_attack_west_sword_2))
        attackWestTextures.append(idleWestTextures.first!)
        
        attackEastTextures.append(SKTexture(imageNamed: k_player_attack_east_sword_1))
        attackEastTextures.append(SKTexture(imageNamed: k_player_attack_east_sword_2))
        attackEastTextures.append(idleEastTextures.first!)
    }
    
    func setAnimations()
    {
        moveNorthAnimation.action =  SKAction.animate(with: moveNorthTextures, timePerFrame: moveAnimationSpeed)
        moveSouthAnimation.action = SKAction.animate(with: moveSouthTextures, timePerFrame: moveAnimationSpeed)
        moveWestAnimation.action = SKAction.animate(with: moveWestTextures, timePerFrame: moveAnimationSpeed)
        moveEastAnimation.action = SKAction.animate(with: moveEastTextures, timePerFrame: moveAnimationSpeed)
        
        attackSouthAnimation.action = SKAction.animate(with: attackSouthTextures, timePerFrame: attackAnimationSpeed)
        attackNorthAnimation.action = SKAction.animate(with: attackNorthTextures, timePerFrame: attackAnimationSpeed)
        attackWestAnimation.action = SKAction.animate(with: attackWestTextures, timePerFrame: attackAnimationSpeed)
        attackEastAnimation.action = SKAction.animate(with: attackEastTextures, timePerFrame: attackAnimationSpeed)
        takeDamageAnimation.action = self.makeTakeDamageAnimation()
    }
    
    func setAllTexturesToNearest()
    {
        for texture in moveEastTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in moveWestTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in moveSouthTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in moveNorthTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in idleEastTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in idleWestTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in idleNorthTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in idleSouthTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in attackSouthTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in attackNorthTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in attackWestTextures
        {
            texture.filteringMode = .nearest
        }
        
        for texture in attackEastTextures
        {
            texture.filteringMode = .nearest
        }
    }
    
    // MARK:- FUNCTIONS
    
    func moveNorth()
    {
        if(self.action(forKey: moveNorthAnimation.key) == nil)
        {
            self.stopMoving()
            self.run(moveNorthAnimation.action, withKey: moveNorthAnimation.key)
        }
        self.position = CGPoint(x: self.position.x, y: self.position.y + movementSpeed)
        print("move north")
    }
    
    func moveSouth()
    {
        if(self.action(forKey: moveSouthAnimation.key) == nil)
        {
            self.stopMoving()
            self.run(moveSouthAnimation.action, withKey: moveSouthAnimation.key)
        }
        self.position = CGPoint(x: self.position.x, y: self.position.y - movementSpeed)
        print("move south")
    }
    
    func moveWest()
    {
        if(self.action(forKey: moveWestAnimation.key) == nil)
        {
            self.stopMoving()
            self.run(moveWestAnimation.action, withKey: moveWestAnimation.key)
        }
        self.position = CGPoint(x: self.position.x - movementSpeed, y: self.position.y)
        print("move west")
    }
    
    func moveEast()
    {
        if(self.action(forKey: moveEastAnimation.key) == nil)
        {
            self.stopMoving()
            self.run(moveEastAnimation.action, withKey: moveEastAnimation.key)
        }
        self.position = CGPoint(x: self.position.x + movementSpeed, y: self.position.y)
        print("move east")
    }
    
    func stopMoving()
    {
        if(self.action(forKey: moveEastAnimation.key) != nil)
        {
            self.removeAction(forKey: moveEastAnimation.key)
        }
        
        if(self.action(forKey: moveNorthAnimation.key) != nil)
        {
            self.removeAction(forKey: moveNorthAnimation.key)
        }
        
        if(self.action(forKey: moveSouthAnimation.key) != nil)
        {
            self.removeAction(forKey: moveSouthAnimation.key)
        }
        
        if(self.action(forKey: moveWestAnimation.key) != nil)
        {
            self.removeAction(forKey: moveWestAnimation.key)
        }
    }
    
    func idleNorth()
    {
        self.texture = idleNorthTextures.first
        print("idle north")
    }
    
    func idleSouth()
    {
        self.texture = idleSouthTextures.first
        print("idle south")
    }
    
    func idleWest()
    {
        self.texture = idleWestTextures.first
        print("idle west")
    }
    
    func idleEast()
    {
        self.texture = idleEastTextures.first
        print("idle east")
    }
    
    func attackNorth()
    {
        self.run(attackNorthAnimation.action, withKey: attackNorthAnimation.key)
        print("attack north")
    }
    
    func attackSouth()
    {
        self.run(attackSouthAnimation.action, withKey: attackSouthAnimation.key)
        print("attack south")
    }
    
    func attackWest()
    {
        self.run(attackWestAnimation.action, withKey: attackWestAnimation.key)
        print("attack west")
    }
    
    func attackEast()
    {
        self.run(attackEastAnimation.action, withKey: attackEastAnimation.key)
        print("attack east")
    }
    
    func setHpBar(to hp: Int)
    {
        guard hp >= 0  else { return }
        
        let hpBar : PlayerHpBar = self.camera.childNode(withName: "player-hp-bar") as! PlayerHpBar
        hpBar.setHp(to: hp)
    }
    
    func takeDamage()
    {
        guard hp >= 0  else { return }
        self.run(takeDamageAnimation.action, withKey: takeDamageAnimation.key)
        self.hp -= 1
        self.setHpBar(to: hp)
    }
    
    func makeTakeDamageAnimation() -> SKAction
    {
        let pulse = SKAction.fadeOut(withDuration: 0.5)
        let reverse = pulse.reversed()
        let seq = SKAction.sequence([pulse, reverse])
        return seq
    }
    
}















