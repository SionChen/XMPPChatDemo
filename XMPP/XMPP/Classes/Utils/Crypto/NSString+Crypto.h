//
//  NSString+Crypto.h
//  Framework-iOS
//
//  Created by Teng Kiefer on 12-7-9.
//  Copyright (c) 2012年 DB-Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Crypto)

- (NSString *)MD5EncodedString;
- (NSString *)URLEncodedUTF8String;
- (NSString *)URLDecodedUTF8String;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;
- (NSDictionary *)dictionaryFromJsonString;
- (NSString *)getPriceIntOrFloat;
@end
