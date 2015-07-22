//
//  SSDynamicLabel.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@interface SSDynamicLabel ()

@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, assign) CGFloat baseSize;

- (void) setup;

@end

@implementation SSDynamicLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.font) {
        self.fontName = self.font.fontName;
        self.baseSize = self.font.pointSize;
    }

    self.fontName = (self.fontName ?: [self ss_defaultFontName]);
    self.baseSize = (self.baseSize ?: [self ss_defaultBaseSize]);
    
    self.defaultFontDescriptor = (self.font.fontDescriptor ?:
                                  [UIFontDescriptor fontDescriptorWithName:self.fontName
                                                                      size:self.baseSize]);

    [self setup];
}

+ (instancetype)labelWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];

    return [self labelWithFontDescriptor:fontDescriptor];
}

+ (instancetype)labelWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSDynamicLabel *label = [self new];
    label.defaultFontDescriptor = descriptor;
  
    return label;
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
