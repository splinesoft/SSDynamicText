//
//  NSAttributedString+SSTextSize.m
//  Pods
//
//  Created by Remigiusz Herba on 28/08/15.
//
//

#import "NSAttributedString+SSTextSize.h"

@implementation NSAttributedString (SSTextSize)

- (NSAttributedString *)ss_attributedStringWithAdjustedFontSizeWithDelta:(NSInteger)delta {
    NSMutableAttributedString *attributedString = [self mutableCopy];
    [attributedString beginEditing];
    [attributedString enumerateAttribute:NSFontAttributeName
                                 inRange:NSMakeRange(0, attributedString.length)
                                 options:0
                              usingBlock:^(UIFont *value, NSRange range, BOOL *stop) {

                                  if (value) {
                                      UIFont *newFont = [UIFont fontWithDescriptor:value.fontDescriptor size:value.pointSize + delta];
                                      [attributedString removeAttribute:NSFontAttributeName range:range];
                                      [attributedString addAttribute:NSFontAttributeName value:newFont range:range];
                                  }
                              }];
    [attributedString endEditing];
    return [attributedString copy];
}

@end
