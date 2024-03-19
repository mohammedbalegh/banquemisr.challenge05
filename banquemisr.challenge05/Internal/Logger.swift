//
//  Logger.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 14/03/2024.
//

import Foundation

struct Logger {
    static func info(_ message: Any) {
        print("ℹ️", message)
    }
    
    static func error(_ message: Any) {
        print("❌", message)
    }
    
    static func fatal(_ message: Any) -> Never {
        print("❌", message)
        fatalError("\(message)")
    }
}
