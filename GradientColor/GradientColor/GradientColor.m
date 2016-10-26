//
//  GradientColor.m
//  GradientColor
//
//  Created by YLCHUN on 16/10/14.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "GradientColor.h"

static const NSUInteger R = 0;
static const NSUInteger G = 1;
static const NSUInteger B = 2;
static const NSUInteger A = 3;

@interface GradientColor ()
@property (nonatomic) NSArray *deltaRGB;
@property (nonatomic) NSArray *aColorRgb;
@property (nonatomic) NSArray *bColorRgb;

@property(nonatomic)UIColor *colorA;
@property(nonatomic)UIColor *colorB;

@end

@implementation GradientColor


-(instancetype)initWithColorA:(UIColor *)colorA colorB:(UIColor *)colorB {
    self = [super init];
    if (self) {
        self.colorA = colorA;
        self.colorB = colorB;
    }
    return self;
}

-(UIColor *)colorAChangeToColorB:(CGFloat)gradient {
    UIColor *color = self.colorA;
    if (gradient >= 1.0) {
        color = self.colorB;
    }
    if (gradient > 0.0 && gradient < 1.0) {
        color = [UIColor colorWithRed:[self.aColorRgb[R] floatValue] - [self.deltaRGB[R] floatValue] * gradient
                                green:[self.aColorRgb[G] floatValue] - [self.deltaRGB[G] floatValue] * gradient
                                 blue:[self.aColorRgb[B] floatValue] - [self.deltaRGB[B] floatValue] * gradient
                                alpha:[self.aColorRgb[A] floatValue] - [self.deltaRGB[A] floatValue] * gradient
                 ];
    }
     return color;
}

-(UIColor *)ColorBChangeToColorA:(CGFloat)gradient {
    UIColor *color = self.colorB;
    if (gradient >= 1.0) {
        color = self.colorA;
    }
    if (gradient > 0.0 && gradient < 1.0) {
        color = [UIColor colorWithRed:[self.bColorRgb[R] floatValue] + [self.deltaRGB[R] floatValue] * gradient
                                green:[self.bColorRgb[G] floatValue] + [self.deltaRGB[G] floatValue] * gradient
                                 blue:[self.bColorRgb[B] floatValue] + [self.deltaRGB[B] floatValue] * gradient
                                alpha:[self.bColorRgb[A] floatValue] + [self.deltaRGB[A] floatValue] * gradient
                 ];
    }
    return color;
}

- (NSArray *)deltaRGB {
    if (_deltaRGB == nil) {
        NSArray *bColorRgb = self.bColorRgb;
        NSArray *aColorRgb = self.aColorRgb;
        NSArray *delta;
        if (bColorRgb && aColorRgb) {
            CGFloat deltaR = [aColorRgb[R] floatValue] - [bColorRgb[R] floatValue];
            CGFloat deltaG = [aColorRgb[G] floatValue] - [bColorRgb[G] floatValue];
            CGFloat deltaB = [aColorRgb[B] floatValue] - [bColorRgb[B] floatValue];
            CGFloat deltaA = [aColorRgb[A] floatValue] - [bColorRgb[A] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
            _deltaRGB = delta;
        }
    }
    return _deltaRGB;
}

-(NSArray *)aColorRgb {
    if (!_aColorRgb) {
        NSArray *aColorRgb = [self getColorRGBA:self.colorA];
        _aColorRgb = aColorRgb;
    }
    return _aColorRgb;
}

-(NSArray *)bColorRgb {
    if (!_bColorRgb) {
        NSArray *bColorRgb = [self getColorRGBA:self.colorB];
        _bColorRgb = bColorRgb;
    }
    return _bColorRgb;
}

- (NSArray *)getColorRGBA:(UIColor *)color {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    BOOL b = [color getRed:&red green:&green blue:&blue alpha:&alpha];
    NSAssert(b, @"can’t get RGBA from this color");
    
    NSArray *rgbComponents;
    //    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    //    if (numOfcomponents == 4) {
    //        const CGFloat *components = CGColorGetComponents(color.CGColor);
    //        rgbComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), nil];
    //    }
    if (b) {
        rgbComponents = [NSArray arrayWithObjects:@(red), @(green), @(blue), @(alpha), nil];
    }
    return rgbComponents;
}
@end
