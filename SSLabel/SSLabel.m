//
//  SSLabel.m
//  SSLabel
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSLabel.h"
#import "UIApplication+SSTextSize.h"
#import "UIFont+SSTextSize.h"

@interface SSLabel ()

- (void) setup;
- (void) preferredContentSizeDidChange;

@end

@implementation SSLabel

- (id)init {
    if( ( self = [super init] ) ) {
        [self setup];
    }
  
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if( ( self = [super initWithFrame:frame] ) ) {
        [self setup];
    }
  
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( ( self = [super initWithCoder:aDecoder] ) ) {
        [self setup];
    }
  
    return self;
}

+ (instancetype) labelWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    SSLabel *label = [SSLabel new];
    label.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];

    return label;
}

+ (instancetype)labelWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSLabel *label = [SSLabel new];
    label.defaultFontDescriptor = descriptor;
  
    return label;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - font size

- (void)setDefaultFontDescriptor:(UIFontDescriptor *)defaultFontDescriptor {
    _defaultFontDescriptor = defaultFontDescriptor;
  
    [self preferredContentSizeDidChange];
}

- (void)setup {    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeDidChange)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  
    [self preferredContentSizeDidChange];
}

- (void)preferredContentSizeDidChange {
    CGFloat preferredSize = [self.defaultFontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
    preferredSize += [[UIApplication sharedApplication] preferredFontSizeDelta];
  
    self.font = [UIFont fontWithDescriptor:self.defaultFontDescriptor
                                      size:preferredSize];
  
    [self invalidateIntrinsicContentSize];
    [self setNeedsDisplay];
}

@end
