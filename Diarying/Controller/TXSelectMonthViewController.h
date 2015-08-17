//
//  TXSelectMonthViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MoodImageNameBlock)(NSString *moodimageNaem, NSString *weatherImageName);

@interface TXSelectMonthViewController : UIViewController

@property (nonatomic, copy) MoodImageNameBlock moodImageNameBlock;

@end
