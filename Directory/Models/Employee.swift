//
//  Employee.swift
//  Directory
//
//  Created by Kanishk Kumar on 05/07/2021.
//

import Foundation

struct Employee: Codable {
    let avatar: String
    let phone, firstName, id: String
    let longitude: Double
    let favouriteColor, email, jobTitle, createdAt: String
    let latitude: Double
    let lastName: String
}
typealias Employees = [Employee]
