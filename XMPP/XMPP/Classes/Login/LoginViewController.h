//
//  LoginViewController.h
//  XMPP
//
//  Created by 超级腕电商 on 16/7/7.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "SPViewController.h"

@interface LoginViewController : SPViewController
@property (nonatomic)BOOL isPresent;
@property (nonatomic,strong)void(^Update)(void);

@end
