//
//  MenuListViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/23/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMenuViewController.h"

@interface MenuListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,NewMenuViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic) NSDictionary *wineInfo;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
