//
//  SSDynamicTextFieldTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <SSDynamicTextField.h>
#import "SSDynamicsView.h"
#import "SSAttributedStringValidator.h"
#import "SSTestsHelper.h"

@interface SSDynamicTextFieldTests : XCTestCase

@property (nonatomic, strong) SSDynamicTextField *dynamicTextField;
@property (nonatomic, strong) SSDynamicTextField *dynamicTextFieldFromXib;

@end

@implementation SSDynamicTextFieldTests

- (void)setUp {
    [super setUp];
    
    self.dynamicTextField = [SSDynamicTextField textFieldWithFont:SSTestFontName baseSize:SSTestFontSize];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    self.dynamicTextFieldFromXib = view.textField;
    [SSTestsHelper mockExtraExtraLargeCategory];
}

- (void)tearDown {
    [SSTestsHelper stopMocking];
    [super tearDown];
}

- (void)testDefaultSettings {
    //Assert
    XCTAssertEqualObjects(self.dynamicTextField.font.fontName, SSTestFontName);
    XCTAssertEqualObjects(self.dynamicTextFieldFromXib.font.fontName, SSTestFontName);
    XCTAssertEqual(self.dynamicTextField.font.pointSize, SSTestFontSize);
    XCTAssertEqual(self.dynamicTextFieldFromXib.font.pointSize, SSTestFontSize);
}

- (void)testContentSizeChange {
    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertEqual(self.dynamicTextField.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
    XCTAssertEqual(self.dynamicTextFieldFromXib.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
}

- (void)testFontChangeAndThenContentSizeChange {
    //Arrange
    CGFloat newFontSize = 7.0f;
    UIFont *newFont = [UIFont systemFontOfSize:newFontSize];

    //Act
    self.dynamicTextField.font = newFont;
    self.dynamicTextFieldFromXib.font = newFont;
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertEqualObjects(self.dynamicTextField.font.fontName, newFont.fontName);
    XCTAssertEqualObjects(self.dynamicTextFieldFromXib.font.fontName, newFont.fontName);
    XCTAssertEqual(self.dynamicTextField.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
    XCTAssertEqual(self.dynamicTextFieldFromXib.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
}

- (void)testAttributedStringContentSizeChange {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];
    self.dynamicTextField.dynamicAttributedText = attributedString;
    self.dynamicTextFieldFromXib.dynamicAttributedText = attributedString;

    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicTextField.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicTextFieldFromXib.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);

    XCTAssertEqualObjects(attributedString, self.dynamicTextField.dynamicAttributedText);
    XCTAssertEqualObjects(attributedString, self.dynamicTextFieldFromXib.dynamicAttributedText);
}

@end
