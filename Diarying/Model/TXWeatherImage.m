//
//  TXWeatherImage.m
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXWeatherImage.h"

@implementation TXWeatherImage

- (instancetype)initWithTXWeatherImageDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)txWeatherImageWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithTXWeatherImageDict:dict];
}

@end
