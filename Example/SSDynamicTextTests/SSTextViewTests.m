//
//  SSTextViewTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <SSDynamicTextView.h>
#import "SSDynamicsView.h"
#import "SSAttributedStringValidator.h"
#import "SSTestsHelper.h"

@interface SSTextViewTests : XCTestCase

@property (nonatomic, strong) SSDynamicTextView *dynamicTextView;
@property (nonatomic, strong) SSDynamicTextView *dynamicTextViewFromXib;

@end

@implementation SSTextViewTests

- (void)setUp {
    [super setUp];
    self.dynamicTextView = [SSDynamicTextView textViewWithFont:SSTestFontName baseSize:SSTestFontSize];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    self.dynamicTextViewFromXib = view.textView;
    [SSTestsHelper mockExtraExtraLargeCategory];
}

- (void)tearDown {
    [SSTestsHelper stopMocking];
    [super tearDown];
}

- (void)testDefaultSettings {
    //Assert
    XCTAssertEqualObjects(self.dynamicTextView.font.fontName, SSTestFontName);
    XCTAssertEqualObjects(self.dynamicTextViewFromXib.font.fontName, SSTestFontName);
    XCTAssertEqual(self.dynamicTextView.font.pointSize, SSTestFontSize);
    XCTAssertEqual(self.dynamicTextViewFromXib.font.pointSize, SSTestFontSize);
}

- (void)testContentSizeChange {
    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertEqual(self.dynamicTextView.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
    XCTAssertEqual(self.dynamicTextViewFromXib.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
}

- (void)testFontChangeAndThenContentSizeChange {
    //Arrange
    CGFloat newFontSize = 7.0f;
    UIFont *newFont = [UIFont systemFontOfSize:newFontSize];

    //Act
    self.dynamicTextView.font = newFont;
    self.dynamicTextViewFromXib.font = newFont;
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertEqualObjects(self.dynamicTextView.font.fontName, newFont.fontName);
    XCTAssertEqualObjects(self.dynamicTextViewFromXib.font.fontName, newFont.fontName);
    XCTAssertEqual(self.dynamicTextView.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
    XCTAssertEqual(self.dynamicTextViewFromXib.font.pointSize, newFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
}

- (void)testAttributedStringContentSizeChange {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];
    self.dynamicTextView.dynamicAttributedText = attributedString;
    self.dynamicTextViewFromXib.dynamicAttributedText = attributedString;

    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicTextView.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicTextViewFromXib.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);

    XCTAssertEqualObjects(attributedString, self.dynamicTextView.dynamicAttributedText);
    XCTAssertEqualObjects(attributedString, self.dynamicTextViewFromXib.dynamicAttributedText);
}

@end
