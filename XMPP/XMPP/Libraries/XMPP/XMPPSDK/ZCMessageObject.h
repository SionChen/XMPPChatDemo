//
//  ZCMessageObject.h
//  XMPPEncapsulation
//
//  Created by 超级腕电商 on 16/6/4.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMessageObject : NSObject
//来自哪里
@property (nonatomic,copy) NSString *messageFrom;
//发送给谁
@property (nonatomic,copy) NSString *messageTo;
//内容
@property (nonatomic,copy) NSString *messageContent;
//时间
@property (nonatomic,retain) NSDate *messageDate;
//类型
@property (nonatomic,copy) NSString *messageType;

//数据库增删改查
+(BOOL)save:(ZCMessageObject*)aMessage;

//获取最近联系人 pageIndex是读取多少条
+(NSMutableArray *)fetchRecentChatByPage:(int)pageIndex;

//更新类型，追加群主题
+(void)upDateType:(NSDictionary*)dic;
@end
