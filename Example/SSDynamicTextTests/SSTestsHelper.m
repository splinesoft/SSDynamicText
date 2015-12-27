//
//  SSTestsHelper.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 17/09/15.
//  Copyright (c) 2015 Splinesoft. All rights reserved. 
//

#import "SSTestsHelper.h"
#import <OCMock/OCMock.h>

NSString * const SSTestFontName = @"Avenir-Roman";
CGFloat const SSTestFontSize = 14.f;
CGFloat const SSTestFontSizeDifferenceForSizeExtraExtraLarge = 2.f;

static id applicationMock;
static id bundleMock;

@implementation SSTestsHelper

+ (void)startMockingPreferredContentSizeCategory:(NSString *)contentSizeCategory {
    if (applicationMock) {
        [self stopMockingPreferredContentSizeCategory];
    }

    applicationMock = OCMPartialMock([UIApplication sharedApplication]);
    OCMStub([applicationMock preferredContentSizeCategory]).andReturn(contentSizeCategory);
}

+ (void)stopMockingPreferredContentSizeCategory {
    [applicationMock stopMocking];
    applicationMock = nil;
}

+ (void)postContentSizeChangeNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification object:nil];
}

+ (void)startMockingBundleDictionary:(NSDictionary *)dictionary {
    if (bundleMock) {
        [self stopMockingBundleDictionary];
    }

    bundleMock = OCMPartialMock([NSBundle mainBundle]);
    OCMStub([bundleMock infoDictionary]).andReturn(dictionary);
}

+ (void)stopMockingBundleDictionary {
    [bundleMock stopMocking];
    bundleMock = nil;
}

@end
