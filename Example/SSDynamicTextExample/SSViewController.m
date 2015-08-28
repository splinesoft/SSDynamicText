//
//  SSViewController.m
//  SSLabelExample
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSViewController.h"
#import <SSDynamicText.h>

static NSString * const kLabelText = @"This label, text field, and text view all support custom fonts and respond to changes in preferred text size.\n\nSwitch to Settings.app, change your preferred text size, then switch back here.";

@interface SSViewController ()

@property (nonatomic, strong) SSDynamicLabel *label;
@property (nonatomic, strong) SSDynamicButton *button;
@property (nonatomic, strong) SSDynamicTextField *textField;
@property (nonatomic, strong) SSDynamicTextView *textView;
@property (nonatomic, assign) BOOL isAttributedTextCurrentlyDisplayed;

@end

@implementation SSViewController

- (void)changeTexts:(UIButton *)sender {
    if (self.isAttributedTextCurrentlyDisplayed) {
        [self displayNormalTexts];
    } else {
        [self displayAttributedTexts];
    }
    self.isAttributedTextCurrentlyDisplayed = !self.isAttributedTextCurrentlyDisplayed;
}

- (void)displayNormalTexts {
    self.label.dynamicAttributedText = nil;
    self.textField.dynamicAttributedText = nil;
    self.textView.dynamicAttributedText = nil;
    [self.button setAttributedTitle:nil forState:UIControlStateNormal];

    self.label.text = kLabelText;
    self.textView.text = @"Text View";
    [self.button setTitle:@"Change to attributed" forState:UIControlStateNormal];
}

- (void)setLabelAttributedTextWithFirstAttributes:(NSDictionary *)attributes secondAttributes:(NSDictionary *)secondAttributes {
    NSMutableAttributedString *labelText = [[NSMutableAttributedString alloc] initWithString:kLabelText
                                                                                  attributes:attributes];
    [labelText addAttributes:secondAttributes range:[kLabelText rangeOfString:@"change your preferred text size"]];

    self.label.dynamicAttributedText = labelText;
}

- (void)setTextFieldAttributedTextWithFirstAttributes:(NSDictionary *)attributes secondAttributes:(NSDictionary *)secondAttributes {
    NSString *textFieldString = @"TextField support";
    NSMutableAttributedString *textFieldText = [[NSMutableAttributedString alloc] initWithString:textFieldString
                                                                                      attributes:attributes];
    [textFieldText addAttributes:secondAttributes range:[textFieldString rangeOfString:@"TextField"]];
    self.textField.dynamicAttributedText = textFieldText;
}

- (void)setTextViewAttributedTextWithFirstAttributes:(NSDictionary *)attributes secondAttributes:(NSDictionary *)secondAttributes {
    NSString *textViewString = @"I hope this also works for TextView";
    NSMutableAttributedString *textViewText = [[NSMutableAttributedString alloc] initWithString:textViewString
                                                                                     attributes:attributes];
    [textViewText addAttributes:secondAttributes range:[textViewString rangeOfString:@"works for TextView"]];
    self.textView.dynamicAttributedText = textViewText;
}

- (void)setButtonAttributedTextWithFirstAttributes:(NSDictionary *)attributes secondAttributes:(NSDictionary *)secondAttributes {
    NSString *buttonString = @"Change to normal";
    NSMutableAttributedString *buttonText = [[NSMutableAttributedString alloc] initWithString:buttonString
                                                                                   attributes:attributes];
    [buttonText addAttributes:secondAttributes range:[buttonString rangeOfString:@"normal"]];
    [self.button setAttributedTitle:buttonText forState:UIControlStateNormal];
}

- (void)displayAttributedTexts {
    self.label.text = nil;
    self.textField.text = nil;
    self.textView.text = nil;

    NSDictionary *attributes =
    @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};

    NSDictionary *secondAttributes =
    @{NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName: [UIFont fontWithName:@"Courier" size:25.0f]};

    [self setLabelAttributedTextWithFirstAttributes:attributes secondAttributes:secondAttributes];
    [self setTextFieldAttributedTextWithFirstAttributes:attributes secondAttributes:secondAttributes];
    [self setTextViewAttributedTextWithFirstAttributes:attributes secondAttributes:secondAttributes];
    [self setButtonAttributedTextWithFirstAttributes:attributes secondAttributes:secondAttributes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.label = [SSDynamicLabel labelWithFont:@"Courier" baseSize:16.0f];
    self.label.textColor = [UIColor darkGrayColor];
    self.label.numberOfLines = 0;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.label setFrame:(CGRect){
        {10, 25},
        {CGRectGetWidth(self.view.frame) - 20, 220}
    }];
    
    [self.view addSubview:self.label];

    self.button = [SSDynamicButton buttonWithFont:@"Courier" baseSize:16.0f];
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor lightGrayColor];
    [self.button setFrame:(CGRect){
        {10, CGRectGetMaxY(self.label.frame) + 10},
        {CGRectGetWidth(self.view.frame) - 20, 44}
    }];
    [self.button addTarget:self action:@selector(changeTexts:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.button];

    self.textField = [SSDynamicTextField textFieldWithFont:@"Courier"
                                              baseSize:15.0f];
    self.textField.textColor = [UIColor darkGrayColor];
    self.textField.backgroundColor = [UIColor lightGrayColor];
    self.textField.placeholder = @"Text Field";
    [self.textField setFrame:(CGRect){
        {10, CGRectGetMaxY(self.button.frame) + 10},
        {CGRectGetWidth(self.view.frame) - 20, 32}
    }];
    
    [self.view addSubview:self.textField];
    
    self.textView = [SSDynamicTextView textViewWithFont:@"Courier"
                                           baseSize:15.0f];
    self.textView.textColor = [UIColor redColor];
    self.textView.backgroundColor = [UIColor lightGrayColor];
    [self.textView setFrame:(CGRect){
        {10, CGRectGetMaxY(self.textField.frame) + 10},
        {CGRectGetWidth(self.view.frame) - 20, 100}
    }];
    
    [self.view addSubview:self.textView];

    [self displayNormalTexts];
}

@end
