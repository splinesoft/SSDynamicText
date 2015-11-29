//
//  UIView+SSTextSizeTests.m
//  SSDynamicTextExample
//
//  Created by Adam Grzegorowski on 01/12/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import "UIView+SSTextSize.h"
#import "SSDynamicLabel.h"
#import "SSTestsHelper.h"

#import <XCTest/XCTest.h>

@interface UIView_SSTextSizeTests : XCTestCase

@property (nonatomic, strong) SSDynamicLabel *label;

@end

@implementation UIView_SSTextSizeTests


- (void)setUp {
    [super setUp];

    self.label = [SSDynamicLabel labelWithFont:SSTestFontName baseSize:SSTestFontSize];
}

- (void)testDefaultBaseSizeShouldBeEqualToInfoBundleIfSet {
    //Arrange
    CGFloat expectedBaseSize = 123;
    NSDictionary *baseSizeDictionary = [NSDictionary dictionaryWithObject:@(expectedBaseSize) forKey:kSSDynamicDefaultBaseSize];
    [SSTestsHelper startMockingBundleDictionary:baseSizeDictionary];

    //Act
    CGFloat baseSize = [self.label ss_defaultBaseSize];

    //Assert
    XCTAssertEqualWithAccuracy(expectedBaseSize, baseSize, FLT_EPSILON, @"Default base size should be %f", expectedBaseSize);

    //Clean Up
    [SSTestsHelper stopMockingBundleDictionary];
}

- (void)testDefaultBaseSizeShouldBeEqualTo16IfInfoBundleNotSet {
    //Arrange
    [SSTestsHelper startMockingBundleDictionary:nil];

    //Act
    CGFloat baseSize = [self.label ss_defaultBaseSize];

    //Assert
    XCTAssertEqualWithAccuracy(16, baseSize, FLT_EPSILON, @"Default base size should be 16");

    //Clean Up
    [SSTestsHelper stopMockingBundleDictionary];
}

- (void)testDefaultFontNameShouldBeEqualToInfoBundleIfSet {
    // Arrange
    NSString *expectedfontName = SSTestFontName;
    NSDictionary *fontNameDictionary = [NSDictionary dictionaryWithObject:expectedfontName forKey:kSSDynamicDefaultFontName];
    [SSTestsHelper startMockingBundleDictionary:fontNameDictionary];

    NSString *fontName = [self.label ss_defaultFontName];

    //Assert
    XCTAssertEqualObjects(fontName, expectedfontName, @"Default base name should be %@", expectedfontName);

    // Clean Up
    [SSTestsHelper stopMockingBundleDictionary];
}

- (void)testDefaultFontNameShouldBeEqualToSystemFontIfInfoBundleNotSet {
    // Arrange
    NSString *expectedFontName = [UIFont systemFontOfSize:SSTestFontSize].fontName;
    [SSTestsHelper startMockingBundleDictionary:nil];

    //Act
    NSString *fontName = [self.label ss_defaultFontName];

    //Assert
    XCTAssertEqualObjects(fontName, expectedFontName, @"Default base name should be %@", expectedFontName);

    // Clean Up
    [SSTestsHelper stopMockingBundleDictionary];
}

@end
