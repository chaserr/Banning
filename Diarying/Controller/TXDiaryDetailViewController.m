//
//  TXDiaryDetailViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXDiaryDetailViewController.h"
#import "TXImageStore.h"
@interface TXDiaryDetailViewController ()
/** 背景图片 */
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) IBOutlet UIImageView *weatherImageView;

@property (strong, nonatomic) IBOutlet UIImageView *moodImageView;

@end

@implementation TXDiaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 随机设置编辑背景
    NSString *imageName = [NSString stringWithFormat:@"txt_theme%02d.jpg", arc4random_uniform(59)];
    
    self.backgroundImage.image = [UIImage imageNamed:imageName];
    
    // 添加长按警告
    self.diaryPhoto.userInteractionEnabled = YES;
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePhoto:)];
    self.longPressGestureRecognizer.numberOfTapsRequired = 1;
    self.longPressGestureRecognizer.minimumPressDuration = 1.0;
    [self.diaryPhoto addGestureRecognizer:_longPressGestureRecognizer];
    
    // ios7之后scrollerView所有的子类都默认向下偏移64
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.diaryTitle.text = self.m_diary.m_title;
    self.diaryContent.text = self.m_diary.m_content;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy年MM月HH日:mm";
    formatter.dateFormat = @"yyyy-MM-dd HH:mm EEEE  ";
    NSString *dateString = [formatter stringFromDate:self.m_diary.m_dateCreate];
    self.timeLabel.text = dateString;
    
    NSString *photoKey = [self.m_diary m_photoKey];
    if (photoKey) {
        UIImage *imageToDisplay = [[TXImageStore defaultImageStore] imageForKey:photoKey];
        [self.diaryPhoto setImage:imageToDisplay];
    }else{
    
        [self.diaryPhoto setImage:nil];
    }
    
    NSString *audioFileName = [self.m_diary m_audioFileName];
    if (audioFileName) {
        [self.audioButton setHidden:NO];
    }else{
    
        [self.audioButton setHidden:YES];
    }
    
    // 设置表情
    
    [self.weatherImageView setImage:[UIImage imageNamed:self.m_diary.weatherImageName]];
    [self.moodImageView setImage:[UIImage imageNamed:self.m_diary.moodImageName]];
    
    [[self navigationItem] setTitle:NSLocalizedString(@"Diary Content", @"导航栏中所显示的标题")];
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -- 播放录音
- (IBAction)playAudio:(id)sender {
    
    NSLog(@"播放");
    NSArray  *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    
    NSData   *fileData = [NSData dataWithContentsOfFile:[documentsFolder stringByAppendingPathComponent:self.m_diary.m_audioFileName]];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
    
    if(setCategoryError){
        NSLog(@"%@", [setCategoryError description]);
    }
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    
    // 开始播放音频
    if (self.audioPlayer != nil) {
        if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]) {
            NSLog(@"正常播放音频文件");
        } else {
            NSLog(@"播放失败");
        }
    } else {
        NSLog(@"初始化 AVAudioPlayer 失败");
    }

}

#pragma mark -- 长按手势
- (void)handlePhoto:(UILongPressGestureRecognizer *)longPressGesture{

    if (longPressGesture.numberOfTapsRequired == 1 && longPressGesture.state == UIGestureRecognizerStateBegan) {
        [self showAlert:@"用户在长按图片,分享吗"];
        [self showActionSheet];
        [longPressGesture setDelaysTouchesEnded:YES];
    }
}

#pragma mark - the alert view delegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *username = [alertView textFieldAtIndex:0].text;
    NSString *password = [alertView textFieldAtIndex:1].text;
    NSLog(@"用户名为：%@", username);
    NSLog(@"密码为：%@", password);
    NSLog(@"用户点击了%ld按钮", buttonIndex);
}

#pragma mark - the action sheet delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld 号按钮被按下", buttonIndex);
}

- (void)showAlert: (NSString *)theMessage
{
    // 警告视图共有四种不同的风格
    // 1 UIAlertViewStylePlainTextInput 可以输入文本内容
    // 2 UIAlertViewStyleSecureTextInput 输入的文本带有安全机制
    // 3 UIAlertViewStyleLoginAndPasswordInput 用来输入帐号和密码
    // 4 标准风格
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题" message:theMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alertView show];
}

- (void)showActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"标题" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除照片" otherButtonTitles:@"操作 1", @"操作 2", @"操作 3", nil];
    [actionSheet showInView:self.diaryPhoto];
}

@end
