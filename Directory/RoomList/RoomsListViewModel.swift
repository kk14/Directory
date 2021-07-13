//
//  RoomsListViewModal.swift
//  Directory
//
//  Created by Kanishk Kumar on 06/07/2021.
//

import Foundation

class RoomsListViewModel {
    private let roomsListService: RoomsListService

    let roomsDictionary: Observable<Dictionary<String, [Room]>>

    var rooms: [Room]? {
        didSet {
            guard let value = rooms else {
                return
            }
            updateObservables(rooms: value)
        }
    }

    init(roomsListService: RoomsListService?) {
        self.roomsListService = roomsListService ?? RoomsListServiceImplementation(api: API(urlSession: URLSession(configuration: URLSessionConfiguration.default), baseURL: URL(string: APPURL.interviewTest)!))
        roomsDictionary = Observable<Dictionary<String, [Room]>>(["": []])
        getRoomList()
    }

    private func updateObservables(rooms: [Room]) {
        roomsDictionary.value = getRoomsDictionary()
    }

    private func getRoomList() {
        roomsListService.getRoomList { [weak self] result in
            do {
                self?.rooms = try result.unwrapped()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func getRoomsDictionary() -> [String: [Room]] {
        var roomDictionary = [String: [Room]]()
        for room in rooms! {
            let roomKey = String(room.name.prefix(1))
            if var roomValues = roomDictionary[roomKey] {
                roomValues.append(room)
                roomDictionary[roomKey] = roomValues
            } else {
                roomDictionary[roomKey] = [room]
            }
        }
        return roomDictionary
    }
}
