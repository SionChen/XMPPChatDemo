//
//  System.h
//  
//
//  Created by kiefer on 14-4-28.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface System : NSObject

// 调用系统自带phone
+ (void)callPhoneWithNumber:(NSString *)number;
// 调用系统自带SMS
+ (void)sendSMSWithNumber:(NSString *)number;
// 调用系统自带mail
+ (void)sendEmailWithAddress:(NSString *)address;
// 调用系统自带safari
+ (void)openBrowserWithURLString:(NSString *)URLString;
// 调用系统自带phone
+ (void)callPhoneNumber:(NSString *)number inView:(UIView *)superview;

@end
