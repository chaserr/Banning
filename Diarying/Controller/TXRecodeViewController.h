//
//  TXRecodeViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TXDiary.h"
@class TXRecodeViewController;
@protocol RecordViewControllerDelegate <NSObject>

- (void)recordViewControllerDidReturn: (TXRecodeViewController *)recordViewController;

@end
@interface TXRecodeViewController : UIViewController
<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel  *recordInfo;

@property (weak, nonatomic) id <RecordViewControllerDelegate> delagate;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer   *audioPlayer;
@property (strong, nonatomic) TXDiary           *diary;
@property (weak, nonatomic) IBOutlet UIButton *recordBUtton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
/** 录音按钮 */
- (IBAction)recrodOption:(UIButton *)sender;

/** 播放录音 */
- (IBAction)playOption:(UIButton *)sender;
/** 录音文件路径 */
- (NSString *)audioRecordingPath;
/** 录音设置 */
- (NSDictionary *)audioRecordingSettings;
@end
