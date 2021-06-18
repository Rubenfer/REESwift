import XCTest
import Combine
@testable import REESwift

final class REESwiftTests: XCTestCase {
    
    let ree = REESwift()
    
    // MARK: - Test consumer prices
    
    func testConsumerPricesCombine() {
        
        let now = Date()
        
        var cancellables = Set<AnyCancellable>()
        
        let todayExpectation = XCTestExpectation(description: "download today consumer prices")
        ree.consumerPrices(date: now, geo: .peninsula)
            .replaceError(with: [])
            .sink(receiveCompletion: { completion in
                todayExpectation.fulfill()
            }, receiveValue: { prices in
                XCTAssert(prices.count == 24)
            })
            .store(in: &cancellables)
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let yesterdayExpectation = XCTestExpectation(description: "download yesterday consumer prices")
        ree.consumerPrices(startDate: yesterday.start, endDate: now.end, geo: .peninsula)
            .replaceError(with: [])
            .sink(receiveCompletion: { completion in
                yesterdayExpectation.fulfill()
            }, receiveValue: { prices in
                XCTAssert(prices.count == 48)
            })
            .store(in: &cancellables)
        
        let futureDate = Calendar.current.date(byAdding: .month, value: 1, to: now)!
        let futureExpectation = XCTestExpectation(description: "download future consumer prices")
        ree.consumerPrices(date: futureDate, geo: .peninsula)
            .replaceError(with: [])
            .sink(receiveCompletion: { completion in
                futureExpectation.fulfill()
            }, receiveValue: { prices in
                XCTAssert(prices.isEmpty)
            })
            .store(in: &cancellables)

        wait(for: [todayExpectation, yesterdayExpectation, futureExpectation], timeout: 15.0)
        
    }
    
    func testConsumerPrices() {
        
        let now = Date()
        
        let todayExpectation = XCTestExpectation(description: "download today consumer prices")
        ree.consumerPrices(date: now, geo: .peninsula) { result in
            let prices = try? result.get()
            XCTAssertNotNil(prices)
            XCTAssert(prices?.count == 24)
            todayExpectation.fulfill()
        }
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let yesterdayExpectation = XCTestExpectation(description: "download yesterday consumer prices")
        ree.consumerPrices(startDate: yesterday.start, endDate: now.end, geo: .peninsula) { result in
            let prices = try? result.get()
            XCTAssertNotNil(prices)
            XCTAssert(prices?.count == 48)
            yesterdayExpectation.fulfill()
        }
        
        let futureDate = Calendar.current.date(byAdding: .month, value: 1, to: now)!
        let futureExpectation = XCTestExpectation(description: "download future consumer prices")
        ree.consumerPrices(date: futureDate, geo: .peninsula) { result in
            let prices = try? result.get()
            XCTAssertNil(prices)
            futureExpectation.fulfill()
        }

        wait(for: [todayExpectation, yesterdayExpectation, futureExpectation], timeout: 15.0)
        
    }
    
    // MARK: - Test spot prices
    
    func testSpotPricesCombine() {
        
        let now = Date()
        
        var cancellables = Set<AnyCancellable>()
        
        let todayExpectation = XCTestExpectation(description: "download today consumer prices")
        ree.spotPrices(date: now)
            .replaceError(with: [])
            .sink(receiveCompletion: { completion in
                todayExpectation.fulfill()
            }, receiveValue: { prices in
                XCTAssert(prices.count == 24)
            })
            .store(in: &cancellables)
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let yesterdayExpectation = XCTestExpectation(description: "download yesterday consumer prices")
        ree.spotPrices(startDate: yesterday.start, endDate: now.end)
            .replaceError(with: [])
            .sink(receiveCompletion: { completion in
                yesterdayExpectation.fulfill()
            }, receiveValue: { prices in
                XCTAssert(prices.count == 48)
            })
            .store(in: &cancellables)
        
        let futureDate = Calendar.current.date(byAdding: .month, value: 1, to: now)!
        let futureExpectation = XCTestExpectation(description: "download future consumer prices")
        ree.spotPrices(date: futureDate)
            .replaceError(with: [])
            .sink(receiveCompletion: { completion in
                futureExpectation.fulfill()
            }, receiveValue: { prices in
                XCTAssert(prices.isEmpty)
            })
            .store(in: &cancellables)

        wait(for: [todayExpectation, yesterdayExpectation, futureExpectation], timeout: 15.0)
        
    }
    
    func testSpotPrices() {
        
        let now = Date()
        
        let todayExpectation = XCTestExpectation(description: "download today consumer prices")
        ree.spotPrices(date: now) { result in
            let prices = try? result.get()
            XCTAssertNotNil(prices)
            XCTAssert(prices?.count == 24)
            todayExpectation.fulfill()
        }
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let yesterdayExpectation = XCTestExpectation(description: "download yesterday consumer prices")
        ree.spotPrices(startDate: yesterday.start, endDate: now.end) { result in
            let prices = try? result.get()
            XCTAssertNotNil(prices)
            XCTAssert(prices?.count == 48)
            yesterdayExpectation.fulfill()
        }
        
        let futureDate = Calendar.current.date(byAdding: .month, value: 1, to: now)!
        let futureExpectation = XCTestExpectation(description: "download future consumer prices")
        ree.spotPrices(date: futureDate) { result in
            let prices = try? result.get()
            XCTAssertNil(prices)
            futureExpectation.fulfill()
        }

        wait(for: [todayExpectation, yesterdayExpectation, futureExpectation], timeout: 15.0)
        
    }
    
}
