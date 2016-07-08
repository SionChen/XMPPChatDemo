//
//  Utilities.h
//  superwan
//
//  Created by kiefer on 15/8/27.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (NSAttributedString *)attributedText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;

+ (NSDate *)dateFromString:(NSString *)string;
/**
 *  时间转换（0天00:00:00）
 *
 *  @param secs 秒数
 *
 */
+ (NSString *)timeFromSeconds:(NSTimeInterval)secs;

/**
 *  空格字符串
 *
 *  @param width 字符串长度
 *
 */
+ (NSString *)spaceStringWithWidth:(CGFloat)width;

/**
 *  过滤表情符号
 *
 *  @param string 字符串
 *
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  根据最大长度截断字符串 在行尾加上...
 *
 *  @param string   字符串
 *  @param maxWidth 最大长度
 *  @param font     字体大小
 *
 *  @return string
 */
+ (NSString *)lineBreakByTruncatingTail:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font;
+ (NSString *)dateTextFromTimestamp:(NSTimeInterval)secs;
+ (NSString *)remainingTimeFromTimestamp:(NSTimeInterval)timestamp;
+ (NSString *)URLEncodedKeyValuePair:(NSString *)key value:(NSString *)value;

@end
