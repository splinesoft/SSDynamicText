//
//  SSTestsHelper.h
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 17/09/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const SSTestFontName;
extern CGFloat const SSTestFontSize;
extern CGFloat const SSTestFontSizeDifferenceForSizeExtraExtraLarge;

@interface SSTestsHelper : NSObject

+ (void)startMockingPreferredContentSizeCategory:(NSString *)contentSizeCategory;
+ (void)stopMockingPreferredContentSizeCategory;
+ (void)postContentSizeChangeNotification;

+ (void)startMockingBundleDictionary:(NSDictionary *)dictionary;
+ (void)stopMockingBundleDictionary;

@end
