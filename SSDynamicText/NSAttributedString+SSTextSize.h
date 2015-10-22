//
//  NSAttributedString+SSTextSize.h
//  SSDynamicText
//
//  Created by Remigiusz Herba on 28/08/15.
//
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (SSTextSize)

/**
 * Creates NSAttributedString with each font size changed by delta
 * @param delta The size by which you want to change the font.
 * A negative number will decrease font size.
 * A positive number will increase font size.
 * @return new NSAttributedString object with font size changed by delta.
 */
- (NSAttributedString *)ss_attributedStringWithAdjustedFontSizeWithDelta:(NSInteger)delta;

@end
