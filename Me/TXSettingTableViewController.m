//
//  TXSettingTableViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXSettingTableViewController.h"
#import "TXWarnWriteDiaryTableViewController.h"
#import "TXAboutBanningViewController.h"
#import "TXOperationGuideViewController.h"
#import "WCAlertView.h"
@interface TXSettingTableViewController ()

@end

@implementation TXSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2  && indexPath.row == 0 ) {
        NSLog(@"点击退出应用，进入退出应用详情页面");
        
        [WCAlertView showAlertWithTitle:@" " message:@"你确定要退出程序吗?"customizationBlock:^(WCAlertView *alertView) {
            alertView.style = WCAlertViewStyleWhiteHatched;
        } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
            if (buttonIndex == 0) {
                [self exitApplication];
            }
        } cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        
    }

    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
}

#pragma mark -- 退出应用程序
- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    
    self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}

// 退出程序动画
- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    NSLog(@"程序要推出了");
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}

@end
