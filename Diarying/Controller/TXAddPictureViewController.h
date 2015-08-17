//
//  TXAddPictureViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXDiary.h"
@class TXAddPictureViewController;
@protocol TXAddPictureViewControllerDelegate <NSObject>

- (void) cameraViewControllerDidReturn: (TXAddPictureViewController *)cameraViewController;

@end
@interface TXAddPictureViewController : UIViewController<
UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) id <TXAddPictureViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *showSystemPicture; /** 显示系统照片 */
@property (strong, nonatomic) TXDiary *diary;

@end
