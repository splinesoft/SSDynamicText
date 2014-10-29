//
//  UIView+SSTextSize.h
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

@import UIKit;

UIKIT_EXTERN NSString * const kSSDynamicDefaultFontName;
UIKIT_EXTERN NSString * const kSSDynamicDefaultBaseSize;

@interface UIView (SSTextSize)

typedef void (^SSTextSizeChangedBlock) (NSInteger);

/**
 * The default font descriptor used by this view.
 * Its size is adjusted up (or down) based on the user's preferred text size.
 * Updating this will change the view's font.
 */
@property (nonatomic, strong) UIFontDescriptor *defaultFontDescriptor;

/*
 * Begin observing changes to the user's preferred text size with the given callback block.
 * When the user changes her preferred text size, the callback block is called with the
 * new text size delta from the default.
 */
- (void) ss_startObservingTextSizeChangesWithBlock:(SSTextSizeChangedBlock)block;

/**
 * Stop observing changes to text size.
 */
- (void) ss_stopObservingTextSizeChanges;

/**
 * Force a recalculation of our preferred text size.
 */
- (void) preferredContentSizeDidChange;

/**
 * Default FontName if set in Info.plist or systemFontName if not set
 * Key: kSSDynamicDefaultFontName
 */
- (NSString *) ss_defaultFontName;

/**
 * DefaultBaseSize if set in Info.plist or 16.0 if not set
 * Key: kSSDynamicDefaultBaseSize
 */
- (CGFloat) ss_defaultBaseSize;

@end
