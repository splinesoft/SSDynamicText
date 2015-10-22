//
//  SSDynamicLabel.h
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

@import UIKit;
#import "SSDynamicAttributedTextSizable.h"

/**
 * In iOS 7, the user can set his or her preferred text size in Settings.app.
 * This label adjusts its font size by an offset determined by the user's preferred text size.
 */

@interface SSDynamicLabel : UILabel <SSDynamicAttributedTextSizable>

/**
 * Create a dynamic-sizing label that will adjust its size in response to changes
 * to the user's preferred text size.
 */
+ (instancetype) labelWithFont:(NSString *)fontName 
                      baseSize:(CGFloat)size;

/**
 * Create a dynamic-sizing label using a base font descriptor.
 */
+ (instancetype) labelWithFontDescriptor:(UIFontDescriptor *)descriptor;

@end
