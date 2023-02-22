//
//  AppError.swift
//  Foodie
//
//  Created by Erkan on 21.02.2023.
//

import Foundation


enum AppError: LocalizedError{
    case errorDecoding
    case unkownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String?{
        switch self{
        case .errorDecoding:
            return "Response could not be decoded"
        case .unkownError:
            return "UNKNOWN"
        case .invalidUrl:
            return "Invalid Url"
        case .serverError(let error):
            return error
        }
    }
}
