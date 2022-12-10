//
//  RemoteConfigHelper.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 9.12.2022.
//

import Foundation
import FirebaseRemoteConfig

class RemoteConfigHelper {
    
    static let instance = RemoteConfigHelper();
    
    var remoteConfig = RemoteConfig.remoteConfig();
    let settings = RemoteConfigSettings();
    let defaults : [String:NSObject]?;
    
    init() {
        settings.minimumFetchInterval = 0;
        remoteConfig.configSettings = settings;
        defaults = [
            "isBgColorRed" : false as NSObject
        ];
    }
}

class CustomRemoteConfigManager {

    var boolResult : Bool = false

    var remoteConfig = RemoteConfig.remoteConfig()


    func fetchValues (fetchDone: @escaping (Bool) -> Void){
        print("Servis içine GİRDİ")

        let defaults : [String : NSObject] = [
            "isBgColorRed" : false as NSObject
        ]


        remoteConfig.setDefaults(defaults)

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0

        remoteConfig.configSettings = settings
        print("SERVİS İÇİ fetch üstü")
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
            print("SERVİS İÇİ fetch içi")
            if status == .success, error == nil{
                print("SERVİS İÇİ succes oldu mu")
                self.remoteConfig.activate(completion: {didGet, error in

                    guard error == nil else{
                        return
                    }

                    let value = self.remoteConfig.configValue(forKey: "isBgColorRed").boolValue

                    print("SERVİS İÇİ fetched : (value)")
                    print("SERVİS İÇİ Atanmadan önce değer : (self.boolResult)")
                    self.boolResult = value
                    print("SERVİS İÇİ Atandıktan sonra değer : (self.boolResult)")
                    fetchDone(value)
                })


            }else{
                print("Something went wrong")
                fetchDone(false)
            }

        })


    }

}
