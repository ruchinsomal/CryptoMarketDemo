//
//  ViewControllerTest.swift
//  CryptoMarketDemoTests
//
//  Created by Ruchin Somal on 2021-06-19.
//

import XCTest
@testable import CryptoMarketDemo

class ViewControllerTest: XCTestCase {
    var listVC: ViewController!
    
    override func setUp() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        listVC = storyBoard.instantiateViewController(identifier: "ViewController") as! ViewController
        listVC.loadView()
        listVC.viewDidLoad()
        listVC.viewWillAppear(false)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHasATableView() {
        XCTAssertNotNil(listVC.tblList)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(listVC.tblList.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(listVC.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(listVC.tblList.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(listVC.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.numberOfSections(in:))))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:cellForRowAt:))))
    }
    
    
    func testMarketAPI() {
        let promise = expectation(description: "Status code: 200")
        ViewModel().fetchData { status, error in
            if status {
                XCTAssert(status, "API success")
                promise.fulfill()
            } else {
                XCTFail("Status code: \(500) Message: \(error?.localizedDescription ?? "")")
            }
        }
        wait(for: [promise], timeout: 180)
    }
    
    override func tearDown() {
        super.tearDown()
        listVC = nil
    }
    
}
