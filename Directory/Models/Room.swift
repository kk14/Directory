//
//  Room.swift
//  Directory
//
//  Created by Kanishk Kumar on 05/07/2021.
//

import Foundation

struct Room: Codable {
    let id, createdAt, name: String
    let maxOccupancy: Int
    let isOccupied: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name
        case maxOccupancy = "max_occupancy"
        case isOccupied = "is_occupied"
    }
}
typealias Rooms = [Room]
