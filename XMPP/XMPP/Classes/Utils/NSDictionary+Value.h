//
//  NSDictionary+Value.h
//  
//
//  Created by Kiefer on 13-4-2.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isDictionary(obj) (obj && [obj isKindOfClass:[NSDictionary class]] && ![obj isEqual:[NSNull null]])
#define isArray(obj)      (obj && [obj isKindOfClass:[NSArray class]] && ![obj isEqual:[NSNull null]])

@interface NSDictionary (Value)

- (NSString *)stringValueForKey:(id)aKey;
- (int)intValueForKey:(id)aKey;
- (float)floatValueForKey:(id)aKey;
- (double)doubleValueForKey:(id)aKey;
- (BOOL)boolValueForKey:(id)aKey;
- (NSInteger)integerValueForKey:(id)aKey;
- (long long)longLongValueForKey:(id)aKey;

@end
