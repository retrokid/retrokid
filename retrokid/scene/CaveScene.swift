//
//  GameScene.swift
//  retrokid
//
//  Created by efe ertugrul on 21/07/2017.
//  Copyright © 2017 efe ertugrul. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class CaveScene : SKScene, SKPhysicsContactDelegate, PlayerControllerDelegate, MobControllerDelegate
{
    // MARK:- GOs
    
    var sceneCave1 : SKSpriteNode = SKSpriteNode()
    var sceneCave2 : SKSpriteNode = SKSpriteNode()
    
    var kapiFizikEngel : SKSpriteNode = SKSpriteNode()

    var backgroundMusic : SKAudioNode?
    
    var avPlayer : AVAudioPlayer?
    
    var player : PlayerGO = PlayerGO()
    var mobs : [MobGO]?
    
    var followCamera : SKCameraNode = SKCameraNode()
    
    // MARK:- CONTROLLERS
    
    var playerController : PlayerController = PlayerController()
    var mobController : MobController = MobController()
    
    // MARK:- GAMEDATA
    
    var gameData : GameData = GameData.init()
    
    // MARK:- SCENES
    
    // MARK:- INIT
    
    func playBG(nameOfAudioFileInAssetCatalog: String)
    {
        if let sound = NSDataAsset(name: nameOfAudioFileInAssetCatalog)
        {
            do
            {
                try avPlayer = AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeMPEGLayer3)
                avPlayer!.play()
            }
            catch
            {
                print("error initializing AVAudioPlayer")
            }
        }
    }
    
    func stopBG()
    {
        avPlayer?.stop()
    }
    
    override func didMove(to view: SKView)
    {
        self.setGameData()
        
        self.playerController.delegate = self
        self.mobController.delegate = self
        self.physicsWorld.contactDelegate = self
        
        self.assignGOs()
        self.activateGOs()
        self.activateControllers()
        self.addGOsToControllers()
        
        self.camera = followCamera
        self.playBG(nameOfAudioFileInAssetCatalog: k_sound_scene_cave_bg)
    }
    
    override func willMove(from view: SKView)
    {
        gameData.saveGameData()
        self.stopBG()
    }
    
    // MARK:- KEYBOARD

    override func keyUp(with event: NSEvent)
    {
        playerController.tusBirakildi(tus: event.keyCode)
    }
    
    override func keyDown(with event: NSEvent)
    {
        playerController.tusBasildi(tus: event.keyCode)
    }
    
    // MARK:- UPDATE
    // #todo update için optimizasyon yap
    override func update(_ currentTime: TimeInterval)
    {
        self.playerController.updatePlayer()
        self.mobController.refresh()
        
        if (gameData.testSceneMobs?.isEmpty)!
        {
            loadWinScene()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        guard let bodyA = contact.bodyA.node?.name else {return}
        guard let bodyB = contact.bodyB.node?.name else {return}
        
        if (bodyA == "player" || bodyB == "player") && ((bodyA.hasPrefix("kapi")) || (bodyB.hasPrefix("kapi")))
        {
            self.loadMobCaveScene()
        }
        
        print("\(String(describing: contact.bodyA.node?.name)) -- \(String(describing: contact.bodyB.node?.name))" )
    }
    
    // MARK:- SETTER FUNCTIONS
    
    func assignGOs()
    {
        self.sceneCave1 = childNode(withName: "scene-cave-1") as! SKSpriteNode
        self.sceneCave2 = childNode(withName: "scene-cave-2") as! SKSpriteNode
        
        self.mobs = gameData.testSceneMobs
        self.player = childNode(withName: "player") as! PlayerGO
        self.followCamera = childNode(withName: "//camera") as! SKCameraNode
    }
    
    func activateGOs()
    {
        self.player.activate()
        
        self.sceneCave1.texture?.filteringMode = .nearest
        self.sceneCave2.texture?.filteringMode = .nearest
        
//        for mob in mobs!
//        {
//            mob.activate()
//            self.addChild(mob)
//        }
    }
    
    func activateControllers()
    {
        playerController.activate(with: player)
    }
    
    func addGOsToControllers()
    {
        self.mobController.addAllMobs(mobs: mobs!)
    }
    
    func setGameData()
    {
        gameData.removeGameData()
        if gameData.currentGameData() == nil
        {
            let dict = ["player" : player,
                        "testSceneMobs" : [MobGO(), MobGO(), MobGO(), MobGO(), MobGO()]] as [String : Any]
            
            gameData = GameData.init(withDictionary: dict)
            gameData.saveGameData()
        }
        else
        {
            gameData = gameData.currentGameData()!
        }
    }
    
    
    // MARK:- PHYSICS FUNCTIONS
    
    func rayCastNorth() -> SKPhysicsBody?
    {
        
        let rayStart = player.position
        let rayEnd = CGPoint(x: player.position.x, y: player.position.y + 20)
        let body = self.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)
        
        return body
    }
    
    func rayCastSouth() -> SKPhysicsBody?
    {
        let rayStart = player.position
        let rayEnd = CGPoint(x: player.position.x, y: player.position.y - 20)
        let body = self.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)
        
        return body
    }
    
    func rayCastWest() -> SKPhysicsBody?
    {
        let rayStart = player.position
        let rayEnd = CGPoint(x: player.position.x - 25, y: player.position.y)
        let body = self.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)
        
        return body
    }
    
    func rayCastEast() -> SKPhysicsBody?
    {
        let rayStart = player.position
        let rayEnd = CGPoint(x: player.position.x + 25, y: player.position.y)
        let body = self.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)
        
        return body
    }
    
    func checkForMobHit(body: SKPhysicsBody?) -> MobGO?
    {
        for mob in mobs!
        {
            if (body?.isEqual(mob.physicsBody))!
            {
                return mob
            }
        }
        
        return nil
    }
    
    // MARK:- DELEGATE FUNCTIONS
    
    func playerDidDefeated()
    {
        
    }
    
    func playerDidAttackNorth()
    {
        guard let body = self.rayCastNorth() else { return }
        guard let mob = self.checkForMobHit(body: body) else { return }
        
        mobController.takeDamage(mob: mob)
    }
    
    func playerDidAttackEast()
    {
        guard let body = self.rayCastEast() else { return }
        guard let mob = self.checkForMobHit(body: body) else { return }
        
        mobController.takeDamage(mob: mob)
    }
    
    func playerDidAttackWest()
    {
        guard let body = self.rayCastWest() else { return }
        guard let mob = self.checkForMobHit(body: body) else { return }
        
        mobController.takeDamage(mob: mob)
    }
    
    func playerDidAttackSouth()
    {
        guard let body = self.rayCastSouth() else { return }
        guard let mob = self.checkForMobHit(body: body) else { return }
        
        mobController.takeDamage(mob: mob)
    }
    
    func mobDefeated(mob: MobGO)
    {
        self.removeChildren(in: [mob])
        self.gameData.testSceneMobs = self.gameData.testSceneMobs?.filter{$0 != mob}
    }
    
    // MARK:- LOAD SCENES
    
    func loadMobCaveScene()
    {
        if let scene = GKScene(fileNamed: k_mob_cave_scene)
        {
            if let sceneNode = scene.rootNode as! MobCaveScene?
            {
                sceneNode.scaleMode = .aspectFit
                if let view = self.view
                {
                    view.presentScene(sceneNode)
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func loadWinScene()
    {
        if let scene = GKScene(fileNamed: k_win_scene)
        {
            if let sceneNode = scene.rootNode as! WinScene?
            {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view
                {
                    view.presentScene(sceneNode)
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
}












