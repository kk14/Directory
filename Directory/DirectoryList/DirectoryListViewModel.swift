//
//  DirectoryListViewModel.swift
//  Directory
//
//  Created by Kanishk Kumar on 05/07/2021.
//

import Foundation

class DirectoryListViewModel {
    
    var employees = [Employee]()
    
    var employeeDictionary: [String: [Employee]] {
        get {
            var employeeDictionary = [String: [Employee]]()
            for employee in employees {
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
    
    //Convenience init
    func initWithLocalData() -> DirectoryListViewModel {
        let directoryListViewModel = DirectoryListViewModel()
        let employees = self.loadLocalJson() ?? [Employee]()
        self.employees = employees
        return directoryListViewModel
    }
    
    private func loadLocalJson() -> [Employee]? {
        if let url = Bundle.main.url(forResource: "PeopleResponse", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let employees = try decoder.decode(Employees.self, from: data)
                return employees
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
