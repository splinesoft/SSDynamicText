//
//  UIView+SSTextSize.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "UIView+SSTextSize.h"
#import "UIApplication+SSTextSize.h"
#import <objc/runtime.h>

static char kTextSizeChangedKey;
static char kDefaultFontDescriptorKey;

@implementation UIView (SSTextSize)

#pragma mark - default font descriptor

- (UIFontDescriptor *)defaultFontDescriptor {
    return (UIFontDescriptor *)objc_getAssociatedObject( self, &kDefaultFontDescriptorKey );
}

- (void)setDefaultFontDescriptor:(UIFontDescriptor *)defaultFontDescriptor {
    objc_setAssociatedObject( self, &kDefaultFontDescriptorKey, defaultFontDescriptor, OBJC_ASSOCIATION_COPY_NONATOMIC );
    
    [self preferredContentSizeDidChange];
}

#pragma mark - text size changes

- (void)ss_startObservingTextSizeChangesWithBlock:(SSTextSizeChangedBlock)block {
    NSParameterAssert(block);
    
    [self ss_stopObservingTextSizeChanges];
    
    objc_setAssociatedObject( self, &kTextSizeChangedKey, block, OBJC_ASSOCIATION_COPY );
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeDidChange)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
    [self preferredContentSizeDidChange];
}

- (void)ss_stopObservingTextSizeChanges {
    objc_setAssociatedObject( self, &kTextSizeChangedKey, nil, OBJC_ASSOCIATION_ASSIGN );
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)preferredContentSizeDidChange {
    NSInteger newDelta = [[UIApplication sharedApplication] preferredFontSizeDelta];
    
    SSTextSizeChangedBlock changeBlock = objc_getAssociatedObject( self, &kTextSizeChangedKey );
    
    if( changeBlock )
        changeBlock( newDelta );
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsDisplay];
}

@end
