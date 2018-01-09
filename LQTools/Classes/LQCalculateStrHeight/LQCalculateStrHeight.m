//
//  LQCalculateStrHeight.m
//  Mixshq
//
//  Created by Macx on 2017/6/16.
//  Copyright © 2017年 shqshqshq. All rights reserved.
//

#import "LQCalculateStrHeight.h"

@implementation LQCalculateStrHeight

+(float)lqCalculateStrHeightWithString:(NSString *)str fontSize:(CGFloat)fontSize showWidth:(CGFloat)width{
    CGSize infoSize = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect infoRect = [str boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return infoRect.size.height;
    
}

+(float)lqCalculateStrWidthWithString:(NSString *)str fontSize:(CGFloat)fontSize showHeight:(CGFloat)height{
    CGSize infoSize = CGSizeMake(CGFLOAT_MAX, height);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect infoRect = [str boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return infoRect.size.width;
}

@end
