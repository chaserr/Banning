//
//  TXMonthImageCollectionReusableView_header.m
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXMonthImageCollectionReusableView_header.h"

@implementation TXMonthImageCollectionReusableView_header

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
    }
    return  self;
}

- (UILabel *)label{
    
    if (_label == nil) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 25)];
        _label.backgroundColor = [UIColor colorWithRed:0.906 green:0.817 blue:0.687 alpha:1.000];
        _label.font = GeezaPro;
        
        [self addSubview:_label];
    }
    
    return _label;
}
@end
