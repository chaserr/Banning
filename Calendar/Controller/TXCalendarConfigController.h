//
//  TXCalendarConfigController.h
//  Banning
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXCalendarViewController.h"
@interface TXCalendarConfigController : UITableViewController
@property (strong, nonatomic) TXCalendarViewController *viewController;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@end
