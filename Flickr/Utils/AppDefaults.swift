//
//  AppDefaults.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 03.12.21.
//

import Foundation

class AppDefaults {
    
    static let defaults = UserDefaults.standard
    
    enum Keys: String {
        case searchPhoto
    }
    
    // MARK: Setters
    
    static func setObject(value: AnyObject, key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func setAny(value: Any, key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func setString(value: String, key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func setInteger(value: Int, key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func setDouble(value: Double, key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func setFloat(value: Float, key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func setBool(value: Bool, key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    
    // MARK: Getters
    
    static func getObject(key: Keys) -> AnyObject? {
        return defaults.object(forKey: key.rawValue) as AnyObject?
    }
    
    static func getAny(key: Keys) -> Any? {
        return defaults.object(forKey: key.rawValue) as Any?
    }
    
    static func getString(key: Keys) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    static func getInteger(key: Keys) -> Int {
        return defaults.integer(forKey: key.rawValue)
    }
    
    static func getDouble(key: Keys) -> Double {
        return defaults.double(forKey: key.rawValue)
    }
    
    static func getFloat(key: Keys) -> Float {
        return defaults.float(forKey: key.rawValue)
    }
    
    static func getBool(key: Keys) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
    
    // MARK: Remover
    
    static func remove(key: Keys) {
        defaults.removeObject(forKey: key.rawValue)
        defaults.synchronize()
    }
}
