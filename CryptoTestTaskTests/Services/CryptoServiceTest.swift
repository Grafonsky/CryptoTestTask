//
//  CryptoService.swift
//  CryptoTestTaskTests
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import XCTest
@testable import CryptoTestTask
import CoreLocation

class CryptoServiceTest: XCTestCase {
    
    let service = CryptoServiceImp()
    
    func testGetCryptoList() {
        //arrange
        let exp = expectation(description: "\(#function)\(#line)")
        
        //act
        service.getCryptoList { jsonData in
            exp.fulfill()
        }
        
        //assert
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testGetCryptoDetails() {
        //arrange
        let exp = expectation(description: "\(#function)\(#line)")
        
        //act
        service.getCryptoDetails(id: "bitcoin") { jsonData in
            exp.fulfill()
        }
        
        //assert
        waitForExpectations(timeout: 10, handler: nil)
    }
}
