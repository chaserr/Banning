//
//  TXTableViewHeader.h
//  Banning
//
//  Created by lanou3g on 15/8/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXTableViewHeader : UIView
//@property (strong, nonatomic) IBOutlet UIView *tableViewHeader;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIImageView *headerView_headimage;
@property (strong, nonatomic) IBOutlet UILabel *headerView_timelabel;

+ (instancetype)defaultTableviewHeader;


@end
