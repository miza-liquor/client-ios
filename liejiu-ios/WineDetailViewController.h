//
//  WineDetailViewController.h
//  liquor-ios
//
//  Created by Minzhang Wei on 1/6/15.
//  Copyright (c) 2015 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineTabBarTableViewCell.h"
#import "WineDrinkUserTableViewCell.h"
#import "MenuListViewController.h"

@interface WineDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, WineDrinkUserTableViewCellDelegate, MenuListViewControllerDelegate>

@property (nonatomic) NSDictionary *basicInfo;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
