//
//  SSDynamicButton.h
//  SSDynamicText
//
//  Created by Adam Grzegorowski on 18/07/15.
//
//

#import <UIKit/UIKit.h>

@interface SSDynamicButton : UIButton

/**
 * Create a button with dynamic-sizing title label that will adjust its size in response to changes
 * to the user's preferred text size.
 */
+ (instancetype)buttonWithFont:(NSString *)fontName
                      baseSize:(CGFloat)size;

/**
 * Create a button with dynamic-sizing title label using a base font descriptor.
 */
+ (instancetype)buttonWithFontDescriptor:(UIFontDescriptor *)descriptor;

@end
