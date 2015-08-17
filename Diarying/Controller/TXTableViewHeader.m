//
//  TXTableViewHeader.m
//  Banning
//
//  Created by lanou3g on 15/8/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXTableViewHeader.h"

@implementation TXTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//       self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"TXDiaryingTableViewController" owner:nil options:nil] lastObject];
        [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
        _headerView.frame = frame;
        [self addSubview:_headerView];
        
    }
    return self;
}

+ (instancetype)defaultTableviewHeader{
    return [[TXTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,160)];
}


@end
