//
//  DirectoryListService.swift
//  Directory
//
//  Created by Kanishk Kumar on 12/07/2021.
//

import Foundation

protocol DirectoryListService {
    func getDirectoryList(completion: @escaping (Result<[Employee], Error>) -> Void)
}

class DirectoryListServiceImplementation: DirectoryListService {
    private let api: API

    init(api: API) {
        self.api = api
    }

    func getDirectoryList(completion: @escaping (Result<[Employee], Error>) -> Void) {
        let resource = Resource<[Employee]>(path: "/api/v1/people")
        api.load(resource, completion: completion)
    }
}
