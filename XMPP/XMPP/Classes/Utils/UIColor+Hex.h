//
//  UIColor+Hex.h
//
//  Created by kiefer on 14-4-3.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha;
+ (UIColor *)colorWithHex:(long)hexValue;
+ (UIColor *)colorWithHex:(long)hexValue alpha:(float)alpha;
+ (UIImage *)imageFromColor:(UIColor *)color;//颜色生成图片
@end