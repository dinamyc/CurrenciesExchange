//
//  CurrencyServiceTests.swift
//  CitiCodeChallenge
//
//  Created by JL on 24/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class ContentViewTests: XCTestCase {
    
    func testContentViewInitialization() {
        let contentView = ContentView()
            .navigationViewStyle(StackNavigationViewStyle())
        XCTAssertNotNil(contentView)
    }
}

class EmptyStateViewTests: XCTestCase {
    
    func testEmptyStateView() {
        // Given
        let contentView = Text("Hello, world!")
        let emptyStateView = EmptyStateView(onReload: {}, content: contentView)
        
        // When
        let result = emptyStateView.body
        
        // Then
        XCTAssertNotNil(result)
    }
}
