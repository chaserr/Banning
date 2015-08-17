//
//  NSDate+TX_timeFormat.m
//  Banning
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "NSDate+TX_timeFormat.h"

@implementation NSDate (TX_timeFormat)

// 只显示年月日
+ (NSString *)show_zh_CN_time{

    NSDate *nowTime = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateStyle = kCFDateFormatterFullStyle; // 日期格式
//    dateFormat.timeStyle = kCFDateFormatterMediumStyle;
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString = [dateFormat stringFromDate:nowTime];
    
    return dateString;
    
}

// 显示年月日时分秒
+ (NSString *)show_zh_CN_accurateTime{
    
    NSDate *nowTime = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateStyle = kCFDateFormatterFullStyle; // 日期格式
    dateFormat.timeStyle = kCFDateFormatterMediumStyle;
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString = [dateFormat stringFromDate:nowTime];
    
    return dateString;
    
}

// 时间转化为时间戳
- (NSString *)changeDateToString:(NSDate *)date{

    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeString;
}

// 时间戳转化为时间
- (NSDate *)changeStringToDate:(NSString *)string{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([string doubleValue])];
    return date;
}

@end
