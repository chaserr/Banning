//
//  TXCalendarConfigController.m
//  Banning
//
//  Created by lanou3g on 15/8/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXCalendarConfigController.h"

@interface TXCalendarConfigController ()

@end

@implementation TXCalendarConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.accessoryType = self.viewController.theme == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else if (indexPath.section == 1) {
        cell.accessoryType = self.viewController.lunar ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else if (indexPath.section == 2) {
        cell.accessoryType = indexPath.row == 1 - self.viewController.flow ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else if (indexPath.section == 4) {
        cell.accessoryType = indexPath.row == self.viewController.firstWeekday - 1 ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[tableView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([tableView indexPathForCell:obj].section == indexPath.section) {
            [obj setAccessoryType:UITableViewCellAccessoryNone];
        }
    }];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    if (indexPath.section == 0) {
        if (indexPath.row == self.viewController.theme) {
            return;
        }
        self.viewController.theme = indexPath.row;
    } else if (indexPath.section == 1) {
        self.viewController.lunar = !self.viewController.lunar;
        
    } else if (indexPath.section == 2) {
        if (self.viewController.flow == 1 - indexPath.row) {
            return;
        }
        self.viewController.flow = (FSCalendarFlow)(1-indexPath.row);
    } else if (indexPath.section == 3) {
        self.viewController.selectedDate = _datePicker.date;
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    } else if (indexPath.section == 4) {
        if (self.viewController.firstWeekday == indexPath.row + 1) {
            return;
        }
        self.viewController.firstWeekday = indexPath.row + 1;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
