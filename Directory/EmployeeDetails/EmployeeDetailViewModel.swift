//
//  EmployeeDetailViewModel.swift
//  Directory
//
//  Created by Kanishk Kumar on 07/07/2021.
//

import Foundation
import UIKit


class EmployeeDetailViewModel {
    

    let employee: Employee
    private let imageService: ImageService
    let employeeAvatarImage: Observable<UIImage>


    private var employeeDetails = [EmployeeDetail]()
    
    init(withEmployee employee: Employee) {
        self.employee = employee
        self.imageService = ImageServiceImplementation(api: API(urlSession: URLSession(configuration: URLSessionConfiguration.default), baseURL: URL(string: employee.avatar)!))
        self.employeeAvatarImage = Observable<UIImage>(UIImage(named: "person") ?? #imageLiteral(resourceName: "person"))
        self.setupAllDetails()
        self.getEmployeeAvatarImage()

    }
    private func setupAllDetails() {
        employeeDetails.append(EmployeeDetail(detailType: .phone, detailLabel:"Phone", detailValue: employee.phone))
        employeeDetails.append(EmployeeDetail(detailType: .email, detailLabel:"Email", detailValue: employee.email))
        employeeDetails.append(EmployeeDetail(detailType: .location, detailLabel:"Location", detailValue: "Show in Apple Maps"))
    }
    private func getEmployeeAvatarImage() {
        imageService.downloadImage() { [weak self] result in
            if let image = try? result.unwrapped() {
                self?.employeeAvatarImage.value = image
            }
        }
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
