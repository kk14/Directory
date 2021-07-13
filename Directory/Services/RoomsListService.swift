//
//  RoomsListService.swift
//  Directory
//
//  Created by Kanishk Kumar on 13/07/2021.
//

import Foundation

protocol RoomsListService {
    func getRoomList(completion: @escaping (Result<[Room], Error>) -> Void)
}

class RoomsListServiceImplementation: RoomsListService {
    private let api: API

    init(api: API) {
        self.api = api
    }

    func getRoomList(completion: @escaping (Result<[Room], Error>) -> Void) {
        let resource = Resource<[Room]>(path: "/api/v1/rooms")
        api.load(resource, completion: completion)
    }
}
