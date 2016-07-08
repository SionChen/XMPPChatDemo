//
//  DataStore.m
//  XMPP
//
//  Created by 超级腕电商 on 16/7/8.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

+ (DataStore *)sharedStore
{
    static DataStore *mInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        mInstance = [[DataStore alloc] init];
    });
    return mInstance;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setAddress:(NSString *)address
{
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"address"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)address
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    return string ? string : @"";
}

-(void)setMyXmppJid:(NSString *)myXmppJid
{
    [[NSUserDefaults standardUserDefaults] setObject:myXmppJid forKey:@"myXmppJid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)myXmppJid
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"myXmppJid"];
    return string ? string : @"";
}


-(void)setNickName:(NSString *)nickName
{
    [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)nickName
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    return string ? string : @"";
}

-(void)setHeaderImage:(NSString *)headerImage
{
    [[NSUserDefaults standardUserDefaults] setObject:headerImage forKey:@"headerImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)headerImage
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
    return string ? string : @"";
}

-(void)setBirthday:(NSString *)birthday
{
    [[NSUserDefaults standardUserDefaults] setObject:birthday forKey:@"birthday"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)birthday
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"birthday"];
    return string ? string : @"";
}

-(void)setSex:(NSString *)sex
{
    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)sex
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
    return string ? string : @"";
}

-(void)setPhoneNum:(NSString *)phoneNum
{
    [[NSUserDefaults standardUserDefaults] setObject:phoneNum forKey:@"phoneNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)phoneNum
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"];
    return string ? string : @"";
}


-(void)setMyXmppPassword:(NSString *)myXmppPassword
{
    [[NSUserDefaults standardUserDefaults] setObject:myXmppPassword forKey:@"myXmppPassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)myXmppPassword
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"myXmppPassword"];
    return string ? string : @"";
}


-(void)setPersonalSign:(NSString *)personalSign
{
    [[NSUserDefaults standardUserDefaults] setObject:personalSign forKey:@"personalSign"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)personalSign
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"personalSign"];
    return string ? string : @"";
}

-(void)cleanData
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"myXmppJid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"headerImage"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"birthday"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"phoneNum"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"myXmppPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"personalSign"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"address"];

}

@end
