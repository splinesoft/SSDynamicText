//
//  SSAttributedStringValidator.h
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  
//

#import <UIKit/UIKit.h>

@interface SSAttributedStringValidator : NSObject

+ (NSAttributedString *)testAttributedString;
+ (BOOL)isValidTestAttributedString:(NSAttributedString *)attributedString changedByDelta:(NSInteger)delta;

@end
