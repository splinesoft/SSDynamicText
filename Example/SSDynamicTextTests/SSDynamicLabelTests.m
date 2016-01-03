//
//  SSDynamicLabelTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.  
//

#import <XCTest/XCTest.h>
#import "SSTestsHelper.h"
#import "SSAttributedStringValidator.h"

#import "SSDynamicLabel.h"
#import "SSDynamicsView.h"

@interface SSDynamicLabelTests : XCTestCase
@end

@implementation SSDynamicLabelTests

- (void)setUp {
    [super setUp];

    //Default content size category
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryLarge];
}

- (void)tearDown {
    [SSTestsHelper stopMockingPreferredContentSizeCategory];
    [super tearDown];
}

- (NSArray<SSDynamicLabel *> *)dynamicLabelsWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:fontSize];

    SSDynamicLabel *dynamicLabel = [[SSDynamicLabel alloc] init];
    dynamicLabel.defaultFontDescriptor = fontDescriptor;

    SSDynamicLabel *dynamicLabelWithFrame = [[SSDynamicLabel alloc] initWithFrame:CGRectZero];
    dynamicLabelWithFrame.font = [UIFont fontWithName:fontName size:fontSize];

    SSDynamicLabel *dynamicLabelWithFont = [SSDynamicLabel labelWithFont:fontName baseSize:fontSize];

    SSDynamicLabel *dynamicLabelWithFontDescriptor = [SSDynamicLabel labelWithFontDescriptor:fontDescriptor];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    SSDynamicLabel *dynamicLabelFromXib = view.label;

    return @[ dynamicLabel, dynamicLabelWithFrame, dynamicLabelWithFont, dynamicLabelWithFontDescriptor, dynamicLabelFromXib ];
}

- (void)testLabelFontNameShouldBeEqualToFontNameFromConstructor {
    //Arrange
    NSString *expectedFontName = SSTestFontName;

    //Act
    NSArray<SSDynamicLabel *> *dynamicLabels = [self dynamicLabelsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicLabel *label in dynamicLabels) {
        //Assert
        XCTAssertEqualObjects(label.font.fontName, expectedFontName);
    }
}

- (void)testLabelFontSizeShouldBeEqualToFontSizeInConstructorForDefaultPreferredContentSizeCategory {
    //Arrange
    CGFloat expectedFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicLabel *> *dynamicLabels = [self dynamicLabelsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicLabel *label in dynamicLabels) {
        //Assert
        XCTAssertEqualWithAccuracy(label.font.pointSize, expectedFontSize, FLT_EPSILON);
    }
}

- (void)testLabelFontSizeShouldBeEqualToLabelFontSizeIncreasedByPreferredContentSizeCategoryDelta {
    // Arrange
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    CGFloat initialFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicLabel *> *dynamicLabels = [self dynamicLabelsWithFontName:SSTestFontName fontSize:initialFontSize];

    for (SSDynamicLabel *label in dynamicLabels) {

        //Assert
        XCTAssertEqualWithAccuracy(label.font.pointSize, initialFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testLabelFontSizeShouldBeEqualToNewFontSizeIncreasedByContentSizeCategoryDelta {
    //Arrange
    CGFloat newFontSize = 7.0f;
    UIFont *newFont = [UIFont systemFontOfSize:newFontSize];

    NSArray<SSDynamicLabel *> *dynamicLabels = [self dynamicLabelsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    for (SSDynamicLabel *label in dynamicLabels) {
        //Act
        label.font = newFont;

        //Assert
        XCTAssertEqualWithAccuracy(label.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testLabelAttributedStringFontSizesShouldBeIncreasedByContentSizeCategoryDelta {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];

    NSArray<SSDynamicLabel *> *dynamicLabels = [self dynamicLabelsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    for (SSDynamicLabel *label in dynamicLabels) {
        //Act
        label.dynamicAttributedText = attributedString;

        //Assert
        XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:label.attributedText
                                                                changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);

        XCTAssertEqualObjects(label.dynamicAttributedText, attributedString);
    }
}

@end
