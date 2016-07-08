//
//  NSString+Crypto.m
//  Framework-iOS
//
//  Created by Teng Kiefer on 12-7-9.
//  Copyright (c) 2012年 DB-Interactive. All rights reserved.
//

#import "NSString+Crypto.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+Crypto.h"

@implementation NSString (Crypto)

- (NSString *)MD5EncodedString {
	return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5EncodedString];
}

- (NSString *)URLEncodedUTF8String {
    if ([self length] > 0) {
        return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

- (NSString *)URLDecodedUTF8String {
    if ([self length] > 0) {
        return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key {
	return [[self dataUsingEncoding:NSUTF8StringEncoding] HMACSHA1EncodedDataWithKey:key];
}
//json串转字典
- (NSDictionary *)dictionaryFromJsonString
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    return dic;
}
//小数点后面有无值
-(NSString *)getPriceIntOrFloat
{
    if (self==nil) {
        return @"0";
    }
    NSArray * separateArray = [self componentsSeparatedByString:@"."];
    if (separateArray.count!=2) {
        return self;
    }
    if ([[separateArray lastObject] integerValue]>0) {
        return self;
    }
    return separateArray.firstObject;
}
@end
