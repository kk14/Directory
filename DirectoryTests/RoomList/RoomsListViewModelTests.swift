//
//  RoomsListViewModelTests.swift
//  DirectoryTests
//
//  Created by Kanishk Kumar on 13/07/2021.
//

@testable import Directory
import XCTest

class RoomsListViewModelTests: XCTestCase {
    var roomsDictionary: [String: [Room]] = [:]

    var roomsList: [Room]!

    override func setUpWithError() throws {
        roomsList = loadLocalJson()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func test_init_startsFetchingProductDetails() {
        let mockRoomListService = MockRoomListService()
        _ = RoomsListViewModel(roomsListService: mockRoomListService)
        XCTAssertEqual(mockRoomListService.callCount, 1)
    }

    func test_roomDetailsIsupdated_whenRoomListIsSuccessfullyFetched() {
        let mockRoomListService = MockRoomListService()

        let roomsListViewModelSUT = RoomsListViewModel(roomsListService: mockRoomListService)

        let actionExpectation = expectation(description: "updated")
        roomsListViewModelSUT.roomsDictionary.bindNoFire(self) { _ in
            XCTAssertEqual(mockRoomListService.callCount, 1)
            actionExpectation.fulfill()
        }
        mockRoomListService.lastCompletion?(.value(roomsList))
        wait(for: [actionExpectation], timeout: 0.5)
    }

    private func loadLocalJson() -> [Room]? {
        if let url = Bundle.main.url(forResource: "RoomsResponse", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let rooms = try decoder.decode(Rooms.self, from: data)
                return rooms
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
