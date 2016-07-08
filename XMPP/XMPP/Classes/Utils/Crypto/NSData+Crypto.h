//
//  NSData+Crypto.h
//  Framework-iOS
//
//  Created by Teng Kiefer on 12-7-9.
//  Copyright (c) 2012年 DB-Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Crypto)

- (NSString *)MD5EncodedString;
- (NSString *)base64EncodedString;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;

@end
