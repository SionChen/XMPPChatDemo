//
//  CommonUI.h
//  
//
//  Created by kiefer on 13-12-11.
//  Copyright (c) 2013年 kiefer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUI : NSObject

+ (UIBarButtonItem *)rightBarBtnItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
//
+ (UIButton *)rightButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
