//
//  System.m
//  superwan
//
//  Created by kiefer on 14-4-28.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//

#import "System.h"

@implementation System

// 调用系统自带phone
+ (void)callPhoneWithNumber:(NSString *)number {
    if (!number || ![number length]) return;
    
    NSString *URLString = [NSString stringWithFormat:@"tel://%@", number];
    NSURL *url = [NSURL URLWithString:URLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

// 调用系统自带SMS
+ (void)sendSMSWithNumber:(NSString *)number {
    if (!number || ![number length]) return;
    
    NSString *URLString = [NSString stringWithFormat:@"sms://%@", number];
    NSURL *url = [NSURL URLWithString:URLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    UIPageControl *page = [[UIPageControl alloc] init];
}

// 调用系统自带mail
+ (void)sendEmailWithAddress:(NSString *)address {
    if (!address || ![address length]) return;
    
    NSString *URLString = [NSString stringWithFormat:@"mailto://%@", address];
    NSURL *url = [NSURL URLWithString:URLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

// 调用系统自带safari
+ (void)openBrowserWithURLString:(NSString *)URLString {
    if (URLString && ![URLString hasPrefix:@"http://"]) {
        URLString = [NSString stringWithFormat:@"http://%@", URLString];
    }
    
    NSURL *url = [NSURL URLWithString:URLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

// 调用系统自带的电话
+ (void)callPhoneNumber:(NSString *)number inView:(UIView *)superview {
    if (!number || ![number length]) return;
    
    NSString *string = [NSString stringWithFormat:@"%@", number];
    if ([string rangeOfString:@"-"].location != NSNotFound) {
        string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"tel://%@", string];
    
    UIWebView *callView =[[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:urlString];
    [callView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [superview addSubview:callView];
}

@end
