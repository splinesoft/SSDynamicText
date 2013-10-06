//
//  SSViewController.m
//  SSLabelExample
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSViewController.h"
#import <SSLabel.h>

@interface SSViewController ()

@property (nonatomic, strong) SSLabel *label;

@end

@implementation SSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _label = [SSLabel labelWithFont:@"Courier" baseSize:16.0f];
    _label.text = @"This label supports custom fonts and responds to changes in preferred text size.\n\nSwitch to Settings.app, change your preferred text size, then switch back here.";
    _label.textColor = [UIColor darkGrayColor];
    _label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentCenter;
    [_label setFrame:CGRectInset(self.view.frame, 10, 20)];
    
    [self.view addSubview:_label];
}

@end
