//
//  Utilities.m
//  superwan
//
//  Created by kiefer on 15/8/27.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import "Utilities.h"
#import "NSString+Crypto.h"

@implementation Utilities

+ (NSAttributedString *)attributedText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName:textColor};
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:attrs];
    return attributedText;
}

+ (NSDate *)dateFromString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [formatter dateFromString:string];
    DBLOG(@"date %@", date);
    return date;
}

+ (NSString *)timeFromSeconds:(NSTimeInterval)secs {
    int s = round(secs);
    int days = s / 3600 / 24;
    int hours = s % (3600 * 24) / 3600;
    int minutes = s % (3600) / 60;
    int seconds = s % 60;
    
    NSString *res = [NSString stringWithFormat:@"%d天%02d:%02d:%02d", days, hours, minutes, seconds];
    if (days == 0) {
        res = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    return res;
}

+ (NSString *)spaceStringWithWidth:(CGFloat)width {
    NSMutableString *mString = [NSMutableString stringWithString:@""];
    CGFloat textWidth = 0.0;
    while (textWidth < width) {
        textWidth = [mString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]}].width;
        [mString appendString:@" "];
    }
    return mString;
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL res = false;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     res = true;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 res = true;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 res = true;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 res = true;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 res = true;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 res = true;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 res = true;
             }
         }
     }];
    return res;
}

+ (NSString *)lineBreakByTruncatingTail:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font {
    if (!string || ![string length]) return string;
    
    CGFloat width = [string sizeWithAttributes:@{NSFontAttributeName:font}].width;
    if (width <= maxWidth) return string;
    
    NSString *substring = @"";
    for (int i = 1; i <= [string length]; i++) {
        substring = [string substringToIndex:i];
        CGFloat subwidth = [substring sizeWithAttributes:@{NSFontAttributeName:font}].width;
        if (subwidth > maxWidth) {
            substring = [NSString stringWithFormat:@"%@...", [string substringToIndex:i - 1]];
            return substring;
        }
    }
    return string;
}

+ (NSString *)dateTextFromTimestamp:(NSTimeInterval)secs {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *dateText = [formatter stringFromDate:date];
    return dateText;
}

+ (NSString *)remainingTimeFromTimestamp:(NSTimeInterval)timestamp {
    int secs = round(timestamp);
    int days = secs / 3600 / 24;
    int hours = secs % (3600 * 24) / 3600;
    int minutes = secs % (3600) / 60;
    
    NSString *res = [NSString stringWithFormat:@"%d天%02d时", days, hours];
    if (days == 0) {
        res = [NSString stringWithFormat:@"%02d时%02d分", hours, minutes];
    }
    return res;
}

+ (NSString *)URLEncodedKeyValuePair:(NSString *)key value:(NSString *)value {
    return [NSString stringWithFormat:@"%@=%@", [key URLEncodedUTF8String], [value URLEncodedUTF8String]];
}

@end
