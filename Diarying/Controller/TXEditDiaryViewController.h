//
//  TXEditDiaryViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXDiary.h"
#import "TXAddPictureViewController.h"
#import "TXRecodeViewController.h"
@class TXEditDiaryViewController;
@protocol TXEditDiaryViewControllerDelegate <NSObject>

@required
/** 取消保存 */
- (void) createDiaryViewControllerDidCancel: (TXEditDiaryViewController *)createDiaryController;
/** 保存日记 */
- (void) createDiaryViewController: (TXEditDiaryViewController *)createDiaryController didSaveWithDiary: (TXDiary *)theDiary;

@end

@interface TXEditDiaryViewController : UIViewController<UITextFieldDelegate,TXAddPictureViewControllerDelegate,RecordViewControllerDelegate>
@property (nonatomic, assign) id<TXEditDiaryViewControllerDelegate> delegate;
@property (nonatomic, strong) TXDiary *diary;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel; /** 显示时间 */
@property (strong, nonatomic) IBOutlet UITextField *diaryTitle; /** 日记标题 */
@property (strong, nonatomic) IBOutlet UITextView *diaryContent; /** 日记内容 */


@end
