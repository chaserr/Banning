//
//  TXEditDiaryViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXEditDiaryViewController.h"
#import "UIImage+MJ.h"
#import "TXSelectMonthViewController.h"
@interface TXEditDiaryViewController ()<UITextViewDelegate>

/** 背景图片 */
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
/** 文字编辑区域 */
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSMutableArray *imageNameArray;
@property (strong, nonatomic) IBOutlet UILabel *placeholder_label;
/** 心情 */
@property (strong, nonatomic) IBOutlet UIImageView *weatherImage;
/** 天气 */
@property (strong, nonatomic) IBOutlet UIImageView *moodImage;
/** 工具栏 */
@property (strong, nonatomic) IBOutlet UIToolbar *tooBar;
/** 返回 */
@property (strong, nonatomic) IBOutlet UIBarButtonItem *back;
/** 相机 */
@property (strong, nonatomic) IBOutlet UIBarButtonItem *camera;
/** 录音 */
@property (strong, nonatomic) IBOutlet UIBarButtonItem *record;
/** 保存 */
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveDiary;

@end

@implementation TXEditDiaryViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    // 布局toolBar
    [self layoutToolBar];
  
    // 随机设置编辑背景
    NSString *imageName = [NSString stringWithFormat:@"txt_theme%02d.jpg", arc4random_uniform(59)];
    
    self.backgroundImage.image = [UIImage imageNamed:imageName];
    
    // 添加心情
    UITapGestureRecognizer *tapGesture_weather = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMonthImage:)];
    [self.weatherImage addGestureRecognizer:tapGesture_weather];
    UITapGestureRecognizer *tapGesture_mood = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMonthImage:)];
    [self.moodImage addGestureRecognizer:tapGesture_mood];
    
    
    self.diary = [[TXDiary alloc] init];

    [self showTime];

}

#pragma mark -- 布局toolBar
- (void)layoutToolBar{

    self.back = [UIBarButtonItem itemWithTarget:self action:@selector(doBack:) image:@"v2_btn_back2" highImage:@"v2_btn_back2"];
    self.camera = [UIBarButtonItem itemWithTarget:self action:@selector(selectPicture:) image:@"widget_photo" highImage:@"widget_photo"];
    self.record = [UIBarButtonItem itemWithTarget:self action:@selector(doRecord:) image:@"widget_audio" highImage:@"widget_audio"];
    self.saveDiary = [UIBarButtonItem itemWithTarget:self action:@selector(saveDiary:) image:@"pdm_2_settings" highImage:@"pdm_2_settings"];
    
    UIBarButtonItem *fieldibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    self.tooBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    [_tooBar setItems:@[_back, _camera, _record, fieldibleItem, _saveDiary] animated:YES];
    [_tooBar setBarTintColor:TXColor(243, 221, 238)];
    [self.view addSubview:_tooBar];
    
}

#pragma mark -- textView delegate
- (void)textViewDidChange:(UITextView *)textView{

// 设置textView默认显示的文字
    if (textView.text.length == 0) {
    
        _placeholder_label.hidden = NO;
    }else{
    
        _placeholder_label.hidden = YES;
    }
}

#pragma mark -- 显示时间
- (void)showTime{

    [self.timeLabel sizeToFit];
    NSString *string = [NSDate show_zh_CN_accurateTime];
    self.timeLabel.text = string;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}

- (void)updateTime:(NSTimer *)timer{

    NSString *string = [NSDate show_zh_CN_accurateTime];
    self.timeLabel.text = string;
}

#pragma mark -- toolBar-->BarButtonItem
// 相机
- (void)selectPicture:(UIBarButtonItem *)sender{
    
    NSLog(@"选择相机");
    [self performSegueWithIdentifier:@"TakePicture" sender:sender];
}

// 返回
- (void)doBack:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// 录音
- (void)doRecord:(UIBarButtonItem *)sender{
    
    NSLog(@"录音");
    [self performSegueWithIdentifier:@"Record" sender:sender];
}

#pragma mark -- 保存日记
- (void)saveDiary:(id)sender {

    self.diary.m_title   = self.diaryTitle.text;
    self.diary.m_content = self.diaryContent.text;

    
    if ([_delegate respondsToSelector:@selector(createDiaryViewController:didSaveWithDiary:)]) {
        [_delegate createDiaryViewController:self didSaveWithDiary:self.diary];
    }
    
    
    
    
    
    // 保存通知
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.diary forKey:@"saveDiary"];
    NSNotification *saveDiaryNotification = [NSNotification notificationWithName:@"saveDiary" object:nil userInfo:userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotification:saveDiaryNotification];
    
}



#pragma mark -- 添加心情
- (void)selectMonthImage:(UITapGestureRecognizer *)tapGesture{

    NSLog(@"进入添加心情页面");
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Diarying" bundle:[NSBundle mainBundle]];
    
    TXSelectMonthViewController *selectMonthImageVC = [storyBoard instantiateViewControllerWithIdentifier:@"MonthImageViewController"];
    // 1. 设置展示样式为自定义(必须)
    selectMonthImageVC.modalPresentationStyle = UIModalPresentationCustom;
    
    // 2. 设置代理
    /** 告诉哪一个控制器来给将要model出来的控制器提供动画 */
    selectMonthImageVC.transitioningDelegate = [TXTransition sharedtransition];
    
    selectMonthImageVC.moodImageNameBlock = ^(NSString *weatherImage, NSString *moodImage){
        
        [self.weatherImage setImage:[UIImage imageNamed:weatherImage]];
        [self.moodImage setImage:[UIImage imageNamed:moodImage]];
      
        self.diary.moodImageName = moodImage;
        self.diary.weatherImageName = weatherImage;
        
    };
    
    [self presentViewController:selectMonthImageVC animated:YES completion:nil];

    
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

#pragma mark - UITextFieldDelegate method
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}


#pragma mark - camera view controller delegate method
- (void) cameraViewControllerDidReturn:(TXAddPictureViewController *)cameraViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - record view controller delegate method
- (void)recordViewControllerDidReturn:(TXRecodeViewController *)recordViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     
     if ([segue.identifier isEqualToString:@"TakePicture"]) {
         TXAddPictureViewController *cameraViewController = (TXAddPictureViewController *)[segue destinationViewController];
         cameraViewController.delegate = self;
         NSLog(@"调用到这里");
         
         cameraViewController.diary = self.diary;
     }
     
     if ([segue.identifier isEqualToString:@"Record"]) {
         TXRecodeViewController *recordViewController = (TXRecodeViewController *)[segue destinationViewController];
         recordViewController.delagate = self;
         
         recordViewController.diary = self.diary;
     }
     
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
