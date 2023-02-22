//
//  StringExtension.swift
//  Foodie
//
//  Created by Erkan on 19.02.2023.
//

import Foundation


extension String{
    var asUrl: URL?{
        return URL(string: self)
    }
}
