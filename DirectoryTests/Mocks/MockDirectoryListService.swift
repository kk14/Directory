//
//  MockDirectoryListService.swift
//  Directory
//
//  Created by Kanishk Kumar on 05/07/2021.
//

import Foundation
@testable import Directory

class MockDirectoryListService: DirectoryListService {
    
    private(set) var lastCompletion: ((Result<[Employee], Error>) -> Void)? = nil
    var callCount = 0

    func getDirectoryList(completion: @escaping (Result<[Employee], Error>) -> Void) {
        lastCompletion = completion
        callCount += 1
    }
}
