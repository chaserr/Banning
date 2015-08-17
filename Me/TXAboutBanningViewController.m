//
//  TXAboutBanningViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXAboutBanningViewController.h"

@interface TXAboutBanningViewController ()

@end

@implementation TXAboutBanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"关于久伴";
    
    CGFloat conetntSizeH = SCREEN_HEIGHT;
    //字体
    CGFloat Fotsize = 15;
    //文字高度
    CGFloat H = 300;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT / 3)];
    imageView.image = [UIImage imageNamed:@"v1_plan_show_big_btm.9"];
    
    UILabel *aboutMe = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT / 3 + 20, SCREEN_WIDTH - 40, H)];
    aboutMe.numberOfLines = 0;
    
    aboutMe.font = [UIFont systemFontOfSize:Fotsize];
    
    
    aboutMe.text = @"欢迎来到久伴\n\n久伴日记是手机上最好的生活记录软件，最受欢迎，最萌最可爱！\n\n世界很美，让久伴和你一起记录生活中的点点滴滴，久伴拥有可爱的卡通色彩，卡哇伊的图标按钮，今后还有更多有趣的功能等着你哦。。。\n\n万物皆萌，一起去写日记吧，帮你记录心情是我生命里程中的唯一目的" ;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    // 设置是否回到顶部
    scrollView.scrollsToTop = NO;
    // 设置contentSize
    scrollView.contentSize = CGSizeMake(0, conetntSizeH);
    //显示垂直方向的滚动条
    scrollView.showsVerticalScrollIndicator = YES;
    // 垂直方向遇到边框是否反弹
    scrollView.alwaysBounceVertical = YES;
    
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:imageView];
    
    [scrollView addSubview:aboutMe];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
