//
//  SSDynamicButton.m
//  SSDynamicText
//
//  Created by Adam Grzegorowski on 18/07/15.
//
//

#import "SSDynamicButton.h"
#import "SSDynamicText.h"
#import "UIView+SSTextSize.h"
#import "NSAttributedString+SSTextSize.h"

@interface SSDynamicButton ()

@property (nonatomic, strong) NSMutableDictionary *baseAttributedTitlesDictionary;

- (void)setup;

@end

@implementation SSDynamicButton

- (NSMutableDictionary *)baseAttributedTitlesDictionary {
    if (_baseAttributedTitlesDictionary == nil) {
        _baseAttributedTitlesDictionary = [NSMutableDictionary dictionary];
    }
    return _baseAttributedTitlesDictionary;
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
    NSNumber *key = @(state);
    if (title) {
        [self.baseAttributedTitlesDictionary setObject:title forKey:key];
    } else {
        [self.baseAttributedTitlesDictionary removeObjectForKey:key];
    }
    [self changeAttributedTitle:title forState:state withFontSizeDelta:[UIApplication sharedApplication].preferredFontSizeDelta];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    NSAssert(self.buttonType == UIButtonTypeCustom, @"Change SSDynamicButton.buttonType to UIButtonTypeCustom in your nib");
    NSString *fontName;
    CGFloat baseSize = 0;

    if (self.titleLabel.font) {
        fontName = self.titleLabel.font.fontName;
        baseSize = self.titleLabel.font.pointSize;
    }

    fontName = (fontName ?: [self ss_defaultFontName]);
    baseSize = (baseSize ?: [self ss_defaultBaseSize]);

    self.defaultFontDescriptor = (self.titleLabel.font.fontDescriptor ?:
                                  [UIFontDescriptor fontDescriptorWithName:fontName
                                                                      size:baseSize]);

    [self setup];
}

+ (instancetype)buttonWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];

    return [self buttonWithFontDescriptor:fontDescriptor];
}

+ (instancetype)buttonWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSDynamicButton *button = [self new];
    button.defaultFontDescriptor = descriptor;
    return button;
}

- (void)dealloc {
    [self ss_stopObservingTextSizeChanges];
}

- (void)changeFontWithDelta:(NSInteger)newDelta {
    CGFloat preferredSize = [self.defaultFontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
    preferredSize += newDelta;

    self.titleLabel.font = [UIFont fontWithDescriptor:self.defaultFontDescriptor
                                                 size:preferredSize];
}

- (void)changeAttributedTitle:(NSAttributedString *)attributedTitle forState:(UIControlState)state withFontSizeDelta:(NSInteger)newDelta {
    [super setAttributedTitle:[attributedTitle ss_attributedStringWithAdjustedFontSizeWithDelta:newDelta] forState:state];
}

- (void)changeAttributedStringWithDelta:(NSInteger)newDelta {
    [self.baseAttributedTitlesDictionary enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSAttributedString *obj, BOOL *stop) {
        [self changeAttributedTitle:obj forState:key.integerValue withFontSizeDelta:newDelta];
    }];
}

- (void)setup {
    __weak typeof(self) weakSelf = self;

    SSTextSizeChangedBlock changeHandler = ^(NSInteger newDelta) {

        [weakSelf changeFontWithDelta:newDelta];
        [weakSelf changeAttributedStringWithDelta:newDelta];
    };

    [self ss_startObservingTextSizeChangesWithBlock:changeHandler];
}

@end
