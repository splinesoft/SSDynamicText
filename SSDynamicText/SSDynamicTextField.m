//
//  SSDynamicTextField.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"
#import "SSDynamicTextSizeChanger.h"

@interface SSDynamicTextField ()

@property (nonatomic, copy) NSAttributedString *baseAttributedText;
@property (nonatomic, strong) SSDynamicTextSizeChanger *textSizeChanger;

@end

@implementation SSDynamicTextField

- (SSDynamicTextSizeChanger *)textSizeChanger {
    if (_textSizeChanger == nil) {
        _textSizeChanger = [self createTextChanger];
    }
    return _textSizeChanger;
}

- (void)setDefaultFontDescriptor:(UIFontDescriptor *)defaultFontDescriptor {
    self.textSizeChanger.defaultFontDescriptor = defaultFontDescriptor;
    [super setDefaultFontDescriptor:defaultFontDescriptor];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setupBaseFontBasedOnCurrentFont];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self startObservingTextSizeChanged];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupBaseFontBasedOnCurrentFont];
    [self startObservingTextSizeChanged];
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

#pragma mark - Private Methods

- (SSDynamicTextSizeChanger *)createTextChanger {
    SSDynamicTextSizeChanger *changer = [[SSDynamicTextSizeChanger alloc] init];
    __weak typeof(self) weakSelf = self;

    changer.fontChangeBlock = ^(UIFont *font) {
        [super setFont:font];
    };

    changer.attributedTextChangeBlock = ^(NSAttributedString *attributedText) {
        weakSelf.attributedText = attributedText;
    };
    return changer;
}

- (void)setupBaseFontBasedOnCurrentFont {
    NSString *fontName;
    CGFloat baseSize = 0;

    if (self.font) {
        fontName = self.font.fontName;
        baseSize = self.font.pointSize;
    }

    fontName = (fontName ?: [self ss_defaultFontName]);
    baseSize = (baseSize ?: [self ss_defaultBaseSize]);

    self.defaultFontDescriptor = (self.font.fontDescriptor ?:
                                  [UIFontDescriptor fontDescriptorWithName:fontName
                                                                      size:baseSize]);
}

- (void)startObservingTextSizeChanged {
    [self ss_startObservingTextSizeChangesWithBlock:self.textSizeChanger.changeHandler];
}

#pragma mark - SSDynamicAttributedTextSizable

- (NSAttributedString *)dynamicAttributedText {
    return self.textSizeChanger.dynamicAttributedText;
}

- (void)setDynamicAttributedText:(NSAttributedString *)attributedText {
    self.textSizeChanger.dynamicAttributedText = attributedText;
}

@end
