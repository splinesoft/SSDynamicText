//
//  SSDynamicTextTests.m
//  SSDynamicTextTests
//
//  Created by Jonathan Hersh on 10/23/14.
//  Copyright (c) 2014 Splinesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <SSDynamicText.h>
#import "SSTestsHelper.h"

@interface SSDynamicTextTests : XCTestCase

@end

@implementation SSDynamicTextTests {
    SSDynamicLabel *label;
}

- (void)setUp {
    [super setUp];
    
    label = [SSDynamicLabel labelWithFont:SSTestFontName baseSize:SSTestFontSize];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitializable {
    //Assert
    XCTAssertNotNil([SSDynamicLabel labelWithFont:SSTestFontName baseSize:SSTestFontSize], @"Label should initialize");
    XCTAssertNotNil([SSDynamicTextField textFieldWithFont:SSTestFontName baseSize:SSTestFontSize], @"Text field should initialize");
    XCTAssertNotNil([SSDynamicTextView textViewWithFont:SSTestFontName baseSize:SSTestFontSize], @"Text view should initialize");
    XCTAssertNotNil([SSDynamicButton buttonWithFont:SSTestFontName baseSize:SSTestFontSize], @"Button should initialize");
}

- (void)testApplicationFontSizeDelta {
    //Assert
    // This will probably fail if you've set a custom preferred font size in the simulator, please change it to UIContentSizeCategoryExtraLarge
    XCTAssertEqual(0, [[UIApplication sharedApplication] preferredFontSizeDelta], @"Font size delta should be zero");
}

- (void)testInfoBundleDefaultFontSize {
    //Assert
    XCTAssertEqualWithAccuracy(16, [label ss_defaultBaseSize], FLT_EPSILON, @"Default base size should be 16");
}

@end
