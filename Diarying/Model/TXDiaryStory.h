//
//  TXDiaryStory.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TXDiary;
@interface TXDiaryStory : NSObject

@property (nonatomic, strong) NSMutableArray *diaries;

+ (TXDiaryStory *)defaultStore;


- (NSArray *)diaries;
/** 新建日记 */
- (TXDiary *)createDiary;
/** 归档路径 */
- (NSString *)diaryArchivePath;
// 归档
- (BOOL)saveChanges;
// 解档
- (void)fetchDiary;
// 删除
- (void)removeDiary: (TXDiary *)data;
// 移动表格视图
- (void)moveDiaryAtIndex: (int)from toIndex: (int)to;

@end
