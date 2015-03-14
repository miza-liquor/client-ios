//
//  FollowListViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/21/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowUserListTableViewCell.h"

@interface FollowListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FollowUserListTableViewCellDelegate>

@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *followType;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
