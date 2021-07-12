//
//  RoomsListViewModal.swift
//  Directory
//
//  Created by Kanishk Kumar on 06/07/2021.
//

import Foundation

class RoomsListViewModal {
    
    var rooms = [Room]()
    
    var roomDictionary: [String: [Room]] {
        get {
            var roomDictionary = [String: [Room]]()
            for room in rooms {
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
    
    //Convenience init
    func initWithLocalData() -> RoomsListViewModal {
        let roomsListViewModal = RoomsListViewModal()
        let rooms = self.loadLocalJson() ?? [Room]()
        self.rooms = rooms
        return roomsListViewModal
    }
    
    private func loadLocalJson() -> [Room]? {
        if let url = Bundle.main.url(forResource: "RoomsResponse", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let employees = try decoder.decode(Rooms.self, from: data)
                return employees
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
