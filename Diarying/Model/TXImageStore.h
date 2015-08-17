//
//  TXImageStore.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//  存储照片

#import <Foundation/Foundation.h>

@interface TXImageStore : NSObject{
    NSMutableDictionary *m_dictionary;
}

/** 单例 */
+ (TXImageStore *)defaultImageStore;

/** 保存照片 */
- (void)setImage:(UIImage *)image forKey:(NSString *)string;
/** 取出照片 */
- (UIImage *)imageForKey:(NSString *)string;
/** 删除照片 */
- (void)deleteImageForKey:(NSString *)string;

@end
