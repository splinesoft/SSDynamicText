SSDynamicText
=============

[![Build Status](https://travis-ci.org/splinesoft/SSDynamicText.png?branch=master)](https://travis-ci.org/splinesoft/SSDynamicText)
 
iOS 7's [`UIFontDescriptor`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIFontDescriptor_Class/) is pretty neat. Also pretty neat is dynamic text that responds to the preferred text size that the user specified in Settings.app.

What's not so neat, though, is that `+[UIFont preferredFontForTextStyle:]` only works with the system font, Helvetica Neue. What if you have custom fonts and want to respect the user's text size preference?

Enter SSDynamicText, a collection of simple `UILabel`, `UITextField`, and `UITextView` subclasses inspired by [this](http://stackoverflow.com/questions/18758227/ios7-can-we-use-other-than-helvetica-neue-fonts-with-dynamic-type/19024944#19024944) SO answer.

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


## Thanks!

`SSDynamicText` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))
