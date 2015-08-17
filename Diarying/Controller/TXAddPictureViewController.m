//
//  TXAddPictureViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXAddPictureViewController.h"
#import "TXImageStore.h"
@interface TXAddPictureViewController ()
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *back;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *camera;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *picture;


@end

@implementation TXAddPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局toolBar
    [self layoutToolBar];
    
}

#pragma mark -- 布局toolBar
- (void)layoutToolBar{
    
    self.back = [UIBarButtonItem itemWithTarget:self action:@selector(doBack:) image:@"v2_btn_back2" highImage:@"v2_btn_back2"];
    self.camera = [UIBarButtonItem itemWithTarget:self action:@selector(invokeSystemPicture:) image:@"cnt_takephoto_before" highImage:@"cnt_takephoto_before"];
    _camera.tag = 1000;
    self.picture = [UIBarButtonItem itemWithTarget:self action:@selector(invokeSystemPicture_photo:) image:@"acc_mang_img" highImage:@"acc_mang_img"];
    _picture.tag = 1001;
    
    UIBarButtonItem *fieldibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    [_toolBar setItems:@[_back, fieldibleItem, _picture, _camera] animated:YES];
    [_toolBar setBarTintColor:TXColor(243, 221, 238)];
    [self.view addSubview:_toolBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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


#pragma mark -- 返回按钮
- (void)doBack:(id)sender {
//    if ([_delegate respondsToSelector:@selector(cameraViewControllerDidReturn:)]) {
//        [_delegate cameraViewControllerDidReturn:self];
//    }
        [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 调用系统相册/相机
// 相机
- (void)invokeSystemPicture:(UIButton *)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];

    // 设置delegate属性，使它指向当前控制器
    imagePicker.delegate = self;
    // 将UIImageViewController的视图呈现在屏幕上
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 图库
- (void)invokeSystemPicture_photo:(id)sender{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 将UIImageViewController的视图呈现在屏幕上
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark --UIImagePickerController Delegate
// 相册图片选中后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    NSString *oldPhotoKey = [self.diary m_photoKey];
    
    if (oldPhotoKey) {
        // 删除之间的老照片
        [[TXImageStore defaultImageStore] deleteImageForKey:oldPhotoKey];
    }
    // 从info中获取用户选择的照片信息
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 创建CFUUIDRef类型的对象，这个类型是Core Foundation中的唯一标识符UUID字符串，Core Foundation 是C语言的API接口，一般依CF开头Ref结尾
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    // 创建一个字符串
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    [self.diary setM_photoKey:(__bridge NSString *)newUniqueIDString]; // __bridge告诉编译器所赋值对象的引用计数器的值保持不变
    // 前面创建的Core Foundation，在不使用的时候需要释放
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    // 使用键名将图片存入ImageStore
    [[TXImageStore defaultImageStore] setImage:image forKey:[self.diary m_photoKey]];
    
    [self.showSystemPicture setImage:image];
    // 销毁UIImagePickerController控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 取消选中按钮点击事件
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self dismissViewControllerAnimated:YES completion:nil];
    
};



@end
