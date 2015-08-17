//
//  TXWarnWriteDiaryTableViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXWarnWriteDiaryTableViewController.h"
#import "PopupView.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "TXSaveUsrSetting.h"
@interface TXWarnWriteDiaryTableViewController ()
{

    UILocalNotification *_localNotication;

}

/** 开启提醒开关 */
@property (strong, nonatomic) IBOutlet UIButton *warnSwitch;
/** 显示提醒时间 */
@property (strong, nonatomic) IBOutlet UILabel *timeLable;

/** 时间选择器 */
@property (nonatomic, strong) UIDatePicker *myDatePicker;

@end

@implementation TXWarnWriteDiaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.myDatePicker.date = [NSDate date];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

   BOOL state = [[TXSaveUsrSetting sharedTXSaveUsrSetting] isOff];
    self.warnSwitch.selected = state;
    if (state) {
        NSString *dataString = [[TXSaveUsrSetting sharedTXSaveUsrSetting] warnTimeString];
        self.timeLable.text = dataString;
    }else{
    
        self.timeLable.text = nil;
    }

}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        self.warnSwitch.selected = !self.warnSwitch.selected;
        
        [[TXSaveUsrSetting sharedTXSaveUsrSetting] setUsr_warnWriteState:self.warnSwitch.selected];
        [[TXSaveUsrSetting sharedTXSaveUsrSetting] synchronized];
      
        if (self.warnSwitch.selected) {
        
            NSString *dataString = [[TXSaveUsrSetting sharedTXSaveUsrSetting] warnTimeString];
            self.timeLable.text = dataString;
 
        }else{
        
            self.timeLable.text = nil;
            // 取消通知
            if (_localNotication != nil) {
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
//                [[UIApplication sharedApplication] cancelLocalNotification:_localNotication];
            
            }
        }
        
    }else{
    
        if (!self.warnSwitch.selected) {
            // 提示没有开启提醒开关
            [self openWarnSwitch];
            
        }else{
            if (self.myDatePicker.superview == nil) {
                NSLog(@"已经打开提醒开关");
                [self setupDatePicker];
            }
           
        }
        
    }
    
}


#pragma mark -- 提示打开提醒开关
- (void)openWarnSwitch{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, SCREEN_HEIGHT/2, 150, 30)];
    label.alpha = 0.0;
    [self.view addSubview:label];
    [UIView animateWithDuration:1.0 animations:^{
        label.frame = CGRectMake(100, SCREEN_HEIGHT/2, 150, 30);
        label.text = @"请先打开提醒开关";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithWhite:0.377 alpha:1.000];
        label.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:3 animations:^{
            label.alpha = 0.0;
        }];
        [label removeFromSuperview];
    }];

}

#pragma mark -- 时间选择器

- (void)setupDatePicker{

    PopupView *view = [PopupView defaultPopupView];
    self.myDatePicker = view.datePicker;
    
    view.parentVC = self;
    [self lew_presentPopupView:view animation:[LewPopupViewAnimationFade new] dismissed:^{
        NSLog(@"动画结束");
    }];
    [self.myDatePicker addTarget:self action:@selector(chooseDate:) forControlEvents:(UIControlEventValueChanged)];
    

}


// 获取时间选择器上的时间
- (void)chooseDate:(UIDatePicker *)myDatePicker{

    NSDate *selectDate = myDatePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *dateString = [formatter stringFromDate:selectDate];
    self.timeLable.text = dateString;
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] setUsr_warnWriteTime:dateString];
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] synchronized];
    
    [self scheduleLocalNotificationWithDate:self.myDatePicker.date];
    NSLog(@"调用本地通知");
    NSLog(@"self.myDatePicker.date == %@", self.myDatePicker.date);
}


#pragma mark -- 调用本地通知
- (void)scheduleLocalNotificationWithDate:(NSDate *)fireDate{
    
    if (_localNotication != nil) {
        
        [[UIApplication sharedApplication] cancelLocalNotification:_localNotication];
    }
    // 定义本地通知
//    UILocalNotification *localNotication = [[UILocalNotification alloc] init];
    _localNotication = [[UILocalNotification alloc] init];
    _localNotication.alertAction = @"打开应用"; // 待机界面的滑动动作提示
//    _localNotication.applicationIconBadgeNumber = 1;
    NSArray *bodyArray = @[@"万物皆萌,该写日记了", @"世界很美，而你正好有空，快去记录把", @"快乐是首歌，除了唱还可以写哦[写日记去]", @"Life is a song! Go to Write", @"帮你记录心情是我生命里程中的唯一目的[马上写日记]", @"天若有情，亘古不老,该写日记了", @"一万个美丽的未来，也比不上一个温暖的现在[写日记去]", @"今天是什么颜色？[我要写日记]", @"碧水青山终行遍，不及一缕情丝相思缠[写日记]"];
   NSInteger bodyArray_i = (arc4random()%(8-0+1)) + 0;
    NSLog(@"%ld", bodyArray_i);
    _localNotication.alertBody = bodyArray[bodyArray_i];
    _localNotication.fireDate = fireDate;
//    _localNotication.soundName = @"Thunder Song.m4r";
    _localNotication.soundName = UILocalNotificationDefaultSoundName;
    
    // 设置通知重复次数
     _localNotication.repeatInterval = kCFCalendarUnitDay;
    
    //notication.alertLaunchImage = @"Default"; // 通过点击通知打开应用时的启动图片

    [[UIApplication sharedApplication] scheduleLocalNotification:_localNotication];
    
}


// 开启时间提醒开关
- (IBAction)clickSwitch:(id)sender {
    
    self.warnSwitch.selected = !self.warnSwitch.selected;
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] setUsr_warnWriteState:self.warnSwitch.selected];
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] synchronized];
    
    if (self.warnSwitch.selected) {
        
        NSString *dataString = [[TXSaveUsrSetting sharedTXSaveUsrSetting] warnTimeString];
        self.timeLable.text = dataString;
        
    }else{
        
        self.timeLable.text = nil;
        // 取消通知
        if (_localNotication != nil) {
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            //                [[UIApplication sharedApplication] cancelLocalNotification:_localNotication];
            
        }
    }
}


// 懒加载
- (UIDatePicker *)myDatePicker{
    
    if (!_myDatePicker) {
        self.myDatePicker = [[UIDatePicker alloc] init];
    }
    return _myDatePicker;
}



@end
