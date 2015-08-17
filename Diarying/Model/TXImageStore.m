//
//  TXImageStore.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXImageStore.h"

static TXImageStore *defaultImageStore = nil;

@implementation TXImageStore



+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultImageStore];
}

+ (TXImageStore *)defaultImageStore
{
    if (!defaultImageStore) {
        defaultImageStore = [[super allocWithZone:NULL] init];
    }
    return defaultImageStore;
}

- (id) init
{
    if (defaultImageStore) {
        return defaultImageStore;
    }
    
    self = [super init];
    if (self) {
        m_dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

// 保存照片
- (void)setImage:(UIImage *)image forKey:(NSString *)string{

    NSString *imagePath = [self pathInDocumentDirectory:string];
    
    // 将image对象写入NSData之中
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    // 将数据写入文件系统
    [data writeToFile:imagePath atomically:YES];
    
    [m_dictionary setObject:image forKey:string];
    
}

// 取出照片
- (UIImage *)imageForKey:(NSString *)string{

    // 首先尝试从_m_dictionary字典中获取图片
    UIImage *image = [m_dictionary objectForKey:string];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:[self pathInDocumentDirectory:string]];
        if (image) {
            [m_dictionary setObject:image forKey:string];
        }else{
        
            NSLog(@"错误,没有找到文件:%@", [self pathInDocumentDirectory:string]);
        }
    }
    return [m_dictionary objectForKey:string];
    
}

// 删除照片
- (void)deleteImageForKey:(NSString *)string{

    if (!string) {
        return;
    }
    
    // 从系统文件中删除文件
    NSString *path = [self pathInDocumentDirectory:string];
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    // 从字典中删除文件
    [m_dictionary removeObjectForKey:string];
}

// 获取Document文件路径
- (NSString *)pathInDocumentDirectory:(NSString *)fileName{

    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectry = [documentDirectories objectAtIndex:0];
    return [documentDirectry stringByAppendingPathComponent:fileName];
}

@end
