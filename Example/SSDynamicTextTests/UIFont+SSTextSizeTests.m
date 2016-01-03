//
//  UIFont+SSTextSizeTests.m
//  SSDynamicTextExample
//
//  Created by Adam Grzegorowski on 30/11/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "UIFont+SSTextSize.h"
#import "UIApplication+SSTextSize.h"
#import "SSTestsHelper.h"

@interface UIFont_SSTextSizeTests : XCTestCase

@end

@implementation UIFont_SSTextSizeTests

- (void)testDynamicFontWithNameBaseSizeShouldReturnFontWithSizeIncreasedOfPreferredFontSizeDelta {

    //Arrange
    NSArray<NSString *> *contentSizeCategories = @[
        UIContentSizeCategoryExtraSmall,
        UIContentSizeCategorySmall,
        UIContentSizeCategoryMedium,
        UIContentSizeCategoryLarge,
        UIContentSizeCategoryExtraLarge,
        UIContentSizeCategoryExtraExtraLarge,
        UIContentSizeCategoryExtraExtraExtraLarge,
        UIContentSizeCategoryAccessibilityMedium,
        UIContentSizeCategoryAccessibilityLarge,
        UIContentSizeCategoryAccessibilityExtraLarge,
        UIContentSizeCategoryAccessibilityExtraExtraLarge,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge,
    ];

    for (NSString *contentSizeCategory in contentSizeCategories) {

        [SSTestsHelper startMockingPreferredContentSizeCategory:contentSizeCategory];
        NSInteger preferredFontSizeDelta = [UIApplication sharedApplication].preferredFontSizeDelta;

        //Act
        UIFont *font = [UIFont dynamicFontWithName:SSTestFontName baseSize:SSTestFontSize];

        //Assert
        XCTAssertEqualWithAccuracy(font.pointSize, SSTestFontSize + preferredFontSizeDelta, FLT_EPSILON);

        //Clean Up
        [SSTestsHelper stopMockingPreferredContentSizeCategory];
    }
}

@end
