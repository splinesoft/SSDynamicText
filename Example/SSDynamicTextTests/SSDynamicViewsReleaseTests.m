//
//  SSDynamicViewReleaseTests.m
//  SSDynamicTextExample
//
//  Created by Adam Grzegorowski on 06/12/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SSDynamicText.h"
#import "SSTestsHelper.h"

/**
 * Class provided to test unregistering of `UIContentSizeCategoryDidChangeNotification` notification.
 * File has disabled ARC via `-fno-objc-arc` compiler flag in compile sources.
 * Please DO NOT add more tests in this file.
 */

@interface SSDynamicViewsReleaseTests : XCTestCase

@end

@implementation SSDynamicViewsReleaseTests

- (void)testDynamicLabelShouldNotObserveTextSizeChangesAfterRelease {

    // Arrange
    @autoreleasepool {
        SSDynamicLabel *label = [SSDynamicLabel labelWithFont:SSTestFontName baseSize:SSTestFontSize];
        [label release];
    }

    // Act & Assert
    XCTAssertNoThrow([SSTestsHelper postContentSizeChangeNotification]);
}

/**
 //TODO: Test for dynamic button release hangs. Will be enabled again after research and fix.
- (void)testDynamicButtonShouldNotObserveTextSizeChangesAfterRelease {

    // Arrange
    @autoreleasepool {
        SSDynamicButton *button = [SSDynamicButton buttonWithFont:SSTestFontName baseSize:SSTestFontSize];
        [button release];
    }

    // Act & Assert
    XCTAssertNoThrow([SSTestsHelper postContentSizeChangeNotification]);
}
 */

- (void)testDynamicTextViewShouldNotObserveTextSizeChangesAfterRelease {

    // Arrange
    @autoreleasepool {
        SSDynamicTextView *textView = [SSDynamicTextView textViewWithFont:SSTestFontName baseSize:SSTestFontSize];
        [textView release];
    }

    // Act & Assert
    XCTAssertNoThrow([SSTestsHelper postContentSizeChangeNotification]);
}

- (void)testDynamicTextFieldShouldNotObserveTextSizeChangesAfterRelease {

    // Arrange
    @autoreleasepool {
        SSDynamicTextField *textField = [SSDynamicTextField textFieldWithFont:SSTestFontName baseSize:SSTestFontSize];
        [textField release];
    }

    // Act & Assert
    XCTAssertNoThrow([SSTestsHelper postContentSizeChangeNotification]);
}

@end
