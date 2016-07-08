//
//  UIFont+FIt.m
//  Project
//
//  Created by 超级腕电商 on 16/5/10.
//  Copyright © 2016年 super. All rights reserved.
//

#import "UIFont+FIt.h"

@implementation UIFont (FIt)

//默认iPhone6的size  仅支持5、6、6p
+(UIFont *)systemFitFoutOfSize:(CGFloat)fontSize
{
    
    CGFloat size = 0;
    DBLOG_SIZE([[UIScreen mainScreen] currentMode].size);
    if (iPhone6) {
        size = fontSize;
    }
    if (iPhone5) {
        size = fontSize*(640.0/750);
    }
    if (iPhone6P) {
        size = fontSize*(1080.0/750);
    }
    return [UIFont systemFontOfSize:size];
}

//黑体 
+(UIFont *)boldSystemFitFoutOfSize:(CGFloat)fontSize
{
    CGFloat size = 0;
    DBLOG_SIZE([[UIScreen mainScreen] currentMode].size);
    if (iPhone6) {
        size = fontSize;
    }
    if (iPhone5) {
        size = fontSize*(640.0/750);
    }
    if (iPhone6P) {
        size = fontSize*(1080.0/750);
    }
    return [UIFont boldSystemFontOfSize:size];
}
@end
