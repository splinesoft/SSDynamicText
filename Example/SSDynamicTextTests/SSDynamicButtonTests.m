//
//  SSDynamicButtonTests.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <SSDynamicButton.h>
#import "SSDynamicsView.h"
#import "SSAttributedStringValidator.h"
#import "SSTestsHelper.h"

@interface SSDynamicButtonTests : XCTestCase

@property (nonatomic, strong) SSDynamicButton *dynamicButton;
@property (nonatomic, strong) SSDynamicButton *dynamicButtonFromXib;

@end

@implementation SSDynamicButtonTests

- (void)setUp {
    [super setUp];
    self.dynamicButton = [SSDynamicButton buttonWithFont:SSTestFontName baseSize:SSTestFontSize];

    SSDynamicsView *view = [[NSBundle mainBundle] loadNibNamed:@"SSDynamicsView" owner:nil options:nil].firstObject;
    self.dynamicButtonFromXib = view.button;
    [SSTestsHelper mockExtraExtraLargeCategory];
}

- (void)tearDown {
    [SSTestsHelper stopMocking];
    [super tearDown];
}

- (void)testDefaultSettings {
    //Assert
    XCTAssertEqualObjects(self.dynamicButton.titleLabel.font.fontName, SSTestFontName);
    XCTAssertEqualObjects(self.dynamicButtonFromXib.titleLabel.font.fontName, SSTestFontName);
    XCTAssertEqual(self.dynamicButton.titleLabel.font.pointSize, SSTestFontSize);
    XCTAssertEqual(self.dynamicButtonFromXib.titleLabel.font.pointSize, SSTestFontSize);
}

- (void)testContentSizeChange {
    //Act
    [SSTestsHelper postContentSizeChangeNotification];

    //Assert
    XCTAssertEqual(self.dynamicButton.titleLabel.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
    XCTAssertEqual(self.dynamicButtonFromXib.titleLabel.font.pointSize, SSTestFontSize + SSTestFontSizeDifferenceForSizeExtraExtraLarge);
}

- (void)testAttributedStringContentSizeChange {
    //Arrange
    NSAttributedString *attributedString = [SSAttributedStringValidator testAttributedString];
    [self.dynamicButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [self.dynamicButtonFromXib setAttributedTitle:attributedString forState:UIControlStateNormal];
    [SSTestsHelper postContentSizeChangeNotification];

    //Act
    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification object:nil];

    //Assert
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicButton.titleLabel.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
    XCTAssertTrue([SSAttributedStringValidator isValidTestAttributedString:self.dynamicButtonFromXib.titleLabel.attributedText
                                                            changedByDelta:SSTestFontSizeDifferenceForSizeExtraExtraLarge]);
}

@end
