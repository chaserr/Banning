//
//  TXMonthImage.h
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXMonthImage : NSObject

@property (nonatomic, copy) NSString *moodImageName;

- (instancetype)initWithTXMonthImageDict:(NSDictionary *)dict;

+ (instancetype)txMonthImageWithDict:(NSDictionary *)dict;

@end
