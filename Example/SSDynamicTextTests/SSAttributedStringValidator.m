//
//  SSAttributedStringValidator.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  
//

#import "SSAttributedStringValidator.h"

static NSString * const kTestStringFirstPart = @"Test";
static NSString * const kTestStringSecondPart = @" string";

@implementation SSAttributedStringValidator

+ (UIFont *)firstFont {
    static UIFont *firstFont;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        firstFont = [UIFont systemFontOfSize:16.0f];
    });
    return firstFont;
}

+ (UIFont *)secondFont {
    static UIFont *secondFont;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        secondFont = [UIFont fontWithName:@"Courier" size:25.0f];
    });
    return secondFont;
}

+ (NSString *)testString {
    static NSString *string;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        string = [NSString stringWithFormat:@"%@%@", kTestStringFirstPart, kTestStringSecondPart];
    });
    return string;
}

#pragma mark - Public Methods

+ (NSAttributedString *)testAttributedString {
    NSDictionary *attributes =
    @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [self firstFont]};

    NSDictionary *secondAttributes =
    @{NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName: [self secondFont]};

    NSMutableAttributedString *testString = [[NSMutableAttributedString alloc] initWithString:[self testString] attributes:attributes];
    [testString addAttributes:secondAttributes range:[[self testString] rangeOfString:kTestStringSecondPart]];

    return testString;
}

+ (BOOL)isValidTestAttributedString:(NSAttributedString *)attributedString changedByDelta:(NSInteger)delta {
    __block BOOL isFirstFontValid = NO;
    __block BOOL isSecondFontValid = NO;
    UIFont *firstFont = [self firstFont];
    UIFont *secondFont = [self secondFont];

    [attributedString enumerateAttribute:NSFontAttributeName
                                 inRange:NSMakeRange(0, attributedString.length)
                                 options:0
                              usingBlock:^(UIFont *value, NSRange range, BOOL *stop) {

                                  if (value) {
                                      if (NSEqualRanges(range, [[self testString] rangeOfString:kTestStringFirstPart])) {
                                          if ([value.fontName isEqualToString:firstFont.fontName]
                                              && value.pointSize == firstFont.pointSize + delta) {
                                              isFirstFontValid = YES;
                                          }
                                      }
                                      if (NSEqualRanges(range, [[self testString] rangeOfString:kTestStringSecondPart])) {
                                          if ([value.fontName isEqualToString:secondFont.fontName]
                                              && value.pointSize == secondFont.pointSize + delta) {
                                              isSecondFontValid = YES;
                                          }
                                      }
                                  }
                              }];
    return isFirstFontValid && isSecondFontValid;
}

@end
