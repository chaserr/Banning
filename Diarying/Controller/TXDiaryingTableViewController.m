//
//  TXDiaryingTableViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXDiaryingTableViewController.h"
#import "TXEditDiaryViewController.h"
#import "TXDiaryDetailViewController.h"
#import "TXDiary.h"
#import "TXDiaryStory.h"
#import "TXNoneRecode.h"
#import "TXChangeHeaderImageViewController.h"
#import "TXDataBaseHandle.h"
#import "TXTableViewHeader.h"
@interface TXDiaryingTableViewController ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) TXDataBaseHandle *databaseHnadle;

@end

@implementation TXDiaryingTableViewController


- (void)viewDidLoad {
  
    [super viewDidLoad];
     self.databaseHnadle = [TXDataBaseHandle sharedTXDataBaseHandle];
    // 从数据库中取出数据
    NSArray *dataArray = [self.databaseHnadle queryDiary];
     self.m_diarise  = [NSMutableArray arrayWithArray:dataArray];
    
    // 加载headView
    [self loadHeadView];
    
    // 刷新按钮
    [self doRefresh];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save_Diary:) name:@"saveDiary" object:nil];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(prepareForSegue_write:) image:@"pdm_1_write_diary.png" highImage:@"pdm_1_write_diary.png"];

   
}

// 使用通知保存日记
- (void)save_Diary:(NSNotification *)notification{

    NSDictionary *userInfo = notification.userInfo;
    TXDiary *diary = userInfo[@"saveDiary"];
    
//    NSString *timeString =[diary.m_dateCreate changeDateToString:diary.m_dateCreate];
    
    
    // 存入数据库
    [self.databaseHnadle saveDiaries:diary];
    
        NSLog(@"title:%@, content:%@", diary.m_title, diary.m_content);
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.m_diarise addObject:diary];
        [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//    self.m_diarise = (NSMutableArray *)[[TXDiaryStory defaultStore] diaries];

    [self layoutNoneRecode];
        self.m_diaryTitleColor = [self diaryTitleColorFromPreferenceSpecifiers];
//    NSLog(@"日记标题的颜色为 %@", self.m_diaryTitleColor);
    
}

#pragma mark -- 当没有记录的时候
- (void)layoutNoneRecode{
    if (self.m_diarise.count == 0) {
        
        TXNoneRecode *noneRecodeView = [TXNoneRecode defaultnoneRecodeView];
        UITapGestureRecognizer *tapGesture_top = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editDiaryies:)];
        UITapGestureRecognizer *tapGesture_down = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editDiaryies:)];
        [noneRecodeView.descriptionTop addGestureRecognizer:tapGesture_top];
        [noneRecodeView.descriptionWithDown addGestureRecognizer:tapGesture_down];
        self.tableView.tableFooterView = noneRecodeView;
        
    }else{
        
        self.tableView.tableFooterView = [[UIView alloc] init];
    }

}

#pragma mark -- 加载headView
- (void)loadHeadView{
    
    TXTableViewHeader *headerView = [TXTableViewHeader defaultTableviewHeader];

    self.tableView.tableHeaderView = headerView;
    
    self.headerImageView = headerView.headerView_headimage;
    headerView.headerView_timelabel.text = [NSDate show_zh_CN_time];
  
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadImage:)];
    [self.headerImageView addGestureRecognizer:tapGesture];
    
}


#pragma mark -- 轻拍进入写日记界面
- (void)editDiaryies:(UITapGestureRecognizer *)tapGesture{

    [self performSegueWithIdentifier:@"AddDiary" sender:tapGesture];
    
}

#pragma mark - Tableview delegate and datasource

// 返回section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

// 返回section的cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.m_diarise.count;
}


// 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaryingCell" forIndexPath:indexPath];
    
    [tableView.tableFooterView removeFromSuperview];
    
    TXDiary *diary = [self.m_diarise objectAtIndex:indexPath.row];
    
    // 设置日记条目的标题

    cell.textLabel.text = [diary m_title];
    cell.textLabel.textColor = self.m_diaryTitleColor;
    cell.detailTextLabel.text = [self showDiaryCreateDateLocales:[diary m_dateCreate]];
//    cell.textLabel.text = @"刘亦菲我爱你";
    return cell;
}

// 设置tableview 可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// 实现cell滑动可删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
//        NSArray *diarys = [[TXDiaryStory defaultStore] diaries];
//        TXDiary *diary = [diarys objectAtIndex:indexPath.row];
//        [[TXDiaryStory defaultStore] removeDiary:diary];

        TXDiary *diary = [self.m_diarise objectAtIndex:indexPath.row];
        // 把时间转化为时间戳
        NSString *timeString =[diary.m_dateCreate changeDateToString:diary.m_dateCreate];
        [self.databaseHnadle deleteDiaries:timeString];
        [self.m_diarise removeObject:diary];
        // 从表格视图中移除被删除的单元格
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [tableView reloadData];
        
        [self layoutNoneRecode];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - 标题颜色和创建日期
