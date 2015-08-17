//
//  NSDate+TX_timeFormat.h
//  Banning
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TX_timeFormat)

+ (NSString *)show_zh_CN_time;
/** 显示精确时间 */
+ (NSString *)show_zh_CN_accurateTime;

// 时间转化为时间戳
- (NSString *)changeDateToString:(NSDate *)date;

// 时间戳转化为时间
- (NSDate *)changeStringToDate:(NSString *)string;
@end
