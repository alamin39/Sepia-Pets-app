//
//  Model.swift
//  Sepia Pets app
//
//  Created by Al-Amin on 30/11/22.
//

import Foundation

struct PetsInfo: Codable {
    let pets: [Pets]
}

struct Pets: Codable {
    let image_url: String
    let title: String
    let content_url: String
    let date_added: String
}
