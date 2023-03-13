//
//  File.swift
//  
//
//  Created by Benjamin Morrison on 13/3/2023.
//

import Foundation

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var desc = "["
        for val in self {
            desc.append("\(val), ")
        }
        desc.append("]")
        
        return desc
    }
}
