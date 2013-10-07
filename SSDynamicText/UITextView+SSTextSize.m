//
//  UITextView+SSTextSize.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@implementation UITextView (SSTextSize)

+ (instancetype) textViewWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    UITextView *textView = [UITextView new];
    textView.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName
                                                                         size:size];
    [textView ss_setupDynamicTextSize];
    
    return textView;
}

+ (instancetype)textViewWithFontDescriptor:(UIFontDescriptor *)descriptor {
    UITextView *textView = [UITextView new];
    textView.defaultFontDescriptor = descriptor;
    [textView ss_setupDynamicTextSize];
    
    return textView;
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
