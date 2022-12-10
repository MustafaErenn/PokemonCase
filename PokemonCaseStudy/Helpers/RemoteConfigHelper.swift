//
//  RemoteConfigHelper.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 9.12.2022.
//

import Foundation
import FirebaseRemoteConfig

class CustomRemoteConfigManager {
    
    var boolResult : Bool = false
    
    var remoteConfig = RemoteConfig.remoteConfig()
    
    
    func fetchValues (fetchDone: @escaping (Bool) -> Void){
        
        let defaults : [String : NSObject] = [
            "isBgColorRed" : false as NSObject
        ]
        
        
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        
        remoteConfig.configSettings = settings
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
            if status == .success, error == nil{
                self.remoteConfig.activate(completion: {didGet, error in
                    
                    guard error == nil else{
                        return
                    }
                    
                    let value = self.remoteConfig.configValue(forKey: "isBgColorRed").boolValue
                    
                    self.boolResult = value
                    fetchDone(value)
                })
                
                
            }else{
                fetchDone(false)
            }
        })
        
        
    }
    
}
