//
//  TXHeaderImage.m
//  Banning
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXHeaderImage.h"

@implementation TXHeaderImage


- (instancetype)initWithHeadImage_cellContent:(NSDictionary *)dict{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)headerImageWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithHeadImage_cellContent:dict];
}


@end
