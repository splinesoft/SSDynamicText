//
//  UITextField+SSTextSize.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@implementation UITextField (SSTextSize)

+ (instancetype)textFieldWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    UITextField *textField = [UITextField new];
    textField.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName
                                                                          size:size];
    [textField ss_setupDynamicTextSize];
    
    return textField;
}

+ (instancetype)textFieldWithFontDescriptor:(UIFontDescriptor *)descriptor {
    UITextField *textField = [UITextField new];
    textField.defaultFontDescriptor = descriptor;
    [textField ss_setupDynamicTextSize];
    
    return textField;
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
