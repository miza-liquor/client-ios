//
//  AddFriendViewController.h
//  liejiu-ios
//
//  Created by Minzhang Wei on 11/19/14.
//  Copyright (c) 2014 Minzhang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserRecommHeadTableViewCell.h"
#import "UserFromRecommandTableViewCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "UIViewController+MMDrawerController.h"

@interface AddFriendViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UserRecommHeadTableViewCellDelegate, UserFromRecommandTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;


@end
