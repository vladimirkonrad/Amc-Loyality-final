//
//  WooModels.swift
//  Amc loyalty
//
//  Created by Vladimir Konrad on 13.12.21..
//

import Foundation
import SwiftyJSON


struct Products: Decodable {
    let title: String
    let permalink: String
    let price: String
 
}



// MARK: - Kategorije
struct Kategorije: Decodable {
    let productCategories: [ProductCategory]
}

// MARK: - ProductCategory
struct ProductCategory: Decodable{
    var id: Int?
    var image: String?
    var parent: Int?
    var name: String?
    var count: Int?
    var display: String?
    var description: String?
    var slug: String?

    init(json: JSON){
        self.name = json["name"].stringValue
        self.slug = json["slug"].stringValue
    }

    
}

