//
//  EmployeeDetail.swift
//  Directory
//
//  Created by Kanishk Kumar on 08/07/2021.
//

import Foundation

struct EmployeeDetail {
    let detailType: EmployeeDetailDetailType
    let detailLabel: String
    let detailValue: String
}

enum EmployeeDetailDetailType {
    case phone
    case location
    case email
}
