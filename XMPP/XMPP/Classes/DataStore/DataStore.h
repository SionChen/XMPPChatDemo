//
//  DataStore.h
//  XMPP
//
//  Created by 超级腕电商 on 16/7/8.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

+ (DataStore *)sharedStore;

//用户名
@property(nonatomic,copy)NSString * myXmppJid;
//昵称
@property(nonatomic,copy)NSString * nickName;
//头像 base 64
@property(nonatomic)NSString * headerImage;
//生日
@property(nonatomic,copy)NSString * birthday;
//性别
@property(nonatomic,copy)NSString * sex;
//手机号
@property(nonatomic,copy)NSString * phoneNum;
//密码
@property(nonatomic,copy)NSString * myXmppPassword;
//签名
@property(nonatomic,copy)NSString * personalSign;
//地址
@property(nonatomic,copy)NSString * address;

-(void)cleanData;

@end
