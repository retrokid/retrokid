//
//  JSONObject.swift
//  retrokid
//
//  Created by efe ertugrul on 14/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation

class JSONObject : NSObject
{
    override init()
    {
        super.init()
    }
    
    convenience init(withDictionary dict: [String : Any])
    {
        self.init()
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String)
    {
        print("No key \(key) - \(String(describing: value))")
    }
}