- (UIColor *)diaryTitleColorFromPreferenceSpecifiers
{
    // 获取应用程序配置选项的实例
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 根据diaryTitleCorlor的值设置表格中日记标题的颜色
    if ([[defaults objectForKey:@"diaryTitleColor"] isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else if ([[defaults objectForKey:@"diaryTitleColor"] isEqualToString:@"red"]){
        return [UIColor redColor];
    } else if ([[defaults objectForKey:@"diaryTitleColor"] isEqualToString:@"green"]) {
        return [UIColor greenColor];
    } else if ([[defaults objectForKey:@"diaryTitleColor"] isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else {
        return [UIColor blackColor];
    }
}

- (NSString *)showDiaryCreateDateLocales: (NSDate *)dateCreate
{
    // 通过NSLocale获取当前区域的国家代码
    NSString *country_ = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    // 控制台显示国家代码
    NSLog(@"%@", country_);
    // 实例化NSDateFormatter对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yy年M月d日 hh:mm a"];
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    
    // 实例化NSLocale对象
    NSLocale *locale = [NSLocale currentLocale];
    // 设置formatter的locale属性
    [formatter setLocale:locale];
    // 将NSDate对象格式化成当前区域的时间字符串并返回
    return [formatter stringFromDate:dateCreate];
}


#pragma mark -- 下拉刷新
- (void)doRefresh{

    self.refresh = [[UIRefreshControl alloc] init];
    self.refreshControl = self.refresh;
    [self.refresh addTarget:self action:@selector(handleRefresh:) forControlEvents:(UIControlEventValueChanged)];
    
}

- (void)handleRefresh:(UIRefreshControl *)refresh{

    if (self.refresh.refreshing) {
        NSLog(@"表格正在刷新");
        self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"努力加载中..."];
        [self layoutNoneRecode];
    }
    [self.refresh endRefreshing];
    [self.tableView reloadData];
}



#pragma mark -- 下拉的时候让头像变大
/*
// 下拉的时候图片到一定的偏移量就会放大
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float offsetY = - (64 + scrollView.contentOffset.y); // 计算scrollerView的偏移量,取反
    if (offsetY > 0) {

        CATransform3D trans = CATransform3DMakeScale(1, 1 + (offsetY / 100), 1.0);
        [self.headView.layer setTransform:trans];
        

    }

}
*/


#pragma mark -- 改变头部视图图片
- (void)changeHeadImage:(UITapGestureRecognizer *)tapGesture{

    NSLog(@"更换主题");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Diarying" bundle:[NSBundle mainBundle]];
    
    TXChangeHeaderImageViewController *changeHeaderImageVC = [storyBoard instantiateViewControllerWithIdentifier:@"ChangeHeadImage"];
    // 1. 设置展示样式为自定义(必须)
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:changeHeaderImageVC];
    [navigationVC.navigationBar setBarTintColor:TXColor(243, 221, 238)];
    navigationVC.modalPresentationStyle = UIModalPresentationCustom;
    
    // 2. 设置代理
    /** 告诉哪一个控制器来给将要model出来的控制器提供动画 */
    navigationVC.transitioningDelegate = [TXTransition sharedtransition];
    
    changeHeaderImageVC.headImageNameBlock = ^(NSString *headerImageName){
    
        self.headerImageView.image = [UIImage imageNamed:headerImageName];
    };
    
    [self presentViewController:navigationVC animated:YES completion:nil];

    
}


#pragma mark -- 右边Item
- (void)prepareForSegue_write:(UIBarButtonItem *)sender{

    [self performSegueWithIdentifier:@"AddDiary" sender:sender];
}

 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     if ([segue.identifier isEqualToString:@"DetailDiary"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         TXDiary *diary = [self.m_diarise objectAtIndex:indexPath.row];
         TXDiaryDetailViewController *detailVC = (TXDiaryDetailViewController *)[segue destinationViewController];
         detailVC.m_diary = diary;
     }
     
     if ([segue.identifier isEqualToString:@"AddDiary"]) {
         TXEditDiaryViewController *editDiaryVC = (TXEditDiaryViewController *)[segue destinationViewController];
         editDiaryVC.delegate = self;
         NSLog(@"进入到创建新日记的场景");
     }

 }

#pragma mark -- editDiaryVC delegate
/** 取消保存 */
- (void) createDiaryViewControllerDidCancel: (TXEditDiaryViewController *)createDiaryController{

    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"点击了返回按钮,取消保存");
}
/** 保存日记 */
- (void) createDiaryViewController: (TXEditDiaryViewController *)createDiaryController didSaveWithDiary: (TXDiary *)theDiary{
    NSLog(@"使用代理saveDiary");
//    TXDiary *diary = theDiary;
//    NSLog(@"title:%@, content:%@", diary.m_title, diary.m_content);
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.m_diarise addObject:diary];
//    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{

    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
