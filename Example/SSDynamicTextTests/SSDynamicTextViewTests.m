//
//  SSTextViewTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SSTestsHelper.h"
#import "SSAttributedStringValidator.h"

#import "SSDynamicTextView.h"
#import "SSDynamicsView.h"

@interface SSDynamicTextViewTests : XCTestCase
@end

@implementation SSDynamicTextViewTests

- (void)setUp {
    [super setUp];

    //Default content size category
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryLarge];
}

- (void)tearDown {
    [SSTestsHelper stopMockingPreferredContentSizeCategory];
    [super tearDown];
}

- (NSArray<SSDynamicsView *> *)dynamicTextViewsWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize {

    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:fontSize];

    SSDynamicTextView *dynamicTextView = [[SSDynamicTextView alloc] init];
    dynamicTextView.defaultFontDescriptor = fontDescriptor;

    SSDynamicTextView *dynamicTextViewWithFrame = [[SSDynamicTextView alloc] initWithFrame:CGRectZero];
    dynamicTextViewWithFrame.font = [UIFont fontWithName:fontName size:fontSize];

    SSDynamicTextView *dynamicTextViewWithFont = [SSDynamicTextView textViewWithFont:fontName baseSize:fontSize];

    SSDynamicTextView *dynamicTextViewWithFontDescriptor = [SSDynamicTextView textViewWithFontDescriptor:fontDescriptor];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    SSDynamicTextView *dynamicTextViewFromXib = view.textView;

    return @[ dynamicTextView, dynamicTextViewWithFrame, dynamicTextViewWithFont, dynamicTextViewWithFontDescriptor, dynamicTextViewFromXib ];
}

- (void)testTextViewFontNameShouldBeEqualToFontNameFromConstructor {
    //Arrange
    NSString *expectedFontName = SSTestFontName;

    //Act
    NSArray<SSDynamicTextView *> *dynamicTextViews = [self dynamicTextViewsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicTextView *textView in dynamicTextViews) {
        //Assert
        XCTAssertEqualObjects(textView.font.fontName, expectedFontName);
    }
}

- (void)testTextViewFontSizeShouldBeEqualToFontSizeInConstructorForDefaultPreferredContentSizeCategory {
    //Arrange
    CGFloat expectedFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicTextView *> *dynamicTextViews = [self dynamicTextViewsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicTextView *textView in dynamicTextViews) {
        //Assert
        XCTAssertEqualWithAccuracy(textView.font.pointSize, expectedFontSize, FLT_EPSILON);
    }
}

- (void)testTextViewFontSizeShouldBeEqualToLabelFontSizeIncreasedByPreferredContentSizeCategoryDelta {
    // Arrange
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    CGFloat initialFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicTextView *> *dynamicTextViews = [self dynamicTextViewsWithFontName:SSTestFontName fontSize:initialFontSize];

    for (SSDynamicTextView *textView in dynamicTextViews) {

        //Assert
        XCTAssertEqualWithAccuracy(textView.font.pointSize, initialFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testTextViewFontSizeShouldBeEqualToNewFontSizeIncreasedByContentSizeCategoryDelta {
    //Arrange
    CGFloat newFontSize = 7.0f;
    UIFont *newFont = [UIFont systemFontOfSize:newFontSize];

    NSArray<SSDynamicTextView *> *dynamicTextViews = [self dynamicTextViewsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    for (SSDynamicTextView *textView in dynamicTextViews) {
        //Act
        textView.font = newFont;

        //Assert
        XCTAssertEqualWithAccuracy(textView.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testTextViewAttributedStringFontSizesShouldBeIncreasedByContentSizeCategoryDelta {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];

    NSArray<SSDynamicTextView *> *dynamicTextViews = [self dynamicTextViewsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    for (SSDynamicTextView *textView in dynamicTextViews) {
        //Act
        textView.dynamicAttributedText = attributedString;

        //Assert
        XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:textView.attributedText
                                                                changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);

        XCTAssertEqualObjects(textView.dynamicAttributedText, attributedString);
    }
}

@end
