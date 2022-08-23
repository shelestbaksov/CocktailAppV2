import XCTest
@testable import CocktailAppV2

class NetworkManagerTests: XCTestCase {

    func test_NetworkManager_returnsExpectedResults_onAGivenSearchTerm() throws {
        let expectation = expectation(description: "waiting for NetworkManager response...")
        let managerToTest = NetworkManager()
        managerToTest.searchDrinkRecepies(searchTerm: "vodka") { result in
            expectation.fulfill()
            switch result {
            case let .success(drinks):
                guard let firstDrink = drinks.first else {
                    XCTAssertTrue(false, "empty drinks list")
                    return
                }
                XCTAssert(firstDrink.name.lowercased().contains("vodka"))
            case .failure(_):
                XCTAssertTrue(false, "got an error while searching for term 'vodka'")
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_NetworkManager_returnsEmptyResults_onShittySearchTerm() throws {
        let expectation = expectation(description: "waiting for NetworkManager response...")
        let managerToTest = NetworkManager()
        managerToTest.searchDrinkRecepies(searchTerm: "slkjflasdkfjlaskjfalskdjfalskdfj") { result in
            expectation.fulfill()
            switch result {
            case let .success(drinks):
                XCTAssertTrue(drinks.isEmpty, "drinks list is not empty on shitty search term")
            case let .failure(error):
                break
            }
        }
        wait(for: [expectation], timeout: 5)
    }
}
