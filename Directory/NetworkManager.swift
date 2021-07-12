//
//  NetworkManager.swift
//  Directory
//
//  Created by Kanishk Kumar on 09/07/2021.
//

import Foundation

class NetworkManager {
    
    func fetchEmployees(completionHandler: @escaping ([Employee]) -> Void) {
        let url = URL(string: "https://5f7c2c8400bd74001690a583.mockapi.io/api/v1/" + "people")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching employees: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            return
          }

          if let data = data,
            let employees = try? JSONDecoder().decode(Employees.self, from: data) {
            completionHandler(employees )
          }
        })
        task.resume()
      }
    func fetchRooms(completionHandler: @escaping ([Room]) -> Void) {
        let url = URL(string: "https://5f7c2c8400bd74001690a583.mockapi.io/api/v1/" + "rooms")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching rooms: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            return
          }

          if let data = data,
            let rooms = try? JSONDecoder().decode(Rooms.self, from: data) {
            completionHandler(rooms )
          }
        })
        task.resume()
      }

    
}
