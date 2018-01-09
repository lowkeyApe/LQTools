//
//  UIColor+LQSetColor.m
//  LQTools
//
//  Created by 谢双艰 on 2018/1/9.
//

#import "UIColor+LQSetColor.h"

@implementation UIColor (LQSetColor)

+ (UIColor *)lqHexColor:(NSString *)hexColor{
    if ([hexColor length] < 6) {
        return nil;
    }
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.f) green:(float)(green / 255.f) blue:(float)(blue / 255.f) alpha:1.f];
}

+ (UIColor*)lqRGBWithColor:(LQRBG)LQRBG alpha:(CGFloat)alpha{
    
    UIColor *color = [UIColor colorWithRed:LQRBG.Red/255.0 green:LQRBG.Green/255.0 blue:LQRBG.Blue/255.0 alpha:alpha];
    
    
    return color;
}

@end
