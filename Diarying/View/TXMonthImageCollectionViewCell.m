//
//  TXMonthImageCollectionViewCell.m
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXMonthImageCollectionViewCell.h"

@implementation TXMonthImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];

//        _imageView.userInteractionEnabled = YES;

        [self addSubview:_imageView];

        self.selectimage = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_selectimage setTintColor:[UIColor clearColor]];
        _selectimage.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [_selectimage setBackgroundImage:[UIImage imageNamed:@"tag_frame"] forState:(UIControlStateSelected)];
        _selectimage.userInteractionEnabled = NO;
        _selectimage.selected = NO;
        [self addSubview:_selectimage];
        
    }
    return self;
}

@end
