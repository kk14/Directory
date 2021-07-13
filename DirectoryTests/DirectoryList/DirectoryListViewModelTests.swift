//
//  DirectoryListViewModelTests.swift
//  DirectoryTests
//
//  Created by Kanishk Kumar on 13/07/2021.
//

import XCTest
@testable import Directory

class DirectoryListViewModelTests: XCTestCase {

    var employeeDictionary:[String:[Employee]] = [:]
    
    var directoryList:[Employee]!

    override func setUpWithError() throws {
        self.directoryList = self.loadLocalJson()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func test_init_startsFetchingProductDetails() {
        let mockdirectoryListService = MockDirectoryListService()
        _ = DirectoryListViewModel(directoryListService: mockdirectoryListService)
        XCTAssertEqual(mockdirectoryListService.callCount, 1)
    }

    
    func test_directoryDetailsIsupdated_whenDirectoryListIsSuccessfullyFetched() {
      let mockdirectoryListService = MockDirectoryListService()

        let directoryListViewModelSUT = DirectoryListViewModel(directoryListService: mockdirectoryListService)

      let actionExpectation = expectation(description: "updated")
        directoryListViewModelSUT.employeeDictionary.bindNoFire(self) { employeeDictionary in
            XCTAssertEqual(mockdirectoryListService.callCount, 1)
            actionExpectation.fulfill()
      }
        mockdirectoryListService.lastCompletion?(.value(directoryList))
        wait(for: [actionExpectation], timeout: 0.5)
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
