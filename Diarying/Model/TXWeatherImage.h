//
//  TXWeatherImage.h
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXWeatherImage : NSObject

@property (nonatomic, copy) NSString *weatherImageName;

- (instancetype)initWithTXWeatherImageDict:(NSDictionary *)dict;

+ (instancetype)txWeatherImageWithDict:(NSDictionary *)dict;

@end
