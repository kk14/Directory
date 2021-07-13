//
//  DirectoryListViewModel.swift
//  Directory
//
//  Created by Kanishk Kumar on 05/07/2021.
//

import Foundation

class DirectoryListViewModel {
    private let directoryListService: DirectoryListService
    
    let employeeDictionary: Observable<Dictionary<String, [Employee]>>
    
    var employees: [Employee]? {
      didSet {
        guard let value = employees else {
          return
        }
        updateObservables(employees: value)
      }
    }
    init() {
        self.directoryListService = DirectoryListServiceImplementation(api: API(urlSession: URLSession(configuration: URLSessionConfiguration.default), baseURL: URL(string: APPURL.interviewTest)!))
        self.employeeDictionary = Observable<Dictionary<String, [Employee]>>(["howdy":[]])
        getDirectoryList()
    }
    
    private func updateObservables(employees: [Employee]) {
        employeeDictionary.value = self.getEmployeeDictionary()
    }
    private func getDirectoryList() {
        directoryListService.getDirectoryList { [weak self] result in
        do {
          self?.employees = try result.unwrapped()
        } catch {
          print(error.localizedDescription)
        }
      }
    }
    
    private func getEmployeeDictionary() -> [String: [Employee]] {
        var employeeDictionary = [String: [Employee]]()
        
        for employee in employees! {
            let employeeKey = String(employee.firstName.prefix(1))
            if var employeeValues = employeeDictionary[employeeKey] {
                employeeValues.append(employee)
                employeeDictionary[employeeKey] = employeeValues
            } else {
                employeeDictionary[employeeKey] = [employee]
            }
        }
        return employeeDictionary
    }
}
