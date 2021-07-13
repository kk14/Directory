//
//  HTTPError.swift
//  Directory
//
//  Created by Kanishk Kumar on 08/07/2021.
//

import Foundation

enum HTTPError: Error {
    case noResponse
    case requestError(Error)
    case invalidResponse(URLResponse)
    case unsuccessful(statusCode: Int, urlResponse: HTTPURLResponse, error: Error?)

    var localizedDescription: String {
        switch self {
        case .noResponse:
            return "No Response"
        case let .requestError(error):
            return "Request Error: \(error)"
        case let .invalidResponse(response):
            return "Invalid response. Expected HTTPURLResponse got \(type(of: response))"
        case let .unsuccessful(statusCode, _, _):
            return "Unsuccessful. Status code: \(statusCode)"
        }
    }
}
