//
//  Sepia_Pets_appTests.swift
//  Sepia Pets appTests
//
//  Created by Al-Amin on 30/11/22.
//

import XCTest
@testable import Sepia_Pets_app

class Sepia_Pets_appTests: XCTestCase {

    let sut = NetworkManager()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testUndefinedFile() {
        XCTAssertNil(sut.loadPetInfoFromJson(filename: "no name"))
    }
    
    func testDefinedFile() {
        XCTAssertNotNil(sut.loadPetInfoFromJson(filename: "pets_list"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
