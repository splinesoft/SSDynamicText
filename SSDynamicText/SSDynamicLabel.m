//
//  SSDynamicLabel.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"
#import "SSDynamicTextSizeChanger.h"

@interface SSDynamicLabel ()

@property (nonatomic, copy) NSAttributedString *baseAttributedText;
@property (nonatomic, strong) SSDynamicTextSizeChanger *textSizeChanger;

@end

@implementation SSDynamicLabel

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
        [self startObservingTextSizeChanges];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupBaseFontBasedOnCurrentFont];
    [self startObservingTextSizeChanges];
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

- (void)startObservingTextSizeChanges {
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
