//
//  SSDynamicAttributedTextSizable.h
//  Pods
//
//  Created by Remigiusz Herba on 15/09/15.
//
//

#import <Foundation/Foundation.h>

@protocol SSDynamicAttributedTextSizable <NSObject>

/*
 TextView and TextField sometimes calls setAttributedText even when se work with normal Text. 
 Framework is using it under the hood sometimes after layouts or even setText calls it. Because of that we cannot override
 default attributeText setter to change font, sometimes it change font at random.
 */

@property (nonatomic, copy) NSAttributedString *dynamicAttributedText;

@end
