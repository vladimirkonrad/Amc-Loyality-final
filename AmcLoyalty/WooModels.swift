//
//  WooModels.swift
//  Amc loyalty
//
//  Created by Vladimir Konrad on 13.12.21..
//

import Foundation
import SwiftyJSON


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


// MARK: - Product

struct Product: Decodable {
    let name: String?
    let permalink: String?
    let sku: String?
    let price: String?
    let description: String?
    let images: [Slika]
//    let images: String?
    
}

struct Slika: Decodable{
    let src: String
}


//struct ProductData: Decodable {
//
//    let name: String
//    let images: Images
//
//    var model: ProductModel{
//      return ProductModel (productName: name, src: images.src )
//
//
//    }
//
//}
//
//struct Images: Decodable {
//    let src: String
//}
//
//struct ProductModel {
//    let productName: String
//   let src: String
//}
//
//
//struct WeatherDataFailure: Decodable {
//    let message: String
//}
//
