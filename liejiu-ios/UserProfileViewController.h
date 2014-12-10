//
//  UserProfileViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfileInfoTableViewCell.h"
#import "UIViewController+MMDrawerController.h"

@interface UserProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UserProfileInfoTableViewCellDelegate>

@property (nonatomic) BOOL fromSubView;
@property (nonatomic) NSMutableDictionary *userInfo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
