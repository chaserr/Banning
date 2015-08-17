//
//  TXSaveUsrSetting.m
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXSaveUsrSetting.h"

@implementation TXSaveUsrSetting

SingletonM(TXSaveUsrSetting);

- (void)synchronized{

    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 保存用户设置信息
- (void)setUsr_warnWriteState:(BOOL)isOff{

    [[NSUserDefaults standardUserDefaults] setBool:isOff forKey:@"isOff"];
}

/** 保存更改封面图片的设置 */
- (void)setUsr_warnWriteTime:(NSString *)warnTimeString{

    [[NSUserDefaults standardUserDefaults] setValue:warnTimeString forKey:@"warnTimeString"];
}


- (void)setUsr_headerImage:(NSInteger)headerImage_i{

    [[NSUserDefaults standardUserDefaults] setInteger:headerImage_i forKey:@"headerImage_i"];
}

/** 设置心情图片 */
- (void)setUsr_moodImage:(NSInteger)moodImage_i{

    [[NSUserDefaults standardUserDefaults] setInteger:moodImage_i forKey:@"moodImage_i"];
}



// 获取用户设置信息
- (BOOL)isOff{

    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isOff"];
}

- (NSString *)warnTimeString{

    return [[NSUserDefaults standardUserDefaults] objectForKey:@"warnTimeString"];
}

- (NSInteger)headerImage_i{

    return [[NSUserDefaults standardUserDefaults] integerForKey:@"headerImage_i"];
}

/** 设置心情图片 */
- (NSInteger)moodImage_i{

    return [[NSUserDefaults standardUserDefaults] integerForKey:@"moodImage_i"];
}

// 数据库路径

- (NSString *)databaseFilePathWithDatabaseName:(NSString *)databaseName{

    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [cachesPath stringByAppendingPathComponent:databaseName];
    NSLog(@"数据库路径:walkOnTime.sqlite:>>%@", cachesPath);
}


//将对象归档
- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key
{
    
    NSMutableData *data = [NSMutableData data];
    //创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //归档
    [archiver encodeObject:object forKey:key];
    //结束归档
    [archiver finishEncoding];
    return data;
}

//解档
- (id)unarchiveObject:(NSData *)data forKey:(NSString *)key
{
    //创建解档对象
    NSKeyedUnarchiver *unArchived = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //解档
    id object = [unArchived decodeObjectForKey:key];
    //结束解档
    [unArchived finishDecoding];
    return object;
}



@end
