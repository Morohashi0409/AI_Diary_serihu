//
//  AppDelegate.swift
//  AI_Diary
//
//  Created by moro on 2021/11/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // マイグレーション処理
          migration()
        let ud = UserDefaults.standard
       let firstLunchKey = "firstLunch"
       let firstLunch = [firstLunchKey: true]
       ud.register(defaults: firstLunch)

        return true
    }

    

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // Realmマイグレーション処理
    func migration() {
      // 次のバージョン（現バージョンが０なので、１をセット）
    let nextSchemaVersion = 13

      // マイグレーション設定
      let config = Realm.Configuration(
        schemaVersion: UInt64(nextSchemaVersion),
        migrationBlock: { migration, oldSchemaVersion in
          if (oldSchemaVersion < nextSchemaVersion) {
          }
        })
        Realm.Configuration.defaultConfiguration = config


}

}
