//
//  SSDynamicTextField.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@interface SSDynamicTextField ()

@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, assign) CGFloat baseSize;

- (void) setup;

@end

@implementation SSDynamicTextField

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

+ (instancetype)textFieldWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];
    
    return [self textFieldWithFontDescriptor:fontDescriptor];
}

+ (instancetype)textFieldWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSDynamicTextField *textField = [self new];
    textField.defaultFontDescriptor = descriptor;
    
    return textField;
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
