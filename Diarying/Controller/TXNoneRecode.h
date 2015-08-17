//
//  TXNoneRecode.h
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXNoneRecode : UIView
@property (strong, nonatomic) IBOutlet UIView *noneRecodeView;

@property (strong, nonatomic) IBOutlet UILabel *descriptionTop;
@property (strong, nonatomic) IBOutlet UILabel *descriptionWithDown;

//@property (strong, nonatomic) IBOutlet TXNoneRecode *noneRecodeView;

+ (instancetype)defaultnoneRecodeView;

@end
