//
//  TXSaveUsrSetting.h
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXSaveUsrSetting : NSObject

SingletonH(TXSaveUsrSetting);

// 同步
- (void)synchronized;

// 保存用户设置
- (void)setUsr_warnWriteState:(BOOL)isOff;
- (void)setUsr_warnWriteTime:(NSString *)warnTimeString;

/** 保存更改封面图片的设置 */
- (void)setUsr_headerImage:(NSInteger)headerImage_i;

/** 设置心情图片 */
- (void)setUsr_moodImage:(NSInteger)moodImage_i;

// 获取用户个人设置
- (BOOL)isOff;
- (NSString *)warnTimeString;
- (NSInteger)headerImage_i;
- (NSInteger)moodImage_i;
//数据库缓存
//数据库路径
- (NSString *)databaseFilePathWithDatabaseName:(NSString *)databaseName;
//将对象归档
- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key;
//解档
- (id)unarchiveObject:(NSData *)data forKey:(NSString *)key;
@end
