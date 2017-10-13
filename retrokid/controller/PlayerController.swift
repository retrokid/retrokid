//
//  WorldDirector.swift
//  retrokid
//
//  Created by efe ertugrul on 10/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import SpriteKit
import Foundation
import GameplayKit

class PlayerController : NSObject
{
    // MARK:- GOs
    
    var player : PlayerGO = PlayerGO()
    
    let north : (key: String, keyCode: UInt16) = ("w", 13)
    let west : (key: String, keyCode: UInt16) = ("a", 0)
    let south : (key: String, keyCode: UInt16) = ("s", 1)
    let east : (key: String, keyCode: UInt16) = ("d", 2)
    
    let attack : (key: String, keyCode: UInt16) = ("k", 40)
    
    // MARK:- CUSTOM VALUES
    
    var aktifYon : Directions
    var pasifYon : Directions
    var saldiriYonu : Directions
    
    var delegate : PlayerControllerDelegate?
    
    enum Directions
    {
        case north
        case west
        case south
        case east
        case none
    }
    
    // MARK:- INIT
    
    override init()
    {
        aktifYon = .none
        pasifYon = .east
        saldiriYonu = .east
    }
    
    func activate(with player: PlayerGO)
    {
        self.player = player
    }
    
    // MARK:- UPDATE
    
    func updatePlayer()
    {
        self.yuru()
        self.bekle()
    }
    
    // MARK:- KEYBOARD
    
    func tusBasildi(tus: UInt16)
    {
        switch tus
        {
        case north.keyCode:
            aktifYon = .north
            saldiriYonu = .north
        case west.keyCode:
            aktifYon = .west
            saldiriYonu = .west
        case south.keyCode:
            aktifYon = .south
            saldiriYonu = .south
        case east.keyCode:
            aktifYon = .east
            saldiriYonu = .east
        case attack.keyCode:
            self.saldir()
        default:
            break
        }
    }
    
    func tusBirakildi(tus: UInt16)
    {
        switch tus
        {
        case north.keyCode:
            if aktifYon == .north
            {
                aktifYon = .none
                pasifYon = .north
                saldiriYonu = .north
            }
        case west.keyCode:
            if aktifYon == .west
            {
                aktifYon = .none
                pasifYon = .west
                saldiriYonu = .west
            }
        case south.keyCode:
            if aktifYon == .south
            {
                aktifYon = .none
                pasifYon = .south
                saldiriYonu = .south
            }
        case east.keyCode:
            if aktifYon == .east
            {
                aktifYon = .none
                pasifYon = .east
                saldiriYonu = .east
            }
        default:
            break
        }
    }
    
    // MARK:- FUNCTIONS
    
    func saldir()
    {
        if aktifYon == .none
        {
            switch saldiriYonu
            {
            case .north:
                player.attackNorth()
                delegate?.playerDidAttackNorth()
            case .south:
                player.attackSouth()
                delegate?.playerDidAttackSouth()
            case .east:
                player.attackEast()
                delegate?.playerDidAttackEast()
            case .west:
                player.attackWest()
                delegate?.playerDidAttackWest()
            default:
                break
            }
        }
    }
    
    func yuru()
    {
        switch aktifYon
        {
        case .north:
            player.moveNorth()
        case .west:
            player.moveWest()
        case .south:
            player.moveSouth()
        case .east:
            player.moveEast()
        case .none:
            player.stopMoving()
            break
        }
    }
    
    func bekle()
    {
        switch pasifYon
        {
        case .north:
            player.idleNorth()
            pasifYon = .none
        case .west:
            player.idleWest()
            pasifYon = .none
        case .south:
            player.idleSouth()
            pasifYon = .none
        case .east:
            player.idleEast()
            pasifYon = .none
        default:
            break
        }
    }
    
    func takeDamage()
    {
        player.takeDamage()
    }
}

protocol PlayerControllerDelegate
{
    func playerDidAttackNorth()
    func playerDidAttackWest()
    func playerDidAttackEast()
    func playerDidAttackSouth()
}





















