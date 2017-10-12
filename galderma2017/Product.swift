//
//  Product.swift
//  galderma2017
//
//  Created by Francisco Barrios Romo on 11-10-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import Foundation

class Product: CustomStringConvertible {
    let id: Int64?
    var name: String
    var imageName: String
    
    init(id: Int64, name: String, imageName: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
    var description: String {
        return "id = \(self.id ?? 0), name = \(self.name), imageName = \(self.imageName)"
    }
}
