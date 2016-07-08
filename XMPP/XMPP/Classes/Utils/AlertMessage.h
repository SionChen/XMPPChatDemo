//
//  AlertMessage.h
//  superwan
//
//  Created by kiefer on 14-4-3.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertMessage : NSObject

+ (void)showMessage:(NSString *)message;

+ (void)showMessage:(NSString *)message
              title:(NSString *)title;

+ (void)showMessage:(NSString *)message
              title:(NSString *)title
        buttonTitle:(NSString *)buttonTitle;

+ (void)showMessage:(NSString *)message
                tag:(NSInteger)tag
           delegate:(id<UIAlertViewDelegate>)delegate;

+ (void)showMessage:(NSString *)message
        buttonTitle:(NSString *)buttonTitle;

+ (void)showMessage:(NSString *)message
        buttonTitle:(NSString *)buttonTitle
           delegate:(id<UIAlertViewDelegate>)delegate;

+ (void)showMessage:(NSString *)message
              title:(NSString *)title
        buttonTitle:(NSString *)buttonTitle
           delegate:(id<UIAlertViewDelegate>)delegate;

@end
