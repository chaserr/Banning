//
//  TXTabBarViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXTabBarViewController.h"
#import "TXNavigationController.h"
#import "TXDiaryingTableViewController.h"
#import "TXMapViewController.h"
#import "TXCalendarViewController.h"
#import "TXSettingTableViewController.h"
@interface TXTabBarViewController ()

@end

@implementation TXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    
    // 创建tabBarController
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    // 修改tabbar背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
//    backView.backgroundColor = [UIColor colorWithRed:1.000 green:0.591 blue:0.637 alpha:1.000];
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keepdiary_bottom"]];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    // 加载4个storyBoard
    // 我的日记
    UIStoryboard *diaryingSB = [UIStoryboard storyboardWithName:@"Diarying" bundle:[NSBundle mainBundle]];
    TXDiaryingTableViewController *diaryingVC = [diaryingSB instantiateViewControllerWithIdentifier:@"MyDiarying"];
    [self addChildVc:diaryingVC title:@"日记" image:@"v2_btn_diary" selectedImage:@"v2_btn_diary"];

    // 地图
    UIStoryboard *mapSB = [UIStoryboard storyboardWithName:@"Map" bundle:[NSBundle mainBundle]];
    TXMapViewController *mapVC = [mapSB instantiateViewControllerWithIdentifier:@"Map"];
    [self addChildVc:mapVC title:@"附近" image:@"v3_btn_metro" selectedImage:@"v3_btn_metro"];
    
    // 日历
    UIStoryboard *calendarSB = [UIStoryboard storyboardWithName:@"Calendar" bundle:[NSBundle mainBundle]];
    TXCalendarViewController *calendarVC = [calendarSB instantiateViewControllerWithIdentifier:@"Calendar"];
    [self addChildVc:calendarVC title:@"日历" image:@"v2_time_icn_all" selectedImage:@"v2_time_icn_all"];
    
    // 我
    UIStoryboard *meSB = [UIStoryboard storyboardWithName:@"Me" bundle:[NSBundle mainBundle]];
    TXSettingTableViewController *settingVC = [meSB instantiateViewControllerWithIdentifier:@"AboutMe"];
    [self addChildVc:settingVC title:@"我" image:@"pdm_3_sns" selectedImage:@"pdm_3_sns"];

    
}


/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    //    childVc.tabBarItem.title = title; // 设置tabbar的文字
    //    childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 声明选中图片使用原图(不加渲染)
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = TXColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
