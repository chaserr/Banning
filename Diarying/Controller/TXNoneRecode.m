//
//  TXNoneRecode.m
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXNoneRecode.h"

@implementation TXNoneRecode


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
//       self.noneRecodeView = [[[NSBundle mainBundle] loadNibNamed:@"TXNoneRecode" owner:nil options:nil] lastObject];
//        [self addSubview:view];
    [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
    _noneRecodeView.frame = frame;
    [self addSubview:_noneRecodeView];
        
    }
    return self;
}

+ (instancetype)defaultnoneRecodeView{
    return [[TXNoneRecode alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 150)];
}

@end
