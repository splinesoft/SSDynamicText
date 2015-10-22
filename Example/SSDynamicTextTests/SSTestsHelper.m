//
//  SSTestsHelper.m
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 17/09/15.
//  
//

#import "SSTestsHelper.h"
#import <OCMock/OCMock.h>

NSString * const SSTestFontName = @"Avenir-Roman";
CGFloat const SSTestFontSize = 14.f;
CGFloat const SSTestFontSizeDifferenceForSizeExtraExtraLarge = 2.f;

static id applicationMock;

@implementation SSTestsHelper

+ (void)mockExtraExtraLargeCategory {
    applicationMock = OCMPartialMock([UIApplication sharedApplication]);
    OCMStub([applicationMock preferredContentSizeCategory]).andReturn(UIContentSizeCategoryExtraExtraLarge);
}

+ (void)stopMocking {
    [applicationMock stopMocking];
    applicationMock = nil;
}

+ (void)postContentSizeChangeNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification object:nil];
}

@end
