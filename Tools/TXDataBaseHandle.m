//
//  TXDataBaseHandle.m
//  Banning
//
//  Created by lanou3g on 15/8/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXDataBaseHandle.h"
#import "TXSaveUsrSetting.h"
#import "NSDate+TX_timeFormat.h"
#import "FMDatabaseAdditions.h"
@interface TXDataBaseHandle ()
@property (nonatomic, copy) NSString *databasePath;
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation TXDataBaseHandle
// 单例
SingletonM(TXDataBaseHandle);

//static FMDatabase *db = nil;

// 打开数据库
- (void)openDatabase{
    
    self.databasePath = [[TXSaveUsrSetting sharedTXSaveUsrSetting] databaseFilePathWithDatabaseName:@"Diary.sqlite"];

    self.db = [FMDatabase databaseWithPath:self.databasePath];
    
}
// 打开数据库
- (void)createTabel{
    if (!_db) {
        [self openDatabase];
    }
//    NSFileManager *fileManage = [NSFileManager defaultManager];
//    if ([fileManage fileExistsAtPath:self.databasePath] == NO) {
    if ([_db open]) {
            
        NSString *sql = @"CREATE TABLE 'Diary' ('m_title' TEXT, 'm_content' TEXT, 'm_photoKey' TEXT, 'm_audioFileName' TEXT, 'm_dateCreate' TEXT PRIMARY KEY, 'diary_data' BLOB)";
        BOOL result = [_db executeUpdate:sql];
        if (!result) {
            NSLog(@"执行失败");
        }else{
        
            NSLog(@"执行成功");
        }
        
        // 为数据库设置缓存，提高查询效率
        [_db setShouldCacheStatements:YES];
//            [_db close];
    }else{
        
        NSLog(@"打开数据库失败");
    }
    
}

// 保存数据
- (void)saveDiaries:(TXDiary *)txDiary{
    if (!_db) {
        [self openDatabase];
    }
    // 判断数据库中是否表
    if(![_db tableExists:@"Diary"])
    {
        [self createTabel];
    }

    if ([_db open]) {
        
        NSString *sql = @"insert into Diary (m_title, m_content, m_photoKey, m_audioFileName, m_dateCreate, diary_data) values(?, ?, ?, ?, ?, ?)";
        // 将模型归档为data
        NSString *timeString = [txDiary.m_dateCreate changeDateToString:txDiary.m_dateCreate];
        NSString *archiveKey = [NSString stringWithFormat:@"txDiary%@", timeString];
        
        NSData *data = [[TXSaveUsrSetting sharedTXSaveUsrSetting] dataOfArchiveObject:txDiary forKey:archiveKey];
        
        BOOL result = [_db executeUpdate:sql, txDiary.m_title, txDiary.m_content, txDiary.m_photoKey, txDiary.m_audioFileName, timeString, data];
        
        if (!result) {
            NSLog(@"插入数据失败");
        } else {
            NSLog(@"插入数据成功");
        }
//        [db close];
    }
}

// 查询数据
- (NSArray *)queryDiary{
    if (!_db) {
        [self openDatabase];
    }
    // 判断数据库中是否表
    if(![_db tableExists:@"Diary"])
    {
        [self createTabel];
    }

    [_db setShouldCacheStatements:YES];
    
    NSMutableArray *txDiaryArray = [NSMutableArray array];
    
    if ([_db open]) {
        NSString *sql = @"select m_dateCreate, diary_data from Diary";
        FMResultSet *rs = [_db executeQuery:sql];
        while ([rs next]) {
            
            NSString *m_dateCreate = [rs stringForColumn:@"m_dateCreate"];
            NSString *archiveKey = [NSString stringWithFormat:@"txDiary%@",m_dateCreate];
            
            NSData *diaryData = [rs dataForColumn:@"diary_data"];
            // 解档
            TXDiary *diary = [[TXSaveUsrSetting sharedTXSaveUsrSetting] unarchiveObject:diaryData forKey:archiveKey];
            
          NSDate *date = [diary.m_dateCreate changeStringToDate:m_dateCreate];
            [diary setValue:date forKey:@"m_dateCreate"];
            [txDiaryArray addObject:diary];
        }
//        [db close];
    }
    
    return txDiaryArray;
}
// 删除数据
- (void)deleteDiaries:(NSString *)timeString{
    if (!_db) {
        [self openDatabase];
    }
    // 判断数据库中是否表
    if(![_db tableExists:@"Diary"])
    {
        [self createTabel];
    }
    if ([_db open]) {
        NSString *sql = @"delete from Diary where m_dateCreate = ?";
        BOOL result = [_db executeUpdate:sql, timeString];
        if (!result) {
            NSLog(@"删除数据失败");
        }else{
        
            NSLog(@"删除数据成功");
        }
//        [db close];
    }
}

//// 关闭数据库
//- (void)closeDatabase;

@end
