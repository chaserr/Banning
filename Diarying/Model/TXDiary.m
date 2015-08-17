//
//  TXDiary.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXDiary.h"
#import "NSObject+NSCoding.h"
@implementation TXDiary
- (instancetype)init
{
    return  [self initWithTitle:@"" content:@""];
}

- (instancetype)initWithTitle:(NSString *)theTitle content:(NSString *)theContent{

    self = [super init];
    if (self) {
        
        [self setM_title:theTitle];
        [self setM_content:theContent];
        _m_dateCreate = [[NSDate alloc] init];
    }
    return self;
}

+ (instancetype)createDiary{

    TXDiary *newDiary = [[TXDiary alloc] init];
    return newDiary;

}

#pragma mark -- 对象归档/解档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self autoEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        [self autoDecode:aDecoder];
    }
    
    return self;
}


//- (void)encodeWithCoder:(NSCoder *)aCoder{
//
//    // 对于每一个实例变量，基于它的变量名进行归档，并且这些对象也会被用于发送encodeWithCoder:消息
//    [aCoder encodeObject:self.m_title forKey:@"title"];
//    [aCoder encodeObject:self.m_content forKey:@"content"];
//    [aCoder encodeObject:self.m_dateCreate forKey:@"dateCreate"];
//    [aCoder encodeObject:self.m_photoKey forKey:@"photoKey"];
//    [aCoder encodeObject:self.m_audioFileName forKey:@"audioFileName"];
//}
//
//- (id) initWithCoder:(NSCoder *)aDecoder
//{
//    if (self) {
//        [self setM_title:[aDecoder decodeObjectForKey:@"title"]];
//        [self setM_content:[aDecoder decodeObjectForKey:@"content"]];
//        [self setM_photoKey:[aDecoder decodeObjectForKey:@"photoKey"]];
//        [self setM_audioFileName:[aDecoder decodeObjectForKey:@"audioFileName"]];
//        
//        // m_dateCreate是只读属性，没有setter方法，这里直接给成员变量赋值
//        _m_dateCreate = [aDecoder decodeObjectForKey:@"dateCreate"];
//    }
//    return self;
//}


@end
