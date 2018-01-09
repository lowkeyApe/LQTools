//
//  UIColor+LQSetColor.h
//  LQTools
//
//  Created by lowkeyApe on 2018/1/9.
//

#import <UIKit/UIKit.h>
typedef struct lqrbgColor{
    float Red;
    float Green;
    float Blue;
}LQRBG;

//编译器支持的话为static inline 内联函数 不支持为static 静态全局
CG_INLINE
LQRBG LQRBGMake(float Red,float Green,float Blue){
    LQRBG loc; loc.Red = Red; loc.Green = Green ;loc.Blue = Blue; return loc;
}
@interface UIColor (LQSetColor)

/**
 *  十六进制 设置颜色
*/
+ (UIColor *)lqHexColor:(NSString *)hexColor;


/**
 *  RBG值 设置颜色
 */
+ (UIColor*)lqRGBWithColor:(LQRBG)colorValue alpha:(CGFloat)alpha;

@end
