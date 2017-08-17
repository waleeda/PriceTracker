//
//  File.swift
//  Price Tracker
//
//  Created by Waleed Azhar on 8/17/17.
//  Copyright © 2017 Waleed Azhar. All rights reserved.
//

import Foundation

struct PriceTrack {
    var products:[Product] = []
    let name:String
}

struct Product {
    var name:String
    let url:String
    var price: String = ""
}

class ModelData {
    static var shared:ModelData = ModelData()
    var tracks:[PriceTrack] = []
    var products:[Product] = []
    var sections: [String] = []
}
