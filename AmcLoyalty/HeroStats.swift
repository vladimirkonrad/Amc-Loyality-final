//
//  HeroStats.swift
//  JSONintoTableView
//
//  Created by Vladimir Konrad on 12.12.21..
//

import Foundation

struct HeroStats: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
    
    
}


