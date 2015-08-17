//
//  TXDiaryDetailViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXDiary.h"
#import <AVFoundation/AVFoundation.h>
@interface TXDiaryDetailViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) TXDiary *m_diary;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

/** 日记标题 */
@property (strong, nonatomic) IBOutlet UILabel *diaryTitle;
/** 日记内容 */
@property (strong, nonatomic) IBOutlet UITextView *diaryContent;
/** 日记图片 */
@property (strong, nonatomic) IBOutlet UIImageView *diaryPhoto;
/** 播放录音按钮 */
@property (strong, nonatomic) IBOutlet UIButton *audioButton;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
/** 播放录音 */
- (IBAction)playAudio:(id)sender;

// 长按时出现警告
@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;
@end
