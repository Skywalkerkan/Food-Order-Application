//
//  UserDefaultsExtension.swift
//  Foodie
//
//  Created by Erkan on 22.02.2023.
//

import Foundation

extension UserDefaults{
    private enum UserDefaultsKeys: String{
        case hasOnboarded
    }
    
    var hasOnboarded: Bool{
        get{
            bool(forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
    }
}
