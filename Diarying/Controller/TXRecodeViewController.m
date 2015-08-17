//
//  TXRecodeViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXRecodeViewController.h"

@interface TXRecodeViewController ()

@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doDismiss;

@end

@implementation TXRecodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.diary.m_audioFileName !=nil) {
        self.playButton.hidden = NO;
    }else{
    
        self.playButton.hidden = YES;
    }
    
    // 布局toolBar
    [self layoutToolBar];
    
}

#pragma mark -- 布局toolBar
- (void)layoutToolBar{
    
    self.doDismiss = [UIBarButtonItem itemWithTarget:self action:@selector(doDismiss:) image:@"v2_btn_back2" highImage:@"v2_btn_back2"];
    
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    [_toolBar setItems:@[_doDismiss] animated:YES];
    [_toolBar setBarTintColor:TXColor(243, 221, 238)];
    [self.view addSubview:_toolBar];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{

    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
        NSLog(@"录音结束");
    }
    self.audioRecorder = nil;
}

#pragma mark -- 录音
- (IBAction)recrodOption:(UIButton *)sender{
    NSError *error = nil;
    if ([sender.titleLabel.text isEqualToString:@"录音"]) {
        NSString *pathAsString = [self audioRecordingPath];
        NSURL *audioRecordingUrl = [NSURL fileURLWithPath:pathAsString];
//        iOS8特性
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *setCategoryError = nil;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
        
        if(setCategoryError){
            NSLog(@"%@", [setCategoryError description]);
        }
        self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:audioRecordingUrl settings:[self audioRecordingSettings] error:&error];
        if (self.audioRecorder != nil) {
            self.audioRecorder.delegate = self;
            
            if ([self.audioRecorder prepareToRecord] &&[self.audioRecorder record]) {
                self.recordBUtton.titleLabel.text = @"停止录音";
                [self.recordBUtton setTitle:@"停止录音" forState:(UIControlStateNormal)];
                self.recordInfo.text = @"成功开始录音";
            }else{
            
                self.recordInfo.text = @"录音失败";
                self.audioRecorder = nil;
            }
        }else{
        
            NSLog(@"创建audio recorder实例失败");
        }
        // 如果当前录音按钮的标题为停止录音,在用户点击时执行
        
    }else if([sender.titleLabel.text isEqualToString:@"停止录音"]){
        [self stopRecordingOnAudioRecorder:self.audioRecorder];
        self.recordInfo.text = @"录音结束";
        [self.recordBUtton setTitle:@"录音" forState:(UIControlStateNormal)];
    }

}

#pragma mark -- 播放
- (IBAction)playOption:(UIButton *)sender{

    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSData *fileData = [NSData dataWithContentsOfFile:[documentPath stringByAppendingPathComponent:self.diary.m_audioFileName]];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    
    // 开始播放录音
    if (self.audioPlayer != nil) {
        self.audioPlayer.delegate = self;
        if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]) {
            self.recordInfo.text = @"正常播放音频文件";
            
        }else{
        
            self.recordInfo.text = @"播放音频失败";
        }
    }else{
    
        NSLog(@"初始化avaudioPlayer 失败");
    }
}

#pragma mark -- 录音文件路径
- (NSString *)audioRecordingPath{

    NSString *path = nil;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [documentPath stringByAppendingPathComponent:@"Recording.m4a"];
    
    // 创建唯一ID
    CFUUIDRef   newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *fileName = (__bridge NSString *)newUniqueIDString;
    // 向字符串后面添加指定的文件扩展名
    self.diary.m_audioFileName = [fileName stringByAppendingPathExtension:@"m4a"];
    // 前面使用Create创建的Core Foundation,在不要使用的时候需要将其释放
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    path = [documentPath stringByAppendingPathComponent:self.diary.m_audioFileName];
    return path;
}

#pragma mark -- 录音设置
- (NSDictionary *)audioRecordingSettings{
    NSDictionary *result = nil;
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    // 设置录音格式
    [settings setValue:[NSNumber numberWithInteger:kAudioFormatAppleLossless] forKey:AVFormatIDKey];
    // 设置录音采样率
    [settings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    
    // 设置通道
    [settings setValue:[NSNumber numberWithInteger:1] forKey:AVNumberOfChannelsKey];
    
    //
    [settings setValue:[NSNumber numberWithInteger:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];
    result = [NSDictionary dictionaryWithDictionary:settings];
    return result;
    
}

#pragma mark -- 返回按钮
- (void)doDismiss:(id)sender {
    //    if ([_delagate respondsToSelector:@selector(recordViewControllerDidReturn:)]) {
    //        [_delagate recordViewControllerDidReturn:self];
    //    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark -- 停止录音
- (void)stopRecordingOnAudioRecorder: (AVAudioRecorder *)aRecorder
{
    [aRecorder stop];
}

#pragma mark -- AVAudio recorder delegate methods
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (flag) {
        NSLog(@"录音正常结束");
        [self.playButton setHidden:NO];
    }
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder
{
    NSLog(@"录音过程被中断");
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        NSLog(@"恢复录音");
        [recorder record];
    }
}

#pragma mark - AVAudio player delegate methods
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    // 如果有声音正在播放，则暂停
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionOptionShouldResume && player != nil) {
        [player play];
    }
}


/** 展示自定义model动画 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = [TXTransition sharedtransition];
    }
    return self;
}
@end
