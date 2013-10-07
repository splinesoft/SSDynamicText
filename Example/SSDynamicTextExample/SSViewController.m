//
//  SSViewController.m
//  SSLabelExample
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSViewController.h"
#import <SSDynamicText.h>

@interface SSViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation SSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _label = [UILabel labelWithFont:@"Courier" baseSize:16.0f];
    _label.text = @"This label, text field, and text view all support custom fonts and respond to changes in preferred text size.\n\nSwitch to Settings.app, change your preferred text size, then switch back here.";
    _label.textColor = [UIColor darkGrayColor];
    _label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentCenter;
    [_label setFrame:(CGRect){
        {10, 25},
        {CGRectGetWidth(self.view.frame) - 20, 220}
    }];
    
    [self.view addSubview:_label];
    
    _textField = [UITextField textFieldWithFont:@"Courier"
                                       baseSize:15.0f];
    _textField.textColor = [UIColor darkGrayColor];
    _textField.backgroundColor = [UIColor lightGrayColor];
    _textField.placeholder = @"Text Field";
    [_textField setFrame:(CGRect){
        {10, CGRectGetMaxY(_label.frame) + 10},
        {CGRectGetWidth(self.view.frame) - 20, 32}
    }];
    
    [self.view addSubview:_textField];
    
    _textView = [UITextView textViewWithFont:@"Courier"
                                    baseSize:14.0f];
    _textView.textColor = [UIColor redColor];
    _textView.text = @"Text View";
    _textView.backgroundColor = [UIColor lightGrayColor];
    [_textView setFrame:(CGRect){
        {10, CGRectGetMaxY(_textField.frame) + 10},
        {CGRectGetWidth(self.view.frame) - 20, 100}
    }];
    
    [self.view addSubview:_textView];
}

@end
