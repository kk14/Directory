//
//  ResourceTests.swift
//  Directory
//
//  Created by Kanishk Kumar on 05/07/2021.
//

import XCTest
@testable import Directory

class ResourceTests: XCTestCase {

  func test_initWithPath_handlesParsingDecodableModels() {
    let resourceSUT = Resource<TestModel>(path: "")
    let result = resourceSUT.parse(TestModel.data)
    guard let model = try? result.unwrapped() else {
      XCTFail("Bad JSON")
      return
    }
    XCTAssertEqual(model, TestModel.model)
  }
}
