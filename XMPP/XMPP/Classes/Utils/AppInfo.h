//
//  AppInfo.h
//  superwan
//
//  Created by kiefer on 14-9-22.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

// 应用程序版本号
+ (NSString *)version;
// 应用程序名称
+ (NSString *)name;
// 应用程序id
+ (NSString *)identifier;

@end
