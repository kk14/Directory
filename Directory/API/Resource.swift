//
//  Resource.swift
//  Directory
//
//  Created by Kanishk Kumar on 08/07/2021.
//

import Foundation

struct Resource<A> {
    let path: String
    let body: Data?
    let method: String
    let parse: (Data) -> Result<A, Error>
}

extension Resource where A: Decodable {
    init(path: String) {
        self.path = path
        method = "GET"
        body = nil
        parse = { data in
            do {
                let decoder = JSONDecoder()
                return .value(try decoder.decode(A.self, from: data))
            } catch {
                return .error(error)
            }
        }
    }
}
