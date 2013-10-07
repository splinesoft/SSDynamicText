//
//  UILabel+SSTextSize.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@implementation UILabel (SSTextSize)

+ (instancetype) labelWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    UILabel *label = [UILabel new];
    label.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];
    [label ss_setupDynamicTextSize];

    return label;
}

+ (instancetype)labelWithFontDescriptor:(UIFontDescriptor *)descriptor {
    UILabel *label = [UILabel new];
    label.defaultFontDescriptor = descriptor;
    [label ss_setupDynamicTextSize];
  
    return label;
}

- (void)dealloc {
    [self ss_stopObservingTextSizeChanges];
}

- (void) ss_setupDynamicTextSize {
    if( !self.defaultFontDescriptor )
        self.defaultFontDescriptor = self.font.fontDescriptor;
  
    __weak typeof (self) weakSelf = self;
    
    SSTextSizeChangedBlock changeHandler = ^(NSInteger newDelta) {
        CGFloat preferredSize = [weakSelf.defaultFontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
        preferredSize += newDelta;
        
        weakSelf.font = [UIFont fontWithDescriptor:weakSelf.defaultFontDescriptor
                                              size:preferredSize];
    };
    
    [self ss_startObservingTextSizeChangesWithBlock:changeHandler];
}

@end
