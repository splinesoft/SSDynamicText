//
//  SSDynamicTextView.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@interface SSDynamicTextView ()

@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, assign) CGFloat baseSize;

- (void) setup;

@end

@implementation SSDynamicTextView

- (id)init {
    self = [super init];
    if(self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    if (self.fontName && self.baseSize) {
        self.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:self.fontName size:self.baseSize];
        [self setup];
    }
}

+ (instancetype) textViewWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    SSDynamicTextView *textView = [SSDynamicTextView new];
    textView.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName
                                                                         size:size];
    
    return textView;
}

+ (instancetype)textViewWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSDynamicTextView *textView = [SSDynamicTextView new];
    textView.defaultFontDescriptor = descriptor;
    
    return textView;
}

- (void)dealloc {
    [self ss_stopObservingTextSizeChanges];
}

- (void)setup {
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
