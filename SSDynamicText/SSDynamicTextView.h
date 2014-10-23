//
//  SSDynamicTextView.h
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

@import UIKit;

@interface SSDynamicTextView : UITextView

/**
 * Create a dynamic-sizing textview that will adjust its size in response to changes
 * to the user's preferred text size.
 */
+ (instancetype) textViewWithFont:(NSString *)fontName
                         baseSize:(CGFloat)size;

/**
 * Create a dynamic-sizing label using a base font descriptor.
 */
+ (instancetype) textViewWithFontDescriptor:(UIFontDescriptor *)descriptor;

@end
