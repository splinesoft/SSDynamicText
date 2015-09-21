SSDynamicText
=============

[![Circle CI](https://circleci.com/gh/splinesoft/SSDynamicText.svg?style=svg)](https://circleci.com/gh/splinesoft/SSDynamicText) [![codecov.io](http://codecov.io/github/splinesoft/SSDynamicText/coverage.svg?branch=master)](http://codecov.io/github/splinesoft/SSDynamicText?branch=master)
 
iOS 7's [`UIFontDescriptor`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIFontDescriptor_Class/) is pretty neat. Also pretty neat is dynamic text that responds to the preferred text size that the user specified in Settings.app.

What's not so neat, though, is that `+[UIFont preferredFontForTextStyle:]` only works with the system font, Helvetica Neue. What if you have custom fonts and want to respect the user's text size preference?

SSDynamicText is a collection of simple `UILabel`, `UIButton`, `UITextField`, and `UITextView` subclasses inspired by [this](http://stackoverflow.com/questions/18758227/ios7-can-we-use-other-than-helvetica-neue-fonts-with-dynamic-type/19024944#19024944) SO answer.

## Install

Install with [CocoaPods](http://cocoapods.org). Add to your `Podfile`:

```
pod 'SSDynamicText', :head # YOLO
```

## SSDynamicLabel

A label that responds when the user changes her preferred text size. Check out `Example` for a full example.

```objc

/**
 * Create a dynamic auto-sizing label using a custom font and a base font size.
 * The font size will be adjusted up (or down) based on the user's preferred size.
 * If the user leaves the app, switches to Settings, and changes preferred size,
 * the label will automatically update its size when the app returns to foreground.
 */
SSDynamicLabel *myLabel = [SSDynamicLabel labelWithFont:@"Courier" 
                                               baseSize:16.0f];
myLabel.text = @"Auto-sizing text!";
                                                       
// Already have a font descriptor?
UIFontDescriptor *aDescriptor = [UIFontDescriptor fontDescriptorWithName:@"Courier"
                                                                    size:16.0f];
SSDynamicLabel *otherLabel = [SSDynamicLabel labelWithFontDescriptor:aDescriptor];
```

## SSDynamicButton

A button with a title label that responds when the user changes her preferred text size. Check out `Example` for a full example.

```objc

/**
 * Create a dynamic auto-sizing button using a custom font and a base font size.
 * The font size will be adjusted up (or down) based on the user's preferred size.
 * If the user leaves the app, switches to Settings, and changes preferred size,
 * the button will automatically update its size when the app returns to foreground.
 */
SSDynamicButton *myButton = [SSDynamicButton buttonWithFont:@"Courier" 
                                                   baseSize:16.0f];
[myButton setText:@"Auto-sizing text!" forControlState:UIControlStateNormal];                                     
```

## SSDynamicTextField

A text field that responds when the user changes her preferred text size. Check out `Example` for a full example.

```objc

/**
 * Create a dynamic auto-sizing text field using a custom font and a base font size.
 * The font size will be adjusted up (or down) based on the user's preferred size.
 * If the user leaves the app, switches to Settings, and changes preferred size,
 * the text field will automatically update its size when the app returns to foreground.
 */
SSDynamicTextField *myTextField = [SSDynamicTextField textFieldWithFont:@"Courier" 
                                                               baseSize:16.0f];
myTextField.text = @"Auto-sizing text!";
```

## SSDynamicTextView

A text view that responds when the user changes her preferred text size. Check out `Example` for a full example.

```objc

/**
 * Create a dynamic auto-sizing text view using a custom font and a base font size.
 * The font size will be adjusted up (or down) based on the user's preferred size.
 * If the user leaves the app, switches to Settings, and changes preferred size,
 * the text view will automatically update its size when the app returns to foreground.
 */
SSDynamicTextView *myTextView = [SSDynamicTextView textViewWithFont:@"Courier" 
                                                           baseSize:16.0f];
myTextView.text = @"Auto-sizing text!";
```

## UIFont+SSTextSize

```objc
/**
 * Create a UIFont object using the specified font name and base size.
 * The actual size of the returned font is adjusted by
 * the user's current preferred font size (specified in Settings.app).
 */
UIFont *myFont = [UIFont dynamicFontWithName:@"Courier" baseSize:16.0f];
```

## UIApplication+SSTextSize

```objc
/**
 * This property returns a numeric delta between the default size setting (Large)
 * and the user's current preferred text size.
 *
 * You probably don't need to use this directly.
 */
NSInteger textDelta = [[UIApplication sharedApplication] preferredFontSizeDelta];
```

## `NSAttributedString` Support

SSDynamicText supports attributed text, all you have to do is set your attributed text to new property dynamicAttributedText.

```objc
/*
TextView and TextField sometimes calls setAttributedText even when we work with normal Text. 
Framework is using it under the hood sometimes after layouts or even setText calls it. Because of that we cannot override
default attributeText setter to change font, sometimes it change font at random.
*/

@property (nonatomic, copy) NSAttributedString *dynamicAttributedText;
```

## Thanks!

`SSDynamicText` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))
