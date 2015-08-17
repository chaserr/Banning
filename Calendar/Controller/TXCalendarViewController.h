//
//  TXCalendarViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
@interface TXCalendarViewController : UIViewController<UIScrollViewDelegate,FSCalendarDataSource,FSCalendarDelegate>

@property (strong, nonatomic) IBOutlet FSCalendar *calendar;

@property (assign, nonatomic) NSInteger      theme;
@property (assign, nonatomic) FSCalendarFlow flow;
@property (assign, nonatomic) BOOL           lunar;
@property (copy,   nonatomic) NSDate         *selectedDate;
@property (assign, nonatomic) NSUInteger     firstWeekday;

@end
