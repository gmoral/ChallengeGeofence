//
//  Header.swift
//  API_Layer
//
//  Created by Guillermo Moral on 08/08/2021.
//

import Foundation

enum Header {
    enum Field: String {
        case contentType = "content-Type"
    }
    
    enum Value: String {
        case json = "application/json"
    }
}
