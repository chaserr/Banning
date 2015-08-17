//
//  TXDiaryingTableViewController.h
//  Banning
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXEditDiaryViewController.h"
#import "TXDiaryDetailViewController.h"
@interface TXDiaryingTableViewController : UITableViewController<TXEditDiaryViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *m_diarise;
@property (nonatomic, strong) UIColor *m_diaryTitleColor;
@property (nonatomic, strong) UIRefreshControl *refresh;

@end
