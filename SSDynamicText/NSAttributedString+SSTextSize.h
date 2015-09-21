//
//  NSAttributedString+SSTextSize.h
//  Pods
//
//  Created by Remigiusz Herba on 28/08/15.
//
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (SSTextSize)

- (NSAttributedString *)ss_attributedStringWithAdjustedFontSizeWithDelta:(NSInteger)delta;

@end
