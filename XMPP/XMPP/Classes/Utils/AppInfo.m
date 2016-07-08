//
//  AppInfo.m
//  superwan
//
//  Created by kiefer on 14-9-22.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

// 应用程序版本号
+ (NSString *)version {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

// 应用程序名称
+ (NSString *)name {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

// 应用程序id
+ (NSString *)identifier {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleIdentifier"];
}

@end
