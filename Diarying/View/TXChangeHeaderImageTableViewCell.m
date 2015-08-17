//
//  TXChangeHeaderImageTableViewCell.m
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXChangeHeaderImageTableViewCell.h"

@implementation TXChangeHeaderImageTableViewCell


- (void)setTxHeadImage:(TXHeaderImage *)txHeadImage{

    
    _txHeadImage = txHeadImage;
    
    // 赋值txHeadImage.imageName
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
    
        [self.headImage setImage:[UIImage imageNamed:txHeadImage.imageName]]; // 宏定义
        
        // 回到主线程
//        dispatch_async(dispatch_get_main_queue(), ^{
    
            self.headImage_des.text = txHeadImage.description_img;
//        });
//    });
    
   
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //       self.noneRecodeView = [[[NSBundle mainBundle] loadNibNamed:@"TXNoneRecode" owner:nil options:nil] lastObject];
        //        [self addSubview:view];
        self = (TXChangeHeaderImageTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] lastObject];
//        self.frame = frame;
//        [self addSubview:_noneRecodeView];
        
    }
    return self;
}

+ (instancetype)defaultCell{
    return [[TXChangeHeaderImageTableViewCell alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
}


- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
