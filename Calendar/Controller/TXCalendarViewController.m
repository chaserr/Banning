//
//  TXCalendarViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXCalendarViewController.h"
#import "NSDate+FSExtension.h"
#import "SSLunarDate.h"
#import "TXCalendarConfigController.h"
#import "WCAlertView.h"
#import "TXEditDiaryViewController.h"
#import "TXDiaryingTableViewController.h"

#define kPink [UIColor colorWithRed:0.776 green:0.672 blue:0.676 alpha:1.000]
#define kSelectColor [UIColor colorWithRed:0.859 green:0.623 blue:0.804 alpha:1.000]
#define kTextColor [UIColor colorWithRed:0.773 green:0.635 blue:0.706 alpha:1.000]

@interface TXCalendarViewController ()

@property (strong, nonatomic) NSCalendar *currentCalendar;
@property (strong, nonatomic) SSLunarDate *lunarDate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *setting;

@end

@implementation TXCalendarViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(prepareForSegue_setting:) image:@"s3_btn_person2.png" highImage:@"s3_btn_person2.png"];
    
    _currentCalendar = [NSCalendar currentCalendar];
    //    _firstWeekday = _calendar.firstWeekday;
    //    _calendar.firstWeekday = 2; // Monday
    //    _calendar.flow = FSCalendarFlowVertical;
    //    _calendar.selectedDate = [NSDate fs_dateWithYear:2015 month:2 day:1];
    _flow = _calendar.flow;
    
}

- (void)dealloc
{
    NSLog(@"%@:%s",self.class.description,__FUNCTION__);
}

#pragma mark - FSCalendarDataSource

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    if (!_lunar) {
        return nil;
    }
    _lunarDate = [[SSLunarDate alloc] initWithDate:date calendar:_currentCalendar];
    return _lunarDate.dayString;
}
/*
//- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date
//{
//    return date.fs_day == 3;
//}

//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
//{
//    return [NSDate fs_dateWithYear:2015 month:6 day:15];
//}
//
//- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
//{
//    return [NSDate fs_dateWithYear:2015 month:7 day:15];
//}
*/
#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    BOOL shouldSelect = date.fs_day != 7;
    if (!shouldSelect) {
        [[[UIAlertView alloc] initWithTitle:@"FSCalendar"
                                    message:[NSString stringWithFormat:@"FSCalendar delegate forbid %@  to be selected",[date fs_stringWithFormat:@"yyyy/MM/dd"]]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    } else {
        NSLog(@"Should select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
    }
    return shouldSelect;
}

// 选中日期
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
    NSString *dateString = [date fs_stringWithFormat:@"yyyy/MM/dd"];
    
    [WCAlertView showAlertWithTitle:dateString message:@"去写日记" customizationBlock:^(WCAlertView *alertView) {
        alertView.style = WCAlertViewStyleViolet;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == 0) {

            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Diarying" bundle:[NSBundle mainBundle]];
            TXEditDiaryViewController *editVC = [storyBoard instantiateViewControllerWithIdentifier:@"EditViewController"];
            
            // 去到日记编辑
            [self presentViewController:editVC animated:YES completion:nil];
            
        }
    } cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
}

- (void)calendarCurrentMonthDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to month %@",[calendar.currentMonth fs_stringWithFormat:@"MMMM yyyy"]);
}

#pragma mark - Navigation
- (void)prepareForSegue_setting:(UIBarButtonItem *)sender{

    [self performSegueWithIdentifier:@"CalendarConfigController" sender:sender];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[TXCalendarConfigController class]]) {
        [segue.destinationViewController setValue:self forKey:@"viewController"];
    }
}

#pragma mark - Setter

- (void)setTheme:(NSInteger)theme
{
    if (_theme != theme) {
        _theme = theme;
        switch (theme) {
            case 0: {
                _calendar.appearance.weekdayTextColor = kTextColor;
                _calendar.appearance.headerTitleColor = kTextColor;
                _calendar.appearance.eventColor = [kTextColor colorWithAlphaComponent:0.75];
                _calendar.appearance.selectionColor = kSelectColor;
                _calendar.appearance.headerDateFormat = @"MMMM yyyy";
                _calendar.appearance.todayColor = kPink;
                _calendar.appearance.cellStyle = FSCalendarCellStyleCircle;
                _calendar.appearance.headerMinimumDissolvedAlpha = 0.2;
                break;
            }
            case 1: {
                _calendar.appearance.weekdayTextColor = [UIColor colorWithRed:0.887 green:0.863 blue:1.000 alpha:1.000];
                _calendar.appearance.headerTitleColor = [UIColor darkGrayColor];
                _calendar.appearance.eventColor = [UIColor greenColor];
                _calendar.appearance.selectionColor = [UIColor colorWithRed:0.898 green:0.779 blue:1.000 alpha:1.000];
                _calendar.appearance.headerDateFormat = @"yyyy-MM";
                _calendar.appearance.todayColor = [UIColor colorWithRed:0.953 green:0.728 blue:1.000 alpha:1.000];
                _calendar.appearance.cellStyle = FSCalendarCellStyleCircle;
                _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
                
                break;
            }
            case 2: {
                _calendar.appearance.weekdayTextColor = [UIColor colorWithRed:0.750 green:0.755 blue:0.810 alpha:1.000];
                _calendar.appearance.headerTitleColor = [UIColor colorWithRed:0.886 green:0.717 blue:1.000 alpha:1.000];
                _calendar.appearance.eventColor = [UIColor greenColor];
                _calendar.appearance.selectionColor = [UIColor colorWithRed:0.977 green:0.841 blue:1.000 alpha:1.000];
                _calendar.appearance.headerDateFormat = @"yyyy/MM";
                _calendar.appearance.todayColor = [UIColor orangeColor];
                _calendar.appearance.cellStyle = FSCalendarCellStyleRectangle;
                _calendar.appearance.headerMinimumDissolvedAlpha = 1.0;
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)setLunar:(BOOL)lunar
{
    if (_lunar != lunar) {
        _lunar = lunar;
        [_calendar reloadData];
    }
}

- (void)setFlow:(FSCalendarFlow)flow{

    if (_flow != flow) {
        _flow = flow;
        _calendar.flow = flow;
        [[[UIAlertView alloc] initWithTitle:@"FSCalendar"
                                    message:[NSString stringWithFormat:@"Now swipe %@",@[@"Vertically", @"Horizontally"][_calendar.flow]]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    _calendar.selectedDate = selectedDate;
}

- (void)setFirstWeekday:(NSUInteger)firstWeekday
{
    if (_firstWeekday != firstWeekday) {
        _firstWeekday = firstWeekday;
        _calendar.firstWeekday = firstWeekday;
    }
}


@end
