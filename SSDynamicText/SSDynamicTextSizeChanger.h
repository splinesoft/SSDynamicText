//
//  SSDynamicTextSizeChanger.h
//  SSDynamicText
//
//  Created by Remigiusz Herba on 15/09/15.
//
//

#import <Foundation/Foundation.h>
#import "SSDynamicAttributedTextSizable.h"
#import "UIView+SSTextSize.h"

@interface SSDynamicTextSizeChanger : NSObject <SSDynamicAttributedTextSizable>

/**
 * The default font descriptor used by view.
 * Its size is adjusted up (or down) based on the user's preferred text size.
 * Updating this will change the view's font.
 */
@property (nonatomic, strong) UIFontDescriptor *defaultFontDescriptor;

/**
 * The default block called by view when font size change.
 */
@property (nonatomic, readonly) SSTextSizeChangedBlock changeHandler;

/**
 * Block which is called when SSDynamicTextSizeChanger want to change font, view should configure this block.
 */
@property (nonatomic, copy) void(^fontChangeBlock)(UIFont *font);

/**
 * Block which is called when SSDynamicTextSizeChanger want to change attributedText, view should configure this block.
 */
@property (nonatomic, copy) void(^attributedTextChangeBlock)(NSAttributedString *attributedString);

@end
