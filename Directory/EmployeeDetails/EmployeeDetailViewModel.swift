//
//  EmployeeDetailViewModel.swift
//  Directory
//
//  Created by Kanishk Kumar on 07/07/2021.
//

import Foundation


class EmployeeDetailViewModel {
    
    let employee: Employee
    private var employeeDetails = [EmployeeDetail]()

    
    init(withEmployee employee: Employee) {
        self.employee = employee
        self.setupAllDetails()
    }
    private func setupAllDetails() {
        employeeDetails.append(EmployeeDetail(detailType: .phone, detailLabel:"Phone", detailValue: employee.phone))
        employeeDetails.append(EmployeeDetail(detailType: .email, detailLabel:"Email", detailValue: employee.email))
        employeeDetails.append(EmployeeDetail(detailType: .location, detailLabel:"Location", detailValue: "Show in Apple Maps"))
    }
    
    func getProfilePhotoURL() -> String {
        return employee.avatar
    }

    func getName() -> String {
        return employee.firstName + " " + employee.lastName
    }

    func getJobTitle() -> String {
        return employee.jobTitle
    }

    func getEmployeeDetailsCount() -> Int {
        return employeeDetails.count
    }

    func getEmployeeDetail(forIndexPath indexPath: IndexPath) -> EmployeeDetail {
        return employeeDetails[indexPath.row - 1]
    }

}
