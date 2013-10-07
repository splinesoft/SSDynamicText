//
//  UITextField+SSTextSize.h
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SSTextSize)

/**
 * Add dynamic text size awareness to an existing text field.
 * Or, use one of the constructors below for a new text field.
 */
- (void) ss_setupDynamicTextSize;

/**
 * Create a dynamic-sizing label that will adjust its size in response to changes
 * to the user's preferred text size.
 */
+ (instancetype) textFieldWithFont:(NSString *)fontName
                          baseSize:(CGFloat)size;

/**
 * Create a dynamic-sizing label using a base font descriptor.
 */
+ (instancetype) textFieldWithFontDescriptor:(UIFontDescriptor *)descriptor;

@end
