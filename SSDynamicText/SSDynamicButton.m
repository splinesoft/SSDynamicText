//
//  SSDynamicButton.m
//  SSDynamicText
//
//  Created by Adam Grzegorowski on 18/07/15.
//

#import "SSDynamicButton.h"
#import "UIView+SSTextSize.h"

@interface SSDynamicButton ()

@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, assign) CGFloat baseSize;

- (void)setup;

@end

@implementation SSDynamicButton

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    if (self.titleLabel.font) {
        self.fontName = self.titleLabel.font.fontName;
        self.baseSize = self.titleLabel.font.pointSize;
    }

    self.fontName = (self.fontName ?: [self ss_defaultFontName]);
    self.baseSize = (self.baseSize ?: [self ss_defaultBaseSize]);

    self.defaultFontDescriptor = (self.titleLabel.font.fontDescriptor ?:
                                  [UIFontDescriptor fontDescriptorWithName:self.fontName
                                                                      size:self.baseSize]);

    [self setup];
}

+ (instancetype)buttonWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    SSDynamicButton *button = [self new];
    button.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];

    return button;
}

+ (instancetype)buttonWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSDynamicButton *button = [self new];
    button.defaultFontDescriptor = descriptor;

    return button;
}

- (void)dealloc {
    [self ss_stopObservingTextSizeChanges];
}

- (void)setup {
    __weak typeof(self) weakSelf = self;

    SSTextSizeChangedBlock changeHandler = ^(NSInteger newDelta) {
        CGFloat preferredSize = [weakSelf.defaultFontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
        preferredSize += newDelta;

        weakSelf.titleLabel.font = [UIFont fontWithDescriptor:weakSelf.defaultFontDescriptor
                                                         size:preferredSize];
    };

    [self ss_startObservingTextSizeChangesWithBlock:changeHandler];
}

@end
