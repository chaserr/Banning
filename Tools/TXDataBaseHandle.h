//
//  TXDataBaseHandle.h
//  Banning
//
//  Created by lanou3g on 15/8/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "TXDiary.h"
@interface TXDataBaseHandle : NSObject

SingletonH(TXDataBaseHandle);

// 打开数据库
- (void)openDatabase;
// 创建表
- (void)createTabel;
//// 关闭数据库
//- (void)closeDatabase;
// 保存数据
- (void)saveDiaries:(TXDiary *)txDiary;
// 删除数据
- (void)deleteDiaries:(NSString *)timeString;
// 查询数据
- (NSArray *)queryDiary;


@end
