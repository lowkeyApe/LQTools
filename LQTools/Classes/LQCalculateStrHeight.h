//
//  LQCalculateStrHeight.h
//  Mixshq
//
//  Created by Macx on 2017/6/16.
//  Copyright © 2017年 shqshqshq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQCalculateStrHeight : NSObject
/**计算字符串的高度
 @str       文本内容
 @fontSize  字体大小
 @width     显示控件的宽度
 */
+(float)lqCalculateStrHeightWithString:(NSString *)str fontSize:(CGFloat)fontSize showWidth:(CGFloat)width;
/**计算字符串的宽度
 @str       文本内容
 @fontSize  字体大小
 @height     显示控件的高度
 */
+(float)lqCalculateStrWidthWithString:(NSString *)str fontSize:(CGFloat)fontSize showHeight:(CGFloat)height;

@end
