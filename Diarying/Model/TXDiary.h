//
//  TXDiary.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//  存储日记

#import <Foundation/Foundation.h>

@interface TXDiary : NSObject<NSCoding>
/** 日记标题 */
@property (nonatomic, strong) NSString *m_title;
/** 日记内容 */
@property (nonatomic, strong) NSString *m_content;
/** 存储照片对应的关键字 */
@property (nonatomic, copy) NSString *m_photoKey;
/** 存储录音文件 */
@property (nonatomic, copy) NSString *m_audioFileName;
/** 日记创建日期 */
@property (nonatomic, copy) NSString *moodImageName;
@property (nonatomic, copy) NSString *weatherImageName;
@property (nonatomic, readonly, getter=m_dateCreate) NSDate *m_dateCreate;

/** 日记标题 */
+ (instancetype)createDiary;
/** 日记内容 */
- (instancetype)initWithTitle:(NSString *)theTitle content:(NSString *)theContent;
@end
