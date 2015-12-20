//
//  SSDynamicTextFieldTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SSTestsHelper.h"
#import "SSAttributedStringValidator.h"

#import "SSDynamicTextField.h"
#import "SSDynamicsView.h"

@interface SSDynamicTextFieldTests : XCTestCase
@end

@implementation SSDynamicTextFieldTests

- (void)setUp {
    [super setUp];

    //Default content size category
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryLarge];
}

- (void)tearDown {
    [SSTestsHelper stopMockingPreferredContentSizeCategory];
    [super tearDown];
}

- (NSArray *)dynamicTextFieldsWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    SSDynamicTextField *dynamicTextFieldWithFont = [SSDynamicTextField textFieldWithFont:fontName baseSize:fontSize];

    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:fontSize];
    SSDynamicTextField *dynamicTextFieldWithFontDescriptor = [SSDynamicTextField textFieldWithFontDescriptor:fontDescriptor];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    SSDynamicTextField *dynamicTextFieldFromXib = view.textField;

    return @[ dynamicTextFieldWithFont, dynamicTextFieldWithFontDescriptor, dynamicTextFieldFromXib ];
}

- (void)testTextFieldFontNameShouldBeEqualToFontNameFromConstructor {
    //Arrange
    NSString *expectedFontName = SSTestFontName;

    //Act
    NSArray<SSDynamicTextField *> *dynamicTextFields = [self dynamicTextFieldsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicTextField *textField in dynamicTextFields) {
        //Assert
        XCTAssertEqualObjects(textField.font.fontName, expectedFontName);
    }
}

- (void)testTextFieldFontSizeShouldBeEqualToFontSizeInConstructorForDefaultPreferredContentSizeCategory {
    //Arrange
    CGFloat expectedFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicTextField *> *dynamicTextFields = [self dynamicTextFieldsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    for (SSDynamicTextField *textField in dynamicTextFields) {
        //Assert
        XCTAssertEqualWithAccuracy(textField.font.pointSize, expectedFontSize, FLT_EPSILON);
    }
}

- (void)testTextFieldFontSizeShouldBeEqualToLabelFontSizeIncreasedByPreferredContentSizeCategoryDelta {
    // Arrange
    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    CGFloat initialFontSize = SSTestFontSize;

    //Act
    NSArray<SSDynamicTextField *> *dynamicTextFields = [self dynamicTextFieldsWithFontName:SSTestFontName fontSize:initialFontSize];

    for (SSDynamicTextField *textField in dynamicTextFields) {

        //Assert
        XCTAssertEqualWithAccuracy(textField.font.pointSize, initialFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testLabelFontSizeShouldBeEqualToNewFontSizeIncreasedByContentSizeCategoryDelta {
    //Arrange
    CGFloat newFontSize = 7.0f;
    UIFont *newFont = [UIFont systemFontOfSize:newFontSize];

    NSArray *dynamicTextField = [self dynamicTextFieldsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    for (SSDynamicTextField *textField in dynamicTextField) {
        //Act
        textField.font = newFont;

        //Assert
        XCTAssertEqualWithAccuracy(textField.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge, FLT_EPSILON);
    }
}

- (void)testTextFieldAttributedStringFontSizesShouldBeIncreasedByContentSizeCategoryDelta {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];

    NSArray<SSDynamicTextField *> *dynamicTextFields = [self dynamicTextFieldsWithFontName:SSTestFontName fontSize:SSTestFontSize];

    [SSTestsHelper startMockingPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraLarge];

    for (SSDynamicTextField *textField in dynamicTextFields) {
        //Act
        textField.dynamicAttributedText = attributedString;

        //Assert
        XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:textField.attributedText
                                                                changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
        
        XCTAssertEqualObjects(textField.dynamicAttributedText, attributedString);
    }
}

@end
