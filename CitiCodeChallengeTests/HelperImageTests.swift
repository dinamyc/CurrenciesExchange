//
//  HelperImageTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class HelperImageTests: XCTestCase {
    
    func testAsyncImageViewWithValidURL() {
        // Given
        let url = URL(string: "https://flagsapi.com/US/flat/64.png")
        let helperImage = HelperImage()
        
        // When
        let asyncImage = helperImage.asyncImageView(with: url)
        
        // Then
        XCTAssertNotNil(asyncImage)
    }
    
    func testAsyncImageViewWithNilURL() {
        // Given
        let url: URL? = nil
        let helperImage = HelperImage()
        
        // When
        let asyncImage = helperImage.asyncImageView(with: url)
        
        // Then
        XCTAssertNotNil(asyncImage)
    }
    
    func testAsyncImageViewWithInvalidURL() {
        // Given
        let url = URL(string: "invalid_url")
        let helperImage = HelperImage()
        
        // When
        let asyncImage = helperImage.asyncImageView(with: url)
        
        // Then
        XCTAssertNotNil(asyncImage)
    }
}

