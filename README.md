SSLabel
=============

[![Build Status](https://travis-ci.org/splinesoft/SSLabel.png?branch=master)](https://travis-ci.org/splinesoft/SSLabel)

iOS 7's [`UIFontDescriptor`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIFontDescriptor_Class/) is pretty neat. Also pretty neat is dynamic text that responds to the preferred text size that the user specified in Settings.app.

What's not so neat, though, is that `+[UIFont preferredFontForTextStyle:]` only works with the system font, Helvetica Neue. What if you have custom fonts and want to respect the user's text size preference?

Enter `SSLabel`, a simple `UILabel` subclass inspired by [this](http://stackoverflow.com/questions/18758227/ios7-can-we-use-other-than-helvetica-neue-fonts-with-dynamic-type/19024944#19024944) SO answer.

## Install

Install with [Cocoapods](http://cocoapods.org). Add to your podfile:

```
pod 'SSLabel', :head # YOLO
```

## SSLabel

Check out `Example` for a full example.

```objc

/**
 * Create a dynamic auto-sizing label using a custom font and a base font size.
 * The font size will be adjusted up (or down) based on the user's preferred size.
 * If the user leaves the app, switches to Settings, and changes preferred size,
 * the label will automatically update its size when the app returns to foreground.
 */
SSLabel *myLabel = [SSLabel labelWithFont:@"Courier" 
                                 baseSize:16.0f];
myLabel.text = @"Auto-sizing text!";
                                                       
// Already have a font descriptor?
UIFontDescriptor *aDescriptor = [UIFontDescriptor fontDescriptorWithName:@"Courier"
                                                                    size:16.0f];
SSLabel *otherLabel = [SSLabel labelWithFontDescriptor:aDescriptor];
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
 * You probably don't need to use this directly; rather as a part of UIFont+SSTextSize.
 */
NSInteger textDelta = [[UIApplication sharedApplication] preferredFontSizeDelta];
```


## Thanks!

`SSLabel` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))
