//
//  SSDynamicsView.h
//  SSDynamicTextExample
//
//  Created by Remigiusz Herba on 31/08/15.
//  
//

#import <UIKit/UIKit.h>
#import <SSDynamicText.h>

@interface SSDynamicsView : UIView

@property (weak, nonatomic) IBOutlet SSDynamicLabel *label;
@property (weak, nonatomic) IBOutlet SSDynamicTextField *textField;
@property (weak, nonatomic) IBOutlet SSDynamicTextView *textView;
@property (weak, nonatomic) IBOutlet SSDynamicButton *button;

@end
