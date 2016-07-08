//
//  NSDictionary+Value.m
//
//
//  Created by Kiefer on 13-4-2.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "NSDictionary+Value.h"

@implementation NSDictionary (Value)

- (NSString *)stringValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([NSNull null] == (NSNull*)object) {
        return @"";
    }
    if (!object || [object isEqual:@"null"]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", object];
}

- (int)intValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([NSNull null] == (NSNull*)object) {
        return 0;
    }
    return [object intValue];
}

- (float)floatValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([NSNull null] == (NSNull*)object) {
        return 0;
    }
    return [object floatValue];
}

- (double)doubleValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([NSNull null] == (NSNull*)object) {
        return 0;
    }
    return [object doubleValue];
}

- (BOOL)boolValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([NSNull null] == (NSNull*)object) {
        return false;
    }
    return [object boolValue];
}

- (NSInteger)integerValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([NSNull null] == (NSNull*)object) {
        return 0;
    }
    return [object integerValue];
}

- (long long)longLongValueForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([NSNull null] == (NSNull*)object) {
        return 0;
    }
    return [object longLongValue];
}

@end
