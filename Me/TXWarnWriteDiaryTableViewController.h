//
//  TXWarnWriteDiaryTableViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXWarnWriteDiaryTableViewController : UITableViewController

/** 调用本地通知 */
- (void)scheduleLocalNotificationWithDate:(NSDate *)fireDate;

@end
