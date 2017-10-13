//
//  CustomDice.swift
//  retrokid
//
//  Created by efe ertugrul on 11/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class RandomMovement : NSObject
{
    // MARK:- PROPERTIES
    
    var y : GKRandomDistribution = GKRandomDistribution()
    var x : GKRandomDistribution = GKRandomDistribution()
    var randomWaitTime : GKRandomDistribution = GKRandomDistribution()
    var position : CGPoint = CGPoint()
    
    // MARK:- INIT
    
    func activate(withPosition: CGPoint, maxRange: Int, waitTime: Int)
    {
        let lowestValX = Int(withPosition.x) - maxRange
        let highestValX = Int(withPosition.x) + maxRange
        
        let lowestValY = Int(withPosition.y) - maxRange
        let highestValY = Int(withPosition.y) + maxRange
        
        y = GKRandomDistribution.init(lowestValue: lowestValY, highestValue: highestValY)
        x = GKRandomDistribution.init(lowestValue: lowestValX, highestValue: highestValX)
        
        randomWaitTime = GKRandomDistribution.init(forDieWithSideCount: waitTime)
        position = withPosition
    }
    
    // MARK:- GETTERS
    
    func randomPosition() -> CGPoint
    {
        let position = CGPoint(x: x.nextInt(), y: y.nextInt())
        return position
    }
    
    func randomTime() -> Int
    {
        let waitTime = randomWaitTime.nextInt()
        return waitTime
    }
    
}


















