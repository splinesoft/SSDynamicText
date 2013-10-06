//
//  SSLabel.h
//  SSLabel
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * In iOS 7, the user can set his or her preferred text size in Settings.app.
 * This label adjusts its font size by an offset determined by the user's preferred text size.
 */

@interface SSLabel : UILabel

/**
 * The default font descriptor used by this label.
 * Its size is adjusted up (or down) based on the user's preferred text size.
 * Updating this will change the label's font.
 * The two constructors below will create the defaultFontDescriptor for you.
 */
@property (nonatomic, strong) UIFontDescriptor *defaultFontDescriptor;

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
