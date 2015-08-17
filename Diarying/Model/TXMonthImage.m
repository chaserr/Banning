//
//  TXMonthImage.m
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXMonthImage.h"

@implementation TXMonthImage

- (instancetype)initWithTXMonthImageDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)txMonthImageWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithTXMonthImageDict:dict];
}

@end
