//
//  TXHeaderImage.h
//  Banning
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXHeaderImage : NSObject
/** 图片名 */
@property (nonatomic, copy) NSString *imageName;
/** 图片描述 */
@property (nonatomic, copy) NSString *description_img;


- (instancetype)initWithHeadImage_cellContent:(NSDictionary *)dict;

+ (instancetype)headerImageWithDict:(NSDictionary *)dict;

@end
