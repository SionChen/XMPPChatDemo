//
//  Constants.h
//  superwan
//
//  Created by kiefer on 13-11-6.
//  Copyright (c) 2013年 windo-soft. All rights reserved.
//

#ifndef ___Constants_h
#define ___Constants_h

typedef void (^didSuccessBlock)(BOOL success);

////////////////////////////////////////////////////////////////////////////////////////////////////
// 支付类型枚举
typedef NS_ENUM(NSInteger, PayMode) {
    PayModeUnionPay = 1, //银联
    PayModeAlipay = 2, //支付宝
    PayModeWxpay = 3, //微信
};

// 显示模式枚举
typedef NS_ENUM(NSInteger, DisplayMode) {
    DisplayModeList = 1, //列表
    DisplayModeGrid = 2, //格子
};

////////////////////////////////////////////////////////////////////////////////////////////////////

#define ALERT_TAG_NOTLOGIN      1000
#define ALERT_TAG_CANCEL        3000
#define ALERT_TAG_DELETE        3001
#define ALERT_TAG_CONFIRM       3002
#define ALERT_TAG_NOADDRESS     3003
#define ALERT_TAG_SUCCESS       3004
#define ALERT_TAG_ERROR         3005
#define ALERT_TAG_PASSWORD      3006
#define ALERT_TAG_APPSTORE      3010
#define ALERT_TAG_NOTIFICATION  3011

////////////////////////////////////////////////////////////////////////////////////////////////////

#define RSP_SUCCESS             200 //成功
#define RSP_ERROR               300 //错误
#define RSP_ERROR_LOGIN_EXPIRE  301 //需要登录

////////////////////////////////////////////////////////////////////////////////////////////////////

#define FONT_HWXH(fontSize) [UIFont fontWithName:@"STHeitiTC-Light" size:fontSize]

////////////////////////////////////////////////////////////////////////////////////////////////////

#define color_back      [UIColor colorWithHex:0xebebeb] //背景颜色
#define color_head      [UIColor colorWithHex:0xE8E8E8] //标题颜色
#define color_lightGray [UIColor colorWithHex:0xa5a6a7]
#define color_bottom    [UIColor colorWithHex:0x141414] //底部栏背景色
#define color_topBar    RGB(40, 42, 44);
#define color_bottomBar RGB(40, 42, 44);
#define color_gray      [UIColor colorWithHex:0x808080]
#define color_red       [UIColor colorWithHex:0xb12704]
#define color_banner    [UIColor colorWithHex:0xD7D8DA] //图片颜色
#define color_border    [UIColor colorWithHex:0xe1e1e1] //边框颜色
#define color_line      [UIColor colorWithHex:0xe0e0e0] //线条颜色

////////////////////////////////////////////////////////////////////////////////////////////////////

static NSString *const kCartStatusDidChangeNotification = @"kCartStatusDidChangeNotification";
static NSString *const kOrderStatusDidChangeNotification = @"kOrderStatusDidChangeNotification";
static NSString *const kHomeNeedRefreshNotification = @"kHomeNeedRefreshNotification";

static const int pageSize = 20;

////////////////////////////////////////////////////////////////////////////////////////////////////

// 友盟
#define UMengSdkAppKey @"55fb8442e0f55ab05f003bc9"
// 微信
#define WXAppID     @"wxf2aa8fe2f9659781"
#define WXAppSecret @"3eace3600dae94917302ef4379a6a552"
// 新浪微博
#define WBAppID     @"2165361416"
#define WBAppSecret @"618e067f66cff99d2c3dd0a53c27a87a"
// 支付宝回调
#define AlipayCallBackURLScheme @"alipayschemechaojiwan"

#endif
