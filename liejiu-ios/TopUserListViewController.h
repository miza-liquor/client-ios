//
//  TopUserListViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/18/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopUserTableViewCell.h"


@interface TopUserListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TopUserTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
