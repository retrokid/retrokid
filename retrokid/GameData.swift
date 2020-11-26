//
//  FileManager.swift
//  retrokid
//
//  Created by efe ertugrul on 13/09/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import Foundation
import SpriteKit

let DATA_KEY = "RetroKid"

class GameData : JSONObject, NSCoding
{
    var player : PlayerGO?
    
    var testSceneMobs : [MobGO]?
    
    override init()
    {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.player = aDecoder.decodeObject(forKey: "player") as? PlayerGO
        self.testSceneMobs = aDecoder.decodeObject(forKey: "testSceneMobs") as? [MobGO]
    }

    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.player, forKey: "player")
        aCoder.encode(self.testSceneMobs, forKey: "testSceneMobs")
    }

    func saveGameData()
    {
        let prefs = UserDefaults.standard
        // let myEncodedObject : Data = NSKeyedArchiver.archivedData(withRootObject: self)
        do
        {
            let myEncodedObject = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            prefs.setValue(myEncodedObject, forKey: DATA_KEY)
            prefs.synchronize()
        }
        catch
        {
            
        }
        

    }
    
    func removeGameData()
    {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey: DATA_KEY)
        prefs.synchronize()
    }
    
    func currentGameData() -> GameData?
    {
        let prefs = UserDefaults.standard
        let myEncodedObject : Data? = prefs.object(forKey: DATA_KEY) as? Data
        
        if myEncodedObject == nil
        {
            return nil
        }
        
        do
        {
            let data = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(myEncodedObject!) as! GameData
            return data
        }
        catch
        {
            return nil
        }
            
    }
    
    public func dictionaryRepresentation() -> [String : Any?]
    {
        var dictionary = [String : Any?]()
        
        dictionary["player"] = self.player
        dictionary["testSceneMobs"] = self.testSceneMobs
        
        return dictionary
    }

}

















