//
//  UIApplication+SSTextSizeTests.m
//  SSDynamicTextExample
//
//  Created by Adam Grzegorowski on 01/12/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import "UIApplication+SSTextSize.h"
#import "SSTestsHelper.h"

#import <XCTest/XCTest.h>

@interface UIApplication_SSTextSizeTests : XCTestCase

@end

@implementation UIApplication_SSTextSizeTests

- (void)testPreferredFontSizeDeltaForKnownContentSizeCategories {
    //Arrange
    NSDictionary *contentSizeCategoriesWithDeltas = @{
        UIContentSizeCategoryExtraSmall :                        @(-3),
        UIContentSizeCategorySmall :                             @(-2),
        UIContentSizeCategoryMedium :                            @(-1),
        UIContentSizeCategoryLarge :                             @0,
        UIContentSizeCategoryExtraLarge :                        @1,
        UIContentSizeCategoryExtraExtraLarge :                   @2,
        UIContentSizeCategoryExtraExtraExtraLarge :              @3,
        UIContentSizeCategoryAccessibilityMedium :               @4,
        UIContentSizeCategoryAccessibilityLarge :                @5,
        UIContentSizeCategoryAccessibilityExtraLarge :           @6,
        UIContentSizeCategoryAccessibilityExtraExtraLarge :      @7,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @8,
    };

    [contentSizeCategoriesWithDeltas enumerateKeysAndObjectsUsingBlock:^(NSString *contentSizeCategory, NSNumber *contentSizeDelta, BOOL *stop) {

        [SSTestsHelper startMockingPreferredContentSizeCategory:contentSizeCategory];

        //Act
        NSInteger preferredFontSizeDelta = [UIApplication sharedApplication].preferredFontSizeDelta;

        //Assert
        XCTAssertEqual(preferredFontSizeDelta, contentSizeDelta.integerValue, @"Font size delta should be zero");

        //Clean Up
        [SSTestsHelper stopMockingPreferredContentSizeCategory];
    }];
}

// In next versions of iOS might be provided new size category. For such cases use default delta size, which is zero.
- (void)testPreferredFontSizeDeltaShouldBeEqualToZeroForUnknownContentSizeCategory {
    //Arrange
    [SSTestsHelper startMockingPreferredContentSizeCategory:@"NewContentSizeCategory"];

    //Act
    NSInteger preferredFontSizeDelta = [UIApplication sharedApplication].preferredFontSizeDelta;

    //Assert
    XCTAssertEqual(preferredFontSizeDelta, 0, @"Font size delta should be zero, for uknown content size category");

    //Clean Up
    [SSTestsHelper stopMockingPreferredContentSizeCategory];
}

@end
