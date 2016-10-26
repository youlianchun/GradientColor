//
//  GradientColor.h
//  GradientColor
//
//  Created by YLCHUN on 16/10/14.
//  Copyright © 2016年 ylchun. All rights reserved.
//  颜色渐变过渡色转换器

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GradientColor : NSObject

-(instancetype)init NS_UNAVAILABLE;

-(instancetype)initWithColorA:(UIColor *)colorA colorB:(UIColor *)colorB;

/**
 colorA 过渡到 colorB

 @param gradient 比例 [0.0 ... 1.0]
 */
-(UIColor *)colorAChangeToColorB:(CGFloat)gradient;

/**
 colorB 过渡到 colorA
 
 @param gradient 比例 [0.0 ... 1.0]
 */
-(UIColor *)ColorBChangeToColorA:(CGFloat)gradient;

@end
NS_ASSUME_NONNULL_END
