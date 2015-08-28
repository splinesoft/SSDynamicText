//
//  SSDynamicTextSizeChanger.h
//  Pods
//
//  Created by Remigiusz Herba on 15/09/15.
//
//

#import <Foundation/Foundation.h>
#import "SSDynamicAttributedTextSizable.h"
#import "UIView+SSTextSize.h"

@interface SSDynamicTextSizeChanger : NSObject <SSDynamicAttributedTextSizable>

@property (nonatomic, strong) UIFontDescriptor *defaultFontDescriptor;
@property (nonatomic, readonly) SSTextSizeChangedBlock changeHandler;

@property (nonatomic, copy) void(^fontChangeBlock)(UIFont *font);
@property (nonatomic, copy) void(^attributedTextChangeBlock)(NSAttributedString *attributedString);

@end
