import Foundation
@testable import Directory

class MockRoomListService: RoomsListService {

    private(set) var lastCompletion: ((Result<[Room], Error>) -> Void)? = nil
    var callCount = 0

    func getRoomList(completion: @escaping (Result<[Room], Error>) -> Void) {
        lastCompletion = completion
        callCount += 1
    }
}

