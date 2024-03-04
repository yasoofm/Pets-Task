//
//  Pet.swift
//  PetsTask
//
//  Created by yousef mandani on 04/03/2024.
//

import Foundation

struct Pet: Codable{
    var id: Int?
    var name: String
    var adopted: Bool
    var image: String
    var age: Int
    var gender: String
}
