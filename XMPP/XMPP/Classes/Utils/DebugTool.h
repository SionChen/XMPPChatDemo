//
//  DebugTool.h
//  Framework-iOS
//
//  Created by cztv on 12-11-1.
//  Copyright (c) 2012年 cztv. All rights reserved.
//

#ifdef DEBUG

#define DBLOG(...)		       NSLog(__VA_ARGS__)
#define DBLOG_RECT(rect)       NSLog(@"%@", NSStringFromCGRect(rect))
#define DBLOG_SIZE(size)       NSLog(@"%@", NSStringFromCGSize(size))
#define DBLOG_INSETS(insets)   NSLog(@"%@", NSStringFromUIEdgeInsets(insets))
#define DBLOG_POINT(point)     NSLog(@"%@", NSStringFromCGPoint(point))
#define DBLOG_RANGE(range)     NSLog(@"%@", NSStringFromRange(range))
#define DBLOG_FUNNAME          NSLog(@"%@", NSStringFromSelector(_cmd))
#define DBLOG_FUN		       NSLog(@"%s", __FUNCTION__)
#define DBLOG_OBJ(obj)	       NSLog(@"%@", obj)

#else

#define DBLOG(...)		       
#define DBLOG_RECT(rect)       
#define DBLOG_SIZE(size)       
#define DBLOG_INSETS(insets)   
#define DBLOG_POINT(point)     
#define DBLOG_RANGE(range)     
#define DBLOG_FUNNAME          
#define DBLOG_FUN		       
#define DBLOG_OBJ(obj)	       

#endif