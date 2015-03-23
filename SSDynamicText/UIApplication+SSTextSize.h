//
//  UIApplication+SSTextSize.h
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

@import UIKit;

@interface UIApplication (SSTextSize)

/**
 * In iOS 7, the user can select his or her preferred font size in settings.app.
 * This property returns a numeric delta between the default size setting (Large)
 * and the user's current preferred text size.
 *
 * This is used as part of the UIFont+TextSize category.
 */
- (NSInteger) preferredFontSizeDelta;

@end
