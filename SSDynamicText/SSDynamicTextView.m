//
//  SSDynamicTextView.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@interface SSDynamicTextView ()

@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, assign) CGFloat baseSize;

- (void) setup;

@end

@implementation SSDynamicTextView

- (id)init {
    if ((self = [super init])) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    self.fontName = (self.fontName ?: [self ss_defaultFontName]);
    self.baseSize = (self.baseSize ?: [self ss_defaultBaseSize]);
    
    self.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:self.fontName
                                                                     size:self.baseSize];
    [self setup];
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
