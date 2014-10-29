//
//  UIApplication+TextSize.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "UIApplication+SSTextSize.h"

@implementation UIApplication (SSTextSize)

- (NSInteger) preferredFontSizeDelta {
    static NSArray *fontSizes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fontSizes = @[
          UIContentSizeCategoryExtraSmall,
          UIContentSizeCategorySmall,
          UIContentSizeCategoryMedium,
          UIContentSizeCategoryLarge,
          UIContentSizeCategoryExtraLarge,
          UIContentSizeCategoryExtraExtraLarge,
          UIContentSizeCategoryExtraExtraExtraLarge
        ];
    });
  
    NSInteger delta = (NSInteger)[fontSizes indexOfObject:self.preferredContentSizeCategory];
  
    if (delta == NSNotFound) {
        return 0;
    }
  
    // Default size is 'Large'
    delta -= [fontSizes indexOfObject:UIContentSizeCategoryLarge];
  
    return delta;
}

@end
