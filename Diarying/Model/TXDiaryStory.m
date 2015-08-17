//
//  TXDiaryStory.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXDiaryStory.h"
#import "TXDiary.h"

static TXDiaryStory *defaultStore = nil;

@implementation TXDiaryStory
/** 单例 */

+ (TXDiaryStory *)defaultStore
{
    if (!defaultStore) {
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    if (defaultStore) {
        return defaultStore;
    }
    self = [super init];
    //    if (self) {
    //        diaries = [[NSMutableArray alloc] init];
    //    }
    return self;
}

- (NSArray *)diaries
{
    // 确保diaries被创建
    [self fetchDiary];
    return _diaries;
}


- (TXDiary *)createDiary
{
    // 确保diaries被创建
    [self fetchDiary];
    TXDiary *diary = [TXDiary createDiary];
    [_diaries addObject:diary];
    return diary;
}

- (NSString *)diaryArchivePath
{
    // 获取沙箱中Documents目录的路径列表
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // NSArray列表中获取Document目录的路径
    NSString *documentDirectory  = [documentDirectories objectAtIndex:0];
    
    // 在路径的后面添加想要创建的文件名称并返回
    return [documentDirectory stringByAppendingPathComponent:@"diaries.data"];
}

// 用于归档diaries
- (BOOL)saveChanges
{
    // NSKeyedArchiver类有个方法可以用来将对象（符合NSCoding协议）保存在文件系统中,该方法会对RootObject（这里为diaries）发送encodeWithCoder:消息
    return [NSKeyedArchiver archiveRootObject:_diaries toFile:[self diaryArchivePath]];
}

- (void)fetchDiary
{
    // 如果当前diaries为空，则尝试从磁盘载入
    if (!_diaries) {
        NSString *path = [self diaryArchivePath];
        // NSKeyedUnarchiver类有个方法可以恢复保存在文件中的对象
        _diaries = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    // 如果磁盘中不存在该文件，则创建个新的
    if (!_diaries) {
        _diaries = [[NSMutableArray alloc] init];
    }
}

// 用于删除数据
- (void)removeDiary:(TXDiary *)data
{
    [_diaries removeObjectIdenticalTo:data]; // 如果在数组中不存在d对象，不会产生任何效果
}

// 用于移动数据
- (void)moveDiaryAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    TXDiary *diary = [_diaries objectAtIndex:from];
    [_diaries removeObjectAtIndex:from];
    [_diaries insertObject:diary atIndex:to];
}


@end
