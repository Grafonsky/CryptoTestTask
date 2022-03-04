//
//  StorageService.swift
//  CryptoTestTaskTests
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import XCTest
@testable import CryptoTestTask

class StorageServiceTest: XCTestCase {
    
    let service = StorageServiceImp()
    
    func testUserDefaults() {
        //arrange
        let key = "TestKey"
        let model: DetailedModel = DetailedModel.init(
            symbol: "TestSymbol",
            name: "TestName",
            image: nil,
            genesis_date: nil,
            market_data: nil)
        
        //act
        let encoder = JSONEncoder()
        let dataToSave = try? encoder.encode(model)
        service.setData(key: key, value: dataToSave)
        
        let decoder = JSONDecoder()
        let dataToLoad = service.getData(key: key)
        guard let entity = try? decoder.decode(DetailedModel.self, from: dataToLoad) else { return }
        
        //assert
        XCTAssertEqual(entity.name, model.name)
        XCTAssertEqual(entity.symbol, model.symbol)
        XCTAssertNil(entity.image)
    }
}
