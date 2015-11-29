//
//  SSDynamicTextTests.m
//  SSDynamicTextTests
//
//  Created by Jonathan Hersh on 10/23/14.
//  Copyright (c) 2014 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SSDynamicText.h>
#import "SSTestsHelper.h"

@interface SSDynamicTextTests : XCTestCase

@end

@implementation SSDynamicTextTests

- (void)testInitializable {
    //Assert
    XCTAssertNotNil([SSDynamicLabel labelWithFont:SSTestFontName baseSize:SSTestFontSize], @"Label should initialize");
    XCTAssertNotNil([SSDynamicTextField textFieldWithFont:SSTestFontName baseSize:SSTestFontSize], @"Text field should initialize");
    XCTAssertNotNil([SSDynamicTextView textViewWithFont:SSTestFontName baseSize:SSTestFontSize], @"Text view should initialize");
    XCTAssertNotNil([SSDynamicButton buttonWithFont:SSTestFontName baseSize:SSTestFontSize], @"Button should initialize");
}

@end
