//
//  AlertMessage.m
//  superwan
//
//  Created by kiefer on 14-4-3.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//

#import "AlertMessage.h"

@implementation AlertMessage

+ (void)showMessage:(NSString *)message {
    [AlertMessage showMessage:message title:nil buttonTitle:@"确定"];
}

+ (void)showMessage:(NSString *)message title:(NSString *)title {
    [AlertMessage showMessage:message title:title buttonTitle:nil];
}

+ (void)showMessage:(NSString *)message
                tag:(NSInteger)tag
           delegate:(id<UIAlertViewDelegate>)delegate {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView setTag:tag];
    [alertView show];
}

+ (void)showMessage:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    [AlertMessage showMessage:message title:nil buttonTitle:buttonTitle];
}

+ (void)showMessage:(NSString *)message buttonTitle:(NSString *)buttonTitle delegate:(id<UIAlertViewDelegate>)delegate {
    [AlertMessage showMessage:message title:nil buttonTitle:buttonTitle delegate:delegate];
}

+ (void)showMessage:(NSString *)message
              title:(NSString *)title
        buttonTitle:(NSString *)buttonTitle {
    [AlertMessage showMessage:message title:title buttonTitle:buttonTitle delegate:nil];
}

+ (void)showMessage:(NSString *)message
              title:(NSString *)title
        buttonTitle:(NSString *)buttonTitle
           delegate:(id<UIAlertViewDelegate>)delegate {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:buttonTitle
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

@end
