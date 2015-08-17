//
//  TXSelectMonthViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXSelectMonthViewController.h"
#import "TXMonthImage.h"
#import "TXWeatherImage.h"
#import "TXMonthImageCollectionViewCell.h"
#import "TXMonthImageCollectionReusableView_header.h"
#import "TXSaveUsrSetting.h"
@interface TXSelectMonthViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    /** 记录选中的cell */
    NSInteger _index;
    
}
@property (nonatomic, strong) NSMutableDictionary *saveSelectItemIndex;
@property (nonatomic, strong) NSMutableArray *dataArray_mood;
@property (nonatomic, strong) NSMutableArray *dataArray_weather;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TXSelectMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveSelectItemIndex = [NSMutableDictionary dictionary];
    _index = -1;
    // 布局collectionView
    [self layoutCollectionView];
    
}


#pragma mark -- 布局collectionView
- (void)layoutCollectionView{

    self.dataArray_mood = [NSMutableArray array];
    self.dataArray_weather = [NSMutableArray array];
    
    // 提供系统网络布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
    _collectionView.userInteractionEnabled = YES;
    
    // 从本地JSON文件得到图片数据(天气)
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MonthImageResource" ofType:@"json"]];
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    /** 天气图片 */
    NSArray *array_weather = allDataDictionary[@"weather"];
    for (NSDictionary *dict in array_weather) {
        
        TXWeatherImage *weatherImage = [TXWeatherImage txWeatherImageWithDict:dict];
        [_dataArray_weather addObject:weatherImage];
    }
    /** 心情图片 */
    NSArray *array_mood = allDataDictionary[@"mood"];
    for (NSDictionary *dict in array_mood) {
        TXMonthImage *monthImage = [TXMonthImage txMonthImageWithDict:dict];
        [_dataArray_mood addObject:monthImage];
    }

    [self.collectionView reloadData];
    
    
    // 在竖直方向滑动的时候代表行间距,(水平方向滑动的时候代表最小列间距)
    flowLayout.minimumLineSpacing = 5;
    
    //    在水平方向滑动的时候代表的是最小行间距,在竖直方向滑动代表的是最小列间距
    flowLayout.minimumInteritemSpacing = 10;
    
    // 设置滑动方向, 默认竖直方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 设置item大小
    flowLayout.itemSize = CGSizeMake(50, 50);
    
    // item距离分区边界的位置
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 5, 10);
    
    // 注册可重用的identifier
    [_collectionView registerClass:[TXMonthImageCollectionViewCell class] forCellWithReuseIdentifier:@"pictureItem"];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];

    flowLayout.headerReferenceSize = CGSizeMake(400, 20);
//    flowLayout.footerReferenceSize = CGSizeMake(100, 90);
    // 增加分区头(头部附加视图)(需要注册)
    [_collectionView registerClass:[TXMonthImageCollectionReusableView_header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

#pragma mark -- delegate and datasource method
// item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArray_weather.count;
    }else{
    
        return _dataArray_mood.count;
    }
    
}

// 设置分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 2;
}

// 设置头部分区
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *UICollectionReusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        TXMonthImageCollectionReusableView_header *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        if (indexPath.section == 0) {
        
            headView.label.text = @"天气";
        }else{
        
            headView.label.text = @"心情";
        }

        
        UICollectionReusableView = headView;
        
    }
    return UICollectionReusableView;
    
}

// 绘制item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
        TXMonthImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureItem" forIndexPath:indexPath];
    
        if (indexPath.section == 0) {
        
        TXWeatherImage *weatherImage = self.dataArray_weather[indexPath.item];
        [cell.imageView setImage:[UIImage imageNamed:weatherImage.weatherImageName]];
        
        }else{
            TXMonthImage *moodImage = self.dataArray_mood[indexPath.item];
        [cell.imageView setImage:[UIImage imageNamed:moodImage.moodImageName]];

    }

    return cell;
    
}

// 选中item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"选中了%ld", indexPath.item);
    
        // 得到最后一次选中的cell(_index 如果给一个负数，那么会得到一个nil或者最大的值)
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:indexPath.section];
        //     上一次选中的cell
        TXMonthImageCollectionViewCell *lastItem = (TXMonthImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:lastIndex];
        
        lastItem.selectimage.selected = NO;
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        [[collectionView visibleCells] enumerateObjectsUsingBlock:^(TXMonthImageCollectionViewCell *obj, NSUInteger idx, BOOL *stop) {
            if ([collectionView indexPathForCell:obj].section == indexPath.section) {
                obj.selectimage.selected = NO;
            }
        }];
        
        TXMonthImageCollectionViewCell *cell = (TXMonthImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.selectimage.selected = YES;
        
        // 记录本次点击的cell位置解决重用问题
        _index = indexPath.row;
    
    if (indexPath.section == 0) {
        [self.saveSelectItemIndex setValue:_dataArray_weather[indexPath.row] forKey:@"weatherImage"];
    }else{
    
        [self.saveSelectItemIndex setValue:_dataArray_mood[indexPath.row] forKey:@"moodImage"];
    }
    
    NSLog(@"%@", [self.saveSelectItemIndex description]);
    
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] setUsr_moodImage:_index];
    [[TXSaveUsrSetting sharedTXSaveUsrSetting] synchronized];
    ;
    
    
    
}


// 返回按钮
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 确定按钮
- (IBAction)ensure:(id)sender {
    TXMonthImage *moodImage = [_saveSelectItemIndex objectForKey:@"moodImage"];
    NSString *moodImageName = moodImage.moodImageName;
    
    TXWeatherImage *weathreImage = [_saveSelectItemIndex objectForKey:@"weatherImage"];
    NSString *weatherImageName = weathreImage.weatherImageName;
    self.moodImageNameBlock(weatherImageName, moodImageName);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
