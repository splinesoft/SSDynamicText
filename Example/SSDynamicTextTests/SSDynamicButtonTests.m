//
//  SSDynamicButtonTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved. 
//

#import <XCTest/XCTest.h>
#import "SSTestsHelper.h"
#import "SSAttributedStringValidator.h"

#import "SSDynamicButton.h"
#import "SSDynamicsView.h"

@interface SSDynamicButtonTests : XCTestCase
@end

@implementation SSDynamicButtonTests

- (void)setUp {
    [super setUp];

    //Default content size category
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryLarge];
}

- (void)tearDown {
    [SSTestsHelper stopMockingPreferredContentSizeCategory];
    [super tearDown];
}

- (NSArray<SSDynamicButton *> *)dynamicButtonsWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:fontSize];

    SSDynamicButton *dynamicButton = [[SSDynamicButton alloc] init];
    dynamicButton.defaultFontDescriptor = fontDescriptor;

    SSDynamicButton *dynamicButtonWithFrame = [[SSDynamicButton alloc] initWithFrame:CGRectZero];
    dynamicButtonWithFrame.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];

    SSDynamicButton *dynamicButtonWithFont = [SSDynamicButton buttonWithFont:fontName baseSize:fontSize];

    SSDynamicButton *dynamicButtonWithFontDescriptor = [SSDynamicButton buttonWithFontDescriptor:fontDescriptor];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    SSDynamicButton *dynamicButtonFromXib = view.button;

    return @[ dynamicButton, dynamicButtonWithFrame, dynamicButtonWithFont, dynamicButtonWithFontDescriptor, dynamicButtonFromXib ];
}

- (void)testButtonTitleLabelFontNameShouldBeEqualToFontNameFromConstructor {
    //Arrange
    NSString *expectedFontName = SSTestFontName;

    //Act
    NSArray<SSDynamicButton *> *dynamicButtons = [self dynamicButtonsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicButton *button in dynamicButtons) {
        //Assert
        XCTAssertEqualObjects(button.titleLabel.font.fontName, expectedFontName);
    }
}

- (void)testButtonTitleLabelFontSizeShouldBeEqualToFontSizeInConstructorForDefaultPreferredContentSizeCategory {
    //Arrange
    CGFloat expectedFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicButton *> *dynamicButtons = [self dynamicButtonsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicButton *button in dynamicButtons) {
        //Assert
        XCTAssertEqualWithAccuracy(button.titleLabel.font.pointSize, expectedFontSize, FLT_EPSILON);
    }
}

- (void)testButtonTitleLabelFontSizeShouldBeEqualToLabelFontSizeIncreasedByPreferredContentSizeCategoryDelta {
    // Arrange
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    CGFloat initialFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicButton *> *dynamicButtons = [self dynamicButtonsWithFontName:SSTestFontName fontSize:initialFontSize];

    for (SSDynamicButton *button in dynamicButtons) {

        //Assert
        XCTAssertEqualWithAccuracy(button.titleLabel.font.pointSize, initialFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testButtonTitleLabelFontSizeShouldBeEqualToNewFontSizeIncreasedByContentSizeCategoryDelta {
    //Arrange
    CGFloat newFontSize = 7.0f;
    UIFont *newFont = [UIFont systemFontOfSize:newFontSize];

    NSArray<SSDynamicButton *> *dynamicButtons = [self dynamicButtonsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];
    
    for (SSDynamicButton *button in dynamicButtons) {
        //Act
        button.titleLabel.font = newFont;

        //Assert
        XCTAssertEqualWithAccuracy(button.titleLabel.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testButtonTitleLabelAttributedTitleFontSizesShouldBeIncreasedByContentSizeCategoryDeltaAfterSetAttributedTitle {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];

    NSArray<SSDynamicButton *> *dynamicButtons = [self dynamicButtonsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    for (SSDynamicButton *button in dynamicButtons) {
        //Act
        [button setAttributedTitle:attributedString forState:UIControlStateNormal];

        //Assert
        XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:[button attributedTitleForState:UIControlStateNormal]
                                                                changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
    }
}

- (void)testButtonTitleLabelAttributedTitleFontSizesShouldBeIncreasedByContentSizeCategoryDeltaAfterPostContentSizeChangeNotification {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];

    NSArray<SSDynamicButton *> *dynamicButtons = [self dynamicButtonsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicButton *button in dynamicButtons) {
        [button setAttributedTitle:attributedString forState:UIControlStateNormal];
    }

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];
    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    for (SSDynamicButton *button in dynamicButtons) {
        //Assert
        XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:[button attributedTitleForState:UIControlStateNormal]
                                                                changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
    }
}

@end
