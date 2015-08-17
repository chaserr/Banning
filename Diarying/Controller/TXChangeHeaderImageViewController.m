//
//  TXChangeHeaderImageViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXChangeHeaderImageViewController.h"
#import "TXChangeHeaderImageTableViewCell.h"
#import "TXHeaderImage.h"
#import "TXSaveUsrSetting.h"
@interface TXChangeHeaderImageViewController ()<UITableViewDelegate, UITableViewDataSource>
{
/** 记录选中的cell */
    NSInteger _index;
}


@property (nonatomic, strong) UIImageView *headView;
/** 顶部视图 */
@property (strong, nonatomic) IBOutlet UIImageView *headView_iamgeView;
/** tableView */
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allImageDataArray;
@end

@implementation TXChangeHeaderImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _index = -1;
    // 获取图片源
    
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTarget:self action:@selector(back:) image:@"v2_btn_back2.png" highImage:@"v2_btn_back2.png"];

//
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title = @"设置封面壁纸";
    [self getHeaderImageData];
    

}


#pragma mark -- 加载顶部视图图片源
- (void)getHeaderImageData{

    
    // 1. 获取plist文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HeadImage" ofType:@".plist"];
    // 2. 根据路径获取plist文件内容将其存储在字典
    NSArray *allDataArray = [NSArray arrayWithContentsOfFile:filePath];
    // 3. 遍历数据
    for (NSDictionary *dict in allDataArray) {
        
        NSLog(@"%@", dict);
       TXHeaderImage * txHeaderImage = [TXHeaderImage headerImageWithDict:dict];
        [self.allImageDataArray addObject:txHeaderImage];
        
    }
    
}

#pragma mark -- tableView dataSource and delegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.allImageDataArray.count;
}

// 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TXChangeHeaderImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TXChangeHeaderImageTableViewCell"];
    if (cell == nil) {
        
        cell = [TXChangeHeaderImageTableViewCell defaultCell];
    }
    

    TXHeaderImage *txHeaderImage = _allImageDataArray[indexPath.row];
    cell.txHeadImage = txHeaderImage;
    
    if (_index == indexPath.row) {
        
       cell.selectImage.selected = YES;
        
    }else{

        cell.selectImage.selected = NO;
    }

    
    // 恢复之前点击状态
    if (_allImageDataArray.count != 0) {
        
        NSInteger headerImage_i = [[TXSaveUsrSetting sharedTXSaveUsrSetting] headerImage_i];
        if (headerImage_i == indexPath.row) {
            cell.selectImage.selected = YES;
            
//            [self.headView_iamgeView setImage:[UIImage imageNamed:self.allImageDataArray[headerImage_i]]];
        }
    }
    
    
    
    return cell;
}


// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}

// 分区头部视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return @"更换壁纸";
}

// 分区头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    // 得到最后一次选中的cell(_index 如果给一个负数，那么会得到一个nil或者最大的值)
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:0];
    // 上一次选中的cell
    TXChangeHeaderImageTableViewCell *lastCell = (TXChangeHeaderImageTableViewCell *)[tableView cellForRowAtIndexPath:lastIndex];
    lastCell.selectImage.selected = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[tableView visibleCells] enumerateObjectsUsingBlock:^(TXChangeHeaderImageTableViewCell *obj, NSUInteger idx, BOOL *stop) {
        if ([tableView indexPathForCell:obj].section == indexPath.section) {
            obj.selectImage.selected = NO;
//            [obj setAccessoryType:UITableViewCellAccessoryNone];
        }
    }];
//    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    TXChangeHeaderImageTableViewCell *cell = (TXChangeHeaderImageTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectImage.selected = YES;
    
    self.headView_iamgeView.image = [UIImage imageNamed:cell.txHeadImage.imageName];
    
    // 记录本次点击的cell位置解决重用问题
    _index = indexPath.row;
    
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] setUsr_headerImage:_index];
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] synchronized];
    
    self.headImageNameBlock(cell.txHeadImage.imageName);
    
    
}

#pragma mark -- 返回按钮
- (void)back:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 把选中的headView传到上一个页面
    
    
}

// 懒加载
- (NSMutableArray *)allImageDataArray{
    
    if (!_allImageDataArray) {
        self.allImageDataArray = [NSMutableArray array];
    }
    return _allImageDataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
