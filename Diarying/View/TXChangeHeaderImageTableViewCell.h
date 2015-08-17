//
//  TXChangeHeaderImageTableViewCell.h
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXHeaderImage.h"
@interface TXChangeHeaderImageTableViewCell : UITableViewCell
/** 图片 */
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
/** 图片描述 */
@property (strong, nonatomic) IBOutlet UILabel *headImage_des;
/** 选中图片 */
@property (strong, nonatomic) IBOutlet UIButton *selectImage;



@property (nonatomic, strong) TXHeaderImage *txHeadImage;

+ (instancetype)defaultCell;
@end
