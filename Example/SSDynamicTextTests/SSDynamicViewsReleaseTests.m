//
//  SSDynamicViewReleaseTests.m
//  SSDynamicTextExample
//
//  Created by Adam Grzegorowski on 06/12/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SSTestsHelper.h"
#import "SSDynamicText.h"

@interface SSDynamicViewsReleaseTests : XCTestCase
@end

@implementation SSDynamicViewsReleaseTests

- (void)testDynamicLabelShouldBeReleaseable {
    // Arrange
    __weak SSDynamicLabel *label = nil;

    // Act
    @autoreleasepool {
        label = [[SSDynamicLabel alloc] init];
        label.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:SSTestFontName size:SSTestFontSize];
    }

    // Assert
    XCTAssertNil(label);
}


- (void)testDynamicButtonShouldShouldBeReleaseable {
    // Arrange
    __weak SSDynamicButton *button = nil;

    // Act
    @autoreleasepool {
        button = [[SSDynamicButton alloc] init];
        button.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:SSTestFontName size:SSTestFontSize];
    }

    // Assert
    XCTAssertNil(button);
}

- (void)testDynamicTextViewShouldShouldBeReleaseable {
    // Arrange
    __weak SSDynamicTextView *textView = nil;

    @autoreleasepool {
        // Act
        textView = [[SSDynamicTextView alloc] init];
        textView.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:SSTestFontName size:SSTestFontSize];
    }

    // Assert
    XCTAssertNil(textView);
}

- (void)testDynamicTextFieldShouldBeReleaseable {
    // Arrange
    __weak SSDynamicTextField *textField = nil;

    @autoreleasepool {
        // Act
        textField = [[SSDynamicTextField alloc] init];
        textField.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:SSTestFontName size:SSTestFontSize];
    }

    // Assert
    XCTAssertNil(textField);
}

@end
