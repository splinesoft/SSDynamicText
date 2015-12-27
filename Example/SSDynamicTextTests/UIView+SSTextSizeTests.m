//
//  UIView+SSTextSizeTests.m
//  SSDynamicTextExample
//
//  Created by Adam Grzegorowski on 01/12/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SSTestsHelper.h"

#import "UIView+SSTextSize.h"
#import "SSDynamicLabel.h"

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
    XCTAssertEqualWithAccuracy(baseSize, 16, FLT_EPSILON, @"Default base size should be 16");

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

    //Clean Up
    [SSTestsHelper stopMockingBundleDictionary];
}

- (void)testDefaultFontNameShouldBeEqualToSystemFontIfInfoBundleNotSet {
    //Arrange
    NSString *expectedFontName = [UIFont systemFontOfSize:SSTestFontSize].fontName;
    [SSTestsHelper startMockingBundleDictionary:nil];

    //Act
    NSString *fontName = [self.label ss_defaultFontName];

    //Assert
    XCTAssertEqualObjects(fontName, expectedFontName, @"Default base name should be %@", expectedFontName);

    //Clean Up
    [SSTestsHelper stopMockingBundleDictionary];
}

- (void)testSetupDefaultFontDescriptiorBasedOnFontShouldBeEqualToInitialFontDescriptor {
    //Arrange
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:SSTestFontName size:SSTestFontSize];
    SSDynamicLabel *label = [SSDynamicLabel labelWithFontDescriptor:fontDescriptor];

    //Act
    [label setupDefaultFontDescriptorBasedOnFont:[UIFont fontWithDescriptor:fontDescriptor size:SSTestFontSize]];

    //Assert
    XCTAssertEqualObjects(label.defaultFontDescriptor, fontDescriptor,
                          @"Default font descriptor should have font %@ with size %f" , fontDescriptor.postscriptName, fontDescriptor.pointSize);
}

- (void)testSetupDefaultFontDescriptiorBasedOnNilFontShouldSetFontDescriptorWithDefaultValues {
    //Arrange
    UIView *testView = [[UIView alloc] init];
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:[testView ss_defaultFontName] size:[testView ss_defaultBaseSize]];

    //Act
    [testView setupDefaultFontDescriptorBasedOnFont:nil];

    //Assert
    XCTAssertEqualObjects(testView.defaultFontDescriptor, fontDescriptor,
                          @"Default font descriptor should have font %@ with size 16" , [UIFont systemFontOfSize:16.0].fontName);
}

@end
