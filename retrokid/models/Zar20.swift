//
//  RandomNumber.swift
//  retrokid
//
//  Created by efe ertugrul on 02/08/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import GameplayKit

/**
 20 yüzlü zar nesnesi oluşturur.
 - [Zar Wiki Sayfası](https://bitbucket.org/koltuk/rkmacos/wiki/zar.md)
 */

class Zar20: NSObject
{
    
    // MARK:- PROPERTIES
    
    let randomZar : GKRandomDistribution
    let gaussZar : GKGaussianDistribution

    // MARK:- INIT
    
    override init()
    {
        self.randomZar = GKRandomDistribution.d20()
        self.gaussZar = GKGaussianDistribution.d20()
    }
 
    // MARK:- FUNCTIONS
    
    func at() -> Int
    {
        return randomZar.nextInt()
    }
    
    
    func atGauss() -> Int
    {
        return gaussZar.nextInt()
    }
}






