//
//  SSDynamicLabelTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <SSDynamicLabel.h>
#import "SSDynamicsView.h"
#import "SSAttributedStringValidator.h"
#import "SSTestsHelper.h"

@interface SSDynamicLabelTests : XCTestCase

@property (nonatomic, strong) SSDynamicLabel *dynamicLabel;
@property (nonatomic, strong) SSDynamicLabel *dynamicLabelFromXib;

@end

@implementation SSDynamicLabelTests

- (void)setUp {
    [super setUp];
    self.dynamicLabel = [SSDynamicLabel labelWithFont:SSTestFontName baseSize:SSTestFontSize];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    self.dynamicLabelFromXib = view.label;
    [SSTestsHelper mockExtraExtraLargeCategory];
}

- (void)tearDown {
    [SSTestsHelper stopMocking];
    [super tearDown];
}


- (void)testDefaultSettings {
    //Assert
    XCTAssertEqualObjects(self.dynamicLabel.font.fontName, SSTestFontName);
    XCTAssertEqualObjects(self.dynamicLabelFromXib.font.fontName, SSTestFontName);
    XCTAssertEqual(self.dynamicLabel.font.pointSize, SSTestFontSize);
    XCTAssertEqual(self.dynamicLabelFromXib.font.pointSize, SSTestFontSize);
}

- (void)testContentSizeChange {
    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertEqual(self.dynamicLabel.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
    XCTAssertEqual(self.dynamicLabelFromXib.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
}

- (void)testFontChangeAndThenContentSizeChange {
    //Arrange
    CGFloat newFontSize = 7.0f;
    UIFont *newFont = [UIFont systemFontOfSize:newFontSize];

    //Act
    self.dynamicLabel.font = newFont;
    self.dynamicLabelFromXib.font = newFont;
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertEqualObjects(self.dynamicLabel.font.fontName, newFont.fontName);
    XCTAssertEqualObjects(self.dynamicLabelFromXib.font.fontName, newFont.fontName);
    XCTAssertEqual(self.dynamicLabel.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
    XCTAssertEqual(self.dynamicLabelFromXib.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
}

- (void)testAttributedStringContentSizeChange {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];
    self.dynamicLabel.dynamicAttributedText = attributedString;
    self.dynamicLabelFromXib.dynamicAttributedText = attributedString;

    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicLabel.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicLabelFromXib.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);

    XCTAssertEqualObjects(attributedString, self.dynamicLabel.dynamicAttributedText);
    XCTAssertEqualObjects(attributedString, self.dynamicLabelFromXib.dynamicAttributedText);
}

@end
